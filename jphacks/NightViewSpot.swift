//
//  NightViewSpot.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

class NightViewSpot: Spot {
    init(result: [String]) {
        super.init(name: result[1], address: result[2], detail: result[4], latitude: Double(result[7])!, longitude: Double(result[8])!)
    }
}