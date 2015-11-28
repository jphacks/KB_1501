//
//  ToiletSpotRepository.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

class ToiletSpotRepository {
    let spots: [ToiletSpot]
    
    init() {
        let results = CSVManager.toiletData()
        spots = results.map { data in
            ToiletSpot(result: data)
        }
    }
    
}