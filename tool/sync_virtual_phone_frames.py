#!/usr/bin/env python3
"""arts/phones のフレームと、arts/virtual-phone のマーケティング画像を virtual_phone に取り込む。

  python3 tool/sync_virtual_phone_frames.py          # PNG を焼き、Dart の HardwareScreen を書き換える
  python3 tool/sync_virtual_phone_frames.py --check  # 取り込み済みのものが arts と一致しているかだけ確かめる

正本は rubydogjp/arts/phones（phones.json と *.svg）。virtual_phone は縦持ちの画像1枚を持ち、
横持ちは画像を反時計回りに回して使うので、横長の絵は時計回りに回して縦持ちにする。
G1 とロトムは横持ちが基準の姿（arts で状態名の付かない id）なので、その絵を回して使う。
PNG は resvg で焼く（brew install resvg）。

bezelRatio は画像に対する画面の窓の比、logicalCornerRadius と safeArea は論理サイズへ換算した値。
safeArea は arts の insets（切り欠きと角丸を避けた寄せ）を縦持ち・横持ちに振り分けたもの。
"""
import json, pathlib, re, subprocess, sys, tempfile

ROOT = pathlib.Path(__file__).resolve().parent.parent
ARTS = ROOT.parent / "arts" / "phones"
VP = ROOT / "virtual_phone"
IMAGES = VP / "assets" / "images"
MODELS = VP / "lib" / "src" / "logic" / "device_model"
# そのまま写すもの (arts の生成物, パッケージ内の置き場所)。README の見出しの画像
COPIES = [(ROOT.parent / "arts" / "virtual-phone" / "marketing.png", VP / "static" / "marketing.png")]

# (アセット, arts の id, 時計回りに回す角度, 倍率, Dart ファイル or None, 架空の端末の (論理の幅, ピクセル比))
# 実機は arts の resolution / pixel_ratio から論理サイズを出す。論理の高さは窓の比から決まる。
FRAMES = [
    ("classic-iphone.png", "iphone-original", 0, 4, "classic_iphone.dart", None),
    ("classic-android.png", "android-g1", 90, 4, "classic_android.dart", None),
    ("nexus-one.png", "android-nexusone", 0, 4, "nexus_one.dart", None),
    ("pixel.png", "android-pixel-gen1", 0, 4, "pixel.dart", None),
    ("vphone-original.png", "rubydog-vphone-original", 0, 4, "vphone_original.dart", (320, 2)),
    ("vphone-2nd.png", "rubydog-vphone-2nd", 0, 4, "vphone_2nd.dart", (400, 3)),
    ("rotom.png", "rubydog-rotomphone", 90, 4, "rotom.dart", (432, 3)),        # 基準の横持ちを縦に回す
    ("g1-close.png", "android-g1-close", 0, 1, None, None),       # 今はどの機種からも使っていない
    ("rotom-landscape.png", "rubydog-rotomphone", 0, 1, None, None),  # 同上（rotom.png と同じ絵を回さずに 1 倍で）
]


def num(v, nd=6):
    s = f"{v:.{nd}f}".rstrip("0").rstrip(".")
    return "0" if s in ("", "-0") else s


def rotated(rec, deg):
    """arts の窓・寄せを、時計回りに deg 回した縦持ちの画像の座標へ。"""
    W, H = rec["size"]
    d, ins = rec["display"], rec["insets"]
    x, y, w, h = d["x"], d["y"], d["width"], d["height"]
    if deg == 0:
        return (W, H), (x, y, w, h), dict(ins)
    assert deg == 90
    # 時計回り: (x, y) → (H - y, x)。上→右、右→下、下→左、左→上
    return (H, W), (H - y - h, x, h, w), dict(top=ins["left"], right=ins["top"], bottom=ins["right"], left=ins["bottom"])


def screen(rec, deg, fantasy):
    (W, H), (x, y, w, h), p = rotated(rec, deg)
    assert h >= w, f"{rec['id']}: 縦持ちの画像にならない"
    if fantasy is None:
        rw, rh = sorted(rec["resolution"])
        ratio = rec["pixel_ratio"]
        lw, lh = rw / ratio, rh / ratio
    else:
        lw, ratio = fantasy
        lh = lw * h / w
    assert abs(lw / lh - w / h) < 1e-9, f"{rec['id']}: 窓 {w}×{h} と論理 {lw}×{lh} の比が違う"
    k = lw / w                                   # 画像の座標 → 論理
    bezel = dict(left=x / W, top=y / H, right=(W - x - w) / W, bottom=(H - y - h) / H)
    portrait = {s: p[s] * k for s in ("left", "top", "right", "bottom")}
    # virtual_phone の横持ち = 縦持ちの画像を反時計回り: 上→左、右→上、下→右、左→下
    landscape = dict(left=portrait["top"], top=portrait["right"], right=portrait["bottom"], bottom=portrait["left"])
    # 画像の縦横比が、HardwareDeviceView が比と論理サイズから逆算する値と一致すること
    ar = (lw / lh) * (1 - bezel["top"] - bezel["bottom"]) / (1 - bezel["left"] - bezel["right"])
    assert abs(ar - W / H) < 1e-6, (rec["id"], ar, W / H)
    return dict(size=(W, H), bezel=bezel, lw=lw, lh=lh, radius=rec["display"]["radius"] * k, ratio=ratio,
                portrait=portrait, landscape=landscape)


def dart_block(s):
    def inset(e, pad):
        if not any(e.values()):
            return "EdgeInset.zero"
        q = " " * pad
        return "EdgeInset(\n" + "".join(f"{q}  {k}: {num(e[k], 2)},\n" for k in ("left", "top", "right", "bottom")) + f"{q})"
    b = s["bezel"]
    return ("hardwareScreen: const HardwareScreen(\n"
            "    bezelRatio: BezelRatio(\n"
            + "".join(f"      {k}: {num(b[k])},\n" for k in ("left", "top", "right", "bottom")) +
            "    ),\n"
            f"    logicalWidth: {num(s['lw'], 4)},\n"
            f"    logicalHeight: {num(s['lh'], 4)},\n"
            f"    logicalCornerRadius: {num(s['radius'], 2)},\n"
            f"    pixelRatio: {num(s['ratio'], 3)},\n"
            "    safeArea: DeviceSafeArea(\n"
            f"      portrait: {inset(s['portrait'], 6)},\n"
            f"      landscape: {inset(s['landscape'], 6)},\n"
            "    ),\n"
            "  ),")


BLOCK = re.compile(r"hardwareScreen: const HardwareScreen\(\n.*?\n  \),", re.S)


def render(rec, deg, scale, out):
    W, H = rec["size"]
    src = (ARTS / rec["file"]).read_text()
    inner = re.sub(r"^<svg[^>]*>", "", src.strip()).rsplit("</svg>", 1)[0]
    if deg == 0:
        cw, ch, tf = W, H, ""
    else:
        cw, ch, tf = H, W, f' transform="translate({num(H)} 0) rotate(90)"'
    wrap = (f'<svg xmlns="http://www.w3.org/2000/svg" width="{num(cw)}" height="{num(ch)}" '
            f'viewBox="0 0 {num(cw)} {num(ch)}"><g{tf}>{inner}</g></svg>')
    with tempfile.NamedTemporaryFile("w", suffix=".svg", delete=False) as t:
        t.write(wrap)
    subprocess.run(["resvg", "--zoom", str(scale), t.name, str(out)], check=True)
    pathlib.Path(t.name).unlink()


def main():
    check = "--check" in sys.argv
    recs = {r["id"]: r for r in json.loads((ARTS / "phones.json").read_text())["frames"]}
    ok = True
    for asset, rid, deg, scale, dart, fantasy in FRAMES:
        rec = recs[rid]
        out = IMAGES / asset
        if check:
            with tempfile.TemporaryDirectory() as d:
                tmp = pathlib.Path(d) / asset
                render(rec, deg, scale, tmp)
                same = out.exists() and tmp.read_bytes() == out.read_bytes()
        else:
            render(rec, deg, scale, out); same = True
        line = f"{asset:22s} ← {rid:20s} {'回転 %d° ' % deg if deg else ''}{scale}x"
        if dart:
            s = screen(rec, deg, fantasy)
            p = MODELS / dart
            text = p.read_text()
            new = BLOCK.sub(lambda m: dart_block(s), text, count=1)
            assert BLOCK.search(text), f"{dart}: HardwareScreen が見つからない"
            if check:
                same = same and new == text
            else:
                p.write_text(new)
            w, h = s["size"]
            line += f"  論理 {num(s['lw'], 4)}×{num(s['lh'], 4)} 角丸 {num(s['radius'], 2)}  → {dart}"
        print(("OK  " if same else "NG  ") + line)
        ok &= same
    for src, dst in COPIES:
        if not check:
            dst.parent.mkdir(exist_ok=True)
            dst.write_bytes(src.read_bytes())
        same = dst.exists() and dst.read_bytes() == src.read_bytes()
        print(("OK  " if same else "NG  ") + f"{dst.relative_to(VP)} ← arts/{src.relative_to(ROOT.parent / 'arts')}")
        ok &= same
    if check:
        print("一致" if ok else "!! arts とずれている。--check を外して取り込み直す")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
