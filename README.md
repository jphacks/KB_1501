# droppin(ドロッピン)
![walk.gif](https://qiita-image-store.s3.amazonaws.com/0/77778/a159879e-5415-6cd5-3485-aa593bb4b06e.gif "walk.gif")

## 製品概要
寄り道アプリ
### 背景(製品開発のきっかけ、課題等）
神戸の「観光地」という特性を活かしたサービスを作りたいというのがきっかけになった．  
観光地では，どうしても有名な場所のみが目的地になってしまい，そこへの最短経路を辿ってしまう．  
観光地側としては，他にも訪れてほしい場所があり，観光客側としても新たな発見が得られないという課題があるのでは，と思った．  
また，あまりその土地に明るくない場合，食事をするにしてもトイレに行くにしても，それらを探すことに苦労するといったこともある．  
道に迷ったらまずスマホでマップアプリを開く現代人にとって，マップですべて解決できるようになればいいのでは，と考え，今回のプロダクトを制作することにした．  
### 製品説明（具体的な製品の説明）
出発地（初期設定は現在地）と目的地を設定し，寄り道したいスポットのジャンルを選択(複数可)し，検索ボタンを押すと，マップが展開．  
マップ上には選択したジャンルのスポットが，ピンされている．  
ピンされたスポットを選択すると，そのスポットの詳細が表示される．  
そこで「経路に追加」をタップすると，出発地から目的地までの間でそのスポットを経由するように経路が変更される(複数可)．  
最終的にその寄り道ルートをスクリーンショットでtwitterに投稿できる機能を追加し，「寄り道」の共有という新しい文化を生み出すこともできた．  
### 特長
####1. 特長1
今回は神戸市のオープンデータを活用しているが，読み込むデータに応じてスポットの変更が可能のため，汎用性の高い観光マップアプリとしての側面を持っている．
####2. 特長2
スポットを経路を追加したときに，そのスポットを通り，出発点から目的地まで向かえるルートの最適化を行っている．
####3. 特長3
全体的にデザインにこだわり，使いやすいUIデザインや，サービスのイメージが強く印象付けられるようなデザインとブランディングを行っている．
### 解決出来ること
観光地において新たな発見を観光客に提供できる．  
観光客を，観光地側が訪れてほしいスポットに誘導することができる．  
その土地に明るくない場合でも，目的地に向かうまでに，トイレやレストランなどのスポットを手軽に発見できる．  
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
* Swift

### 活用した技術
* Xcode
* Photoshop
* Illustrator
* AfterEffects

#### API・データ
* 神戸市のオープンデータ

#### フレームワーク・ライブラリ・モジュール
* iOS Map Kit
* iOS Social Kit
* iOS Core Location

#### デバイス
* iPhone(iOS)

### スクリーンショット

https://youtu.be/aIsHwQ8poUo

![Slack for iOS Upload.png.jpeg](https://qiita-image-store.s3.amazonaws.com/0/77778/9f9b4437-8226-8309-e26a-c87f53a1ffb5.jpeg "Slack for iOS Upload.png.jpeg")
![Slack for iOS Upload.png-4.jpeg](https://qiita-image-store.s3.amazonaws.com/0/77778/97d0751a-e766-6912-f937-7cbf122b29d3.jpeg "Slack for iOS Upload.png-4.jpeg")
![Slack for iOS Upload.png-3.jpeg](https://qiita-image-store.s3.amazonaws.com/0/77778/1082b141-5a03-26e7-5a8c-a4d7df4669c8.jpeg "Slack for iOS Upload.png-3.jpeg")
![Slack for iOS Upload.png-2.jpeg](https://qiita-image-store.s3.amazonaws.com/0/77778/9e408397-64a9-b57e-3dc8-081bfbfb512c.jpeg "Slack for iOS Upload.png-2.jpeg")
![IMG_1406.jpg](https://qiita-image-store.s3.amazonaws.com/0/77778/ee0d9c56-e292-4b01-a7cb-aa0efbc0a752.jpeg "IMG_1406.jpg")
![Slack for iOS Upload.png.jpeg](https://qiita-image-store.s3.amazonaws.com/0/77778/cff7bf71-f1cf-05f4-6acd-1395e76ea936.jpeg)
![Slack for iOS Upload-1.png.jpeg](https://qiita-image-store.s3.amazonaws.com/0/77778/7970df29-9af6-05ed-98fb-1494dd77ecab.jpeg)
