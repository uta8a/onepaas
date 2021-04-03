# OnePaaS
- HiCoderで使うためのWebアプリケーションデプロイ基盤

# pseudo code
- goal 1
```text
Input: files(index.html)
Output: URL(reponame.username.hicoder.one)

giteaにpush
onepaas.ymlを検知したらCDを動かす
sftpでファイルをnginxに送り込む
nginxの設定ファイルを更新し、ドメインを書き込む
サブドメインを切る
アクセスできるようになる
サブドメインを出力して終了
```

# goal
- goal 1
  - HTML/CSS/JavaScript で作られたホームページのデプロイ(GitHub Pages 相当)
  - nginxやcaddyを置いたアプリサーバとgiteaを置いたgitサーバの2台を用意

# 実装方法
- golang, k8s?
- google domainをとっているのと移管が面倒なので、GCPを使う
- ピタゴラスイッチをうまく組む能力が大事そう

# Todo
- [x] CIを先に組む 組んだ
- [x] giteaがないとどうしようもないので、たてる(docker-composeでたてる？)
- [x] 予約済みサブドメインを考える
- [x] giteaを先にGCPでホストしてしまう
- [ ] ディレクトリ構成を考える
- [ ] giteaの設定ファイルをローカルで最適にして、terraform&ansibleに組み込む
- [ ] caddyfileを操作する&reloadかける
- [ ] CICD機構をつくる
- [ ] アプリ: k8sの導入

# 仕様
- repository直下に`onepaas.yml`が存在すればデプロイを行う

## directory構成
```text
Makefile
infra/
  ansible/
  terraform/
app/
deployments/
  dockerfile/
  docker-compose.dev.yml
```

## 予約済みサブドメイン
- 基本的に、`reponame.username.hicoder.one`が毎回払い出されるので、`username`としてとってはいけないものをリストアップする

```text
admin
auth
git
onepaas
one
app
stg
blog
```

# note
- GCPのk8sはVM課金なので、VMの最小単位が問題になる。
- k8sはスケールに強みがあるが、そもそも学生のプロダクトはスケールしないので、オートヒーリングのような面倒見がいい機能が大事
- ハッカソンのデプロイ基盤として活用できるかも
- DBはひとまとめのコンテナで共用にする。
- GCPでgiteaを安価に運用する ref. https://dany1468.hatenablog.com/entry/2020/02/29/095719
- static fileのホストについてはYAMLが無でもよくて、存在していることが大事(deployを行うかどうかの判断)
- とりあえず一貫で作って個々を作り込む方針にする。
- https://pipecd.dev/docs/overview/ CDによさそう
- applyしっぱなしでdestroyを忘れるので、それをS3バックエンドにしてtfstateをreadしてどこかの認証付きWebページから今立ち上がっているリソースを確認できるようにしたい。
- cloud DNS https://cloud.google.com/dns/docs/tutorials/create-domain-tutorial?hl=ja
