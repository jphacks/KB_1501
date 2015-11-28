//
//  SightseeingSpot.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

// ["スポット名", "電話番号", "URL", "カナ", "メインジャンル名", "サブジャンル名", "エリア名", "7本文", "8ic:住所_表記", "住所2", "ic:定型住所_区", "郵便番号", "12緯度", "13経度", "電話番号", "営業時間", "URL", "アクセス", "定休日", "料金", "駐車場", "バリアフリー対応（観光）"]

class SightseeingSpot: Spot {
    init(result: [String]) {
        super.init(name: result[0], address: result[8], detail: result[7], latitude: Double(result[12])!, longitude: Double(result[13])!)
    }
}