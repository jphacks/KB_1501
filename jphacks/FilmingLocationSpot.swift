//
//  FilmingLocationSpot.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//
// 0ロケ地ID	1エリア	2ロケ地名	3ロケ地名（よみ）	4"郵便番号"	5住所	6緯度	7経度	8撮影作品1	9撮影作品1_情報

class FilmingLocationSpot: Spot {
    init(result: [String]) {
        super.init(name: result[8], address: result[5], detail: result[9], latitude: Double(result[6])!, longitude: Double(result[7])!)
    }
}