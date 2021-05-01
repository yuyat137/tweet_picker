# Tweet-Picker

## サービス概要
Twitterで膨大な量のツイートを追えない人に  
人気のあるツイートを厳選して提供する、  
ツイートのイイトコ取りアプリ『Tweet-Picker』です。  

## 課題
- 忙しくて、情報の海であるTwitterをゆっくり見る時間がない。
- 芸能人などのリストを作っているが、リスト内のツイート量が膨大になってしまい、追うことができない。

## テーブル設計
<img width="60%" src="erd.png">

## インフラ構成図
<img width="60%" src="aws-tweet-picker.png">

# 開発者用

DBをリセットした場合、以下のようにゲストユーザーを作成してください

```ruby
User.create(email: "guest", password: "password", password_confirmation: "password",  profile_image_url:"guest.png")
```

