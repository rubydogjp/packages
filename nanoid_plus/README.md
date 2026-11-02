# 🐣 Nano ID

```dart
import 'dart:math';

import 'package:nanoid_plus/nanoid_plus.dart';


const nanoid = Nanoid();
final id = nanoid.urlSafe(length: 8);

// id: AXBYCZ01

// The length never counts the prefix: 'ord_' + 21 characters
final orderId = nanoid.urlSafe(prefix: 'ord_', length: 21);

// Default lengths when omitted:
//   urlSafe / urlSafeHumanFriendly / alphanumeric: 21, hex: 32,
//   lowercase: 12, numeric: 6
// Pass the length explicitly when IDs are generated in more than one place.


// Validate IDs from URLs or user input (no defaults: say what you expect)
Nanoid.isValid(
  orderId,
  charSet: NanoidCharset.urlSafe,
  length: 21,
  prefix: 'ord_',
); // true

// Pick the shortest safe length (< 1% collision risk)
Nanoid.requiredLength(
  charsetSize: NanoidCharset.urlSafe.length,
  idsPerHour: 1000,
  duration: const Duration(days: 365 * 10),
); // 10

// Reproducible IDs for tests (never in production: they are predictable)
final seeded = Nanoid(random: Random(42));

```


---

## English 🌐

- ✅ **Lightweight**: only a few KB.
- ✅ **Secure**: uses `Random.secure()` to generate unpredictable randomness, with no modulo bias, and throws instead of falling back when no secure source exists.
- ✅ **Simple**: just a few lines of code.
- ✅ **Short**: shorter than UUID (36 characters).
- ✅ **Safe**: no percent-encoding needed.
- ✅ **Customizable**: characters for URLs, human-friendly characters, and custom characters.
- ✅ **Checkable**: validate IDs with `isValid()` and pick a safe length with `requiredLength()`.

### Example Use Cases

- **UserID**: for example, an 8-character Nano ID is enough for each of 100,000 users.

| User Scale   | ID Length | Collision Probability |
|:------------:|:---------:|:-------------------------------:|
| 100,000      |     8     | 0.002%                          |
| 1,000,000    |     9     | 0.003%                          |
| 10,000,000   |    10     | 0.002%                          |


#### Other Use Cases

- ***Ticket number***
- ***Temporary password***
- ***Short URL***

<br />
<br />
<br />

### ========================

<br />
<br />
<br />


## 日本語 🇯🇵

- ✅ **軽量**: わずか数キロバイト
- ✅ **安全**: `Random.secure()` で予測不可能な乱数を生成 (モジュロバイアスなし。安全な乱数源が無い環境では黙って切り替えず例外を投げる)
- ✅ **シンプル**: 数行のコードでIDを生成
- ✅ **短い**: UUID（36文字）より短い
- ✅ **安全（URL）**: パーセントエンコーディング不要
- ✅ **カスタマイズ可能**: URL文字列、人間が読みやすい文字列、カスタム文字セット...等
- ✅ **検証できる**: `isValid()` でIDの形式を確認、`requiredLength()` で安全な長さを計算

### 使用例

- **ユーザーID**: 例えば, 8文字の Nano ID は 10 万人規模のサービスにおいても十分に衝突しにくいユーザーIDとして利用できます.

| ユーザー規模 | ID 長さ | 重複確率 |
|:------------:|:-------:|:----------------:|
|  10 万人     |    8    | 0.002%        |
| 100 万人     |    9    | 0.003%        |
| 1,000 万人   |   10    | 0.002%        |


#### その他の使用例

- ***チケット番号***
- ***一時パスワード***
- ***短縮URL***

<br />
<br />
<br />

### ========================

<br />
<br />
<br />

## 中文 🇨🇳

- ✅ **轻量**: 只有几 KB。
- ✅ **安全**: 使用 `Random.secure()` 生成不可预测的随机数，无模偏差；没有安全随机源时直接抛出异常，不会静默降级。
- ✅ **简洁**: 仅需几行代码。
- ✅ **短小**: 比 UUID（36 字符）更短。
- ✅ **安全（URL）**: 无需百分号编码。
- ✅ **可定制**: 用于 URL 的字符、人性化字符和自定义字符。
- ✅ **可校验**: 用 `isValid()` 校验 ID 格式，用 `requiredLength()` 计算安全的长度。

### 示例用例

- **用户 ID**: 例如，8 字符的 Nano ID 足以为 100,000 名用户中的每一位提供。

| 用户规模     | ID 长度 | 冲突概率 |
|:------------:|:-------:|:----------------:|
| 100,000      |    8    | 0.002%        |
| 1,000,000    |    9    | 0.003%        |
| 10,000,000   |   10    | 0.002%        |

#### 其他

- ***票号***
- ***临时密码***
- ***短链接***
