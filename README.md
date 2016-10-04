## README

* 「[あとで読む](http://atode.cc/)」をhttpsページで動作させることを動機に、「あとで読む」と機能的に同じものを作成
   * bookmarkletを動作させると、見ている内容をメールで送信する
* その内容のDB保存機能を追加


## Requirement
* herokuでの動作を想定しています
   * Heroku Postgres Add-onが必要
* sendgrid.com に登録
   * なお、開封確認機能は今回不要なので、設定からoffにしましょう。（imgタグが自動で埋め込まれてしまう）
   * [https://app.sendgrid.com/settings/tracking](https://app.sendgrid.com/settings/tracking)
* config/application.ymlに次の値を設定

```
SENDGRID_API_KEY: "sendgridのAPIキー"
MY_MAIL_FROM: "送信元メールアドレス"
MY_MAIL_TO: "送信先メールアドレス"
PASSWORD: "パスワード(英数字のみ)のsha256"
```

* Herokuに対して実行

```
heroku run rake db:migrate
figaro heroku:set -e production
```

## 使い方
* トップページでapplication.ymlに設定したのと同じパスワードを入力した上で、生成されたbookmarkletを登録する
* メールで送信したいページで、bookmarkletを動作させる

## 補足
* パスワードをつけたが、これではあまり意味がない

## Versions
* ruby 2.3.0p0 (2015-12-25 revision 53290)
* Rails Rails 5.0.0.1

## License
This software is released under the MIT License, see LICENSE.txt.

## Author
[tattyamm](https://twitter.com/tattyamm)
