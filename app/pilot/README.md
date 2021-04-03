# PILOT
- CI/CD時に必要となる動作を行うパイロット
- golang, webサーバとて機能する。エンドポイントは外部に出さない。

## 要件
- `.onepaas/workflows/*.yml` が存在した状態でpushされたら、giteaからpilotへ向けて、 `/trigger` へpostを投げる。
- とりあえず初期は内容はないので無視してpush時点で発火
- 現在デプロイリストを更新。これに基づいて次のsubdomain周りの処理を行う。
- terraformで `reponame.username.hicoder.one` を切る(terraformの権限を持っておく)
- Caddyfileを編集する
- buildなしで考えているので、giteaからファイルをとってきてそのままvolumeに配置してcomposeを再度立ち上げる。
