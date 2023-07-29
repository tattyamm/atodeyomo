## README

* 見ているwebページをメールで送信して保存できるサービス
* 「[あとで読む](http://atode.cc/)」をhttpsページで動作させることを動機に、「あとで読む」と機能的に同じものを作成
   * bookmarkletを動作させると、見ている内容をメールで送信する
   * DBへの保存機能を追加


## Requirement
* [fly.io](https://fly.io/)での動作を想定しています
* gmailを使いメール送信します。「アプリ パスワード」の登録が必要です。
* dotenv-rails向けの.envファイルに値を定義
* fly.ioに対して実行

```
fly launch --ha=false
fly deploy --ha=false --strategy immediate
設定の反映
flyctl secrets set PASSWORD=X MAIL_FROM=X MAIL_TO=X SMTL_USER_NAME=X SMTP_PASSWORD=X
```

## 使い方
* railsを動作させたときのトップページで設定したのと同じパスワードを入力した上で、生成されたbookmarkletをブックマークへ登録する
* メールで送信したいページで、bookmarkletを動作させる

## 補足
* 1人用に作成しているため、複数人で利用することはできません

## License
This software is released under the MIT License, see LICENSE.txt.

## Author
[tattyamm](https://twitter.com/tattyamm)
