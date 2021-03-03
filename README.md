# OnePaaS
- HiCoderで使うためのWebアプリケーションデプロイ基盤

# pseudo code
- goal 1
```
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

# 実装方法
- golang, k8s?
- google domainをとっているのと移管が面倒なので、GCPを使う

# Todo
- CIを先に組む

# note
- GCPのk8sはVM課金なので、VMの最小単位が問題になる。
- k8sはスケールに強みがあるが、そもそも学生のプロダクトはスケールしないので、オートヒーリングのような面倒見がいい機能が大事
- ハッカソンのデプロイ基盤として活用できるかも
- DBはひとまとめのコンテナで共用にする。
