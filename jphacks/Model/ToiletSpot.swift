//
//  ToiletSpot.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//
// 0番号 1多目的ベビーシート対応	2施　設　名		3公共・民間	4所　　在　　地	5新設・改修	6緯度	7経度

class ToiletSpot: Spot {
    init(result: [String]) {
        super.init(name: result[2], address: result[4], detail: result[3], latitude: Double(result[6])!, longitude: Double(result[7])!)
    }
}