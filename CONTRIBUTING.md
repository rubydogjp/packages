# 開発の進め方

pub.dev で公開している Flutter / Dart のパッケージ (`go_router_express`・`nanoid_plus`・`virtual_phone`) をまとめたリポジトリです。

## ブランチ

main の履歴は公開されるので、main へは意味のある塊ごとに取り込みます。PR は出しません。

- 作業は `develop` で commit し、そのまま push しておく
- main への取り込みは、意味のある塊 (1 つのパッケージの 1 つのリリースなど) ができたときに手作業で行う。
  squash せず rebase で commit を残し、main はマージコミットの無い 1 本の線のまま進める (main は develop の早送りで進む)
  - 取り込む前に、必要なら `git rebase -i` で develop の commit を意味のある単位に整える
    (直しの commit を元の commit にまとめるなど。整えたら develop は `--force-with-lease` で push し直す)
  - 塊の最後の commit まで main を早送りする (`git push origin <commit>:main`)
- commit の題は今の main と同じく、パッケージ名と版を頭に付ける (例: `virtual_phone 2.0.2: Upgrade to freezed 4`)
- main で直接 commit しない
