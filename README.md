# droppin(ドロッピン)
![walk.gif](https://qiita-image-store.s3.amazonaws.com/0/77778/a159879e-5415-6cd5-3485-aa593bb4b06e.gif "walk.gif")

## 製品概要
寄り道アプリ

### 背景(製品開発のきっかけ、課題等）
「観光地」である神戸の特性を活かしたサービスを作りたいという想いがきっかけになった．  
観光地では，どうしても有名な場所のみが目的地になってしまい，そこへの最短経路を辿ってしまう．  
観光地側としては，他にも訪れてほしい場所があり，観光客側としても新たな発見が得られないという課題があるのでは，と考えた．
また，あまりその土地に明るくない場合，食事をするにしてもトイレに行くにしても，それらを探すことに苦労する．
そこで，道に迷ったらまずスマホでマップアプリを開く現代人にとって，マップですべて解決できるアプリがあればいいのでは、と考えて今回のプロダクトを制作した．
  
### 製品説明（具体的な製品の説明）
出発地（初期設定は現在地）と目的地を設定し，寄り道したいスポットのジャンルを選択(複数可)し，検索ボタンを押すと，マップが展開．  
マップ上には出発地、目的地と選択したジャンルのスポットが，ピンされている．  
ピンされたスポットを選択すると，そのスポットの詳細が表示される．  
詳細にある「経路に追加」のボタンをタップすると，出発地から目的地までの間でそのスポットを経由するように経路が変更される(複数可)．  
最終的にその寄り道ルートをスクリーンショットでTwitterに投稿できる機能を追加し，「寄り道」の共有という新しい文化を生み出すこともできた．
  
### 特長
####1. 特長1
今回は神戸市のオープンデータを活用しているが，読み込むデータに応じてスポットの変更が可能のため，汎用性の高い観光マップアプリとしての側面を持っている．

####2. 特長2
スポットを経路を追加したときに，そのスポットを通り，出発点から目的地まで向かえるルートの最適化を行っている．

####3. 特長3
全体的にデザインにこだわり，使いやすいUIデザインや，サービスのイメージが強く印象付けられるようなデザインとブランディングを行っている．

### 解決出来ること
観光地において新たな発見を観光客に提供し、満足度を向上させる．  
観光客を，観光地側が訪れてほしいスポットに誘導することができる．  
その土地に明るくない観光客のような場合でも，目的地に向かうまでにトイレやレストランなどのスポットを手軽に発見できるため道中を快適に過ごすことができる．  
寄り道をシェアすることで，寄り道をシェアするという新しい文化を生み出し，観光地の宣伝を達成することができる．  

### 今後の展望
データの充実(他の観光地のオープンデータも活用し，全国的にスポットを展開)  
外部APIを活用し，グルメ情報サイトやリアルタイムのイベントなどをマップから参照．  

### 注力したこと（こだわり等）
* 使いやすく，心地よいUIデザイン
* ルートの最適化を行うアルゴリズム
* オープンデータの整形
* サービスを印象づけるブランディングデザイン

## 開発技術
* Swift 2.1

### 活用した技術
* Xcode 7.1.1
* Photoshop
* Illustrator
* AfterEffects

#### API・データ
* 神戸市のオープンデータ(トイレ、夜景、観光、彫刻、ロケ地)

#### フレームワーク・ライブラリ・モジュール
* iOS Map Kit
* iOS Social Kit
* iOS Core Location

#### デバイス
* iPhone 6/6s
画面からはみ出る場合は、設定→画面表示と明るさ、から「表示」を
「標準」に設定してください。

* iPhone 6 Plus/6s Plus
画面が余る場合は、設定→画面表示と明るさ、から「表示」を
「拡大」に設定してください。

#### 実行

gem 2.4.5.1
cocoapods 0.39.0
Xcode 7.1.1


```bash
git clone git@github.com:jphacks/KB_01.git
pod install
```

Xcodeで開いてRun

### 未実装箇所
* ごはん、コンビニ、Wi-Fiの検索は神戸市のオープンデータが存在しなかったため、現在は機能として利用不可
* mapの上に表示される、スポットの詳細表示画面のアイコンは、どのジャンルのスポットに対しても観光地のまま

### 技術的な仕組み
ルート探索は、MapKitに全て任せると遅いので、先に通る順番のみ、緯度経度から概算の大小関係を出して計算している。
新しいスポットを追加するとき、すでにあるルートが最適であると仮定して、どこのスポットの間に入れた時の距離の和の増分が小さくなるか計算し挿入している。
その後、通常通りルートを計算させている。

### スクリーンショット

動画->[https://www.youtube.com/watch?v=aIsHwQ8poUo](https://www.youtube.com/watch?v=aIsHwQ8poUo)

![Slack for iOS Upload.png.jpeg](https://qiita-image-store.s3.amazonaws.com/0/77778/9f9b4437-8226-8309-e26a-c87f53a1ffb5.jpeg "Slack for iOS Upload.png.jpeg")
![Slack for iOS Upload.png-4.jpeg](https://qiita-image-store.s3.amazonaws.com/0/77778/97d0751a-e766-6912-f937-7cbf122b29d3.jpeg "Slack for iOS Upload.png-4.jpeg")
![Slack for iOS Upload.png-3.jpeg](https://qiita-image-store.s3.amazonaws.com/0/77778/1082b141-5a03-26e7-5a8c-a4d7df4669c8.jpeg "Slack for iOS Upload.png-3.jpeg")
![Slack for iOS Upload.png-2.jpeg](https://qiita-image-store.s3.amazonaws.com/0/77778/9e408397-64a9-b57e-3dc8-081bfbfb512c.jpeg "Slack for iOS Upload.png-2.jpeg")
![IMG_1406.jpg](https://qiita-image-store.s3.amazonaws.com/0/77778/ee0d9c56-e292-4b01-a7cb-aa0efbc0a752.jpeg "IMG_1406.jpg")
![Slack for iOS Upload.png.jpeg](https://qiita-image-store.s3.amazonaws.com/0/77778/cff7bf71-f1cf-05f4-6acd-1395e76ea936.jpeg)
![Slack for iOS Upload-1.png.jpeg](https://qiita-image-store.s3.amazonaws.com/0/77778/7970df29-9af6-05ed-98fb-1494dd77ecab.jpeg)
