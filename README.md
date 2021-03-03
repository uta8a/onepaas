# OnePaaS
- HiCoderで使うためのWebアプリケーションデプロイ基盤

# pseudo code
- goal 1
```text
Input: files(index.html)
Output: URL(reponame.username.hicoder.one)

giteaにデプロイ
CI/CDが走る
コンテナが立つ
サブドメインを切る
アクセスできるようになる
サブドメインを出力して終了
```

# goal
- goal 1
  - HTML/CSS/JavaScript で作られたホームページのデプロイ(GitHub Pages 相当)
- goal 1/1
  - giteaをローカルとGCP上で立てる
- goal 1/2
  - giteaのpush hook(tagつき)
- goal 1/3
  - 何が必要か書き出して、YAML化できるか考える。
# 実装方法
- golang, k8s?
- google domainをとっているのと移管が面倒なので、GCPを使う

# Todo
- [x] CIを先に組む 組んだ
- [ ] giteaがないとどうしようもないので、たてる(docker-composeでたてる？)
- [x] 予約済みサブドメインを考える
- [ ] ディレクトリ構成を考える

# 仕様

## directory構成
```text
Makefile
infra/
  ansible/
  terraform/
src/
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
```

# note
- GCPのk8sはVM課金なので、VMの最小単位が問題になる。
- k8sはスケールに強みがあるが、そもそも学生のプロダクトはスケールしないので、オートヒーリングのような面倒見がいい機能が大事
- ハッカソンのデプロイ基盤として活用できるかも
- DBはひとまとめのコンテナで共用にする。
- GCPでgiteaを安価に運用する ref. https://dany1468.hatenablog.com/entry/2020/02/29/095719
