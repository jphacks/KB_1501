//
//  Spot.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

class Spot {
    let name: String
    let address: String
    let detail : String
    let latitude: Double
    let longitude: Double
    
    init(name: String, address: String, detail: String, latitude: Double, longitude: Double) {
        self.name = name
        self.address = address
        self.detail = detail
        self.latitude = latitude
        self.longitude = longitude
    }
}
