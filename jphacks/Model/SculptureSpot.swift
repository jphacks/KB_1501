//
//  SculptureSpot.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//
// 0No	1作品名	2作者名	3素材	4サイズ（cm）	5設置年	6設置場所	7緯度	8経度

class SculptureSpot: Spot {
    init(result: [String]) {
        super.init(name: result[1], address: result[6], detail: result[2], latitude: Double(result[7])!, longitude: Double(result[8])!)
    }
}