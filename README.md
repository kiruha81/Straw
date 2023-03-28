# 投稿されたあらゆるお店の位置や評価が知ることができるWebサイト "ストロー"
Store Locationを略してストローです。お店の情報を吸収できるという意味も込めています。

## サイト概要
### サイトテーマ
ユーザーがジャンル問わずお店を投稿できます。<br>
また、投稿されたお店にレビューをすることができます。<br>
検索機能をジャンル・都道府県・名称から検索でき、目的の店が見つけやすくなっています。<br>
コメント機能を設けることでユーザー間で店の特徴を教え合うなどのコミュニケーションを取ることができます。<br>
フォロー・フォロワー機能があり、相互限定でタイムラインもしくは日記が見れるようになることでユーザー間で交流することもできます(仮)。<br>
基本的な方針は、あらゆるお店のレビューをすることができユーザーで共有できるレビューサイトです。

### テーマを選んだ理由
例えば地元の方が店についてレビューをすることで、田舎に転勤になったサラリーマンがすぐに様々な店を把握できるようになり、
更にコミュニケーションを取ることにより転勤後に地域の方と仲良くなれればという想いで制作しました。<br>
田舎ならではの密な人間関係に溶け込むためのきっかけになると考えます。<br>
そして、本サイトを通じて都会と田舎関係なくお店がユーザーのレビューによってピックアップされると、客足が伸び、経済を活性化することができるでしょう。<br>
行列ができるような事例があれば本サイトやSNS等の他サイト、およびテレビを通じ話題になり、世の中に与える影響が高いと考えます。

### ターゲットユーザ
- 引越し先や出張先で店を探すユーザー
- 地元や住まいでいいお店を紹介したいユーザー
- 外出予定を立てるためにお店を探すユーザー

### 主な利用シーン
- 休日にお出かけ先を探すときにレビューを見て参考にする
- 行ったお店や行ったことがあるお店を投稿し共有できる
- 他ユーザーとお店についてのコミュニケーションを行う

## 機能一覧(仮)
- ゲストログイン
- 会員機能
- 会員情報公開・非公開設定機能
- ユーザー管理機能(管理者)
- 投稿機能
- 投稿制限(管理者)
- 投稿検索機能(タグ検索)
- タグ管理(管理者)
- レビュー機能
- レビュー管理(管理者)
- いいね機能(非同期)
- いいね一覧表示機能
- 部分一致検索機能
- 絞り込み表示機能
- コメント機能
- コメント管理(管理者)
- 投稿に位置情報を付与(GoogleMap)
- 都道府県検索(タグ)

## 設計書
### ER図
![straw_ER drawio ](https://user-images.githubusercontent.com/121922228/228138379-acd5e2d3-ab35-45c4-ad0e-8addfbead5bf.jpg)

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 使用素材
いらすとや 様
https://www.irasutoya.com/