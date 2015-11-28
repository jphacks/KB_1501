//
//  SculptureSpotRepository.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

class SculptureSpotRepository {
    let spots: [SculptureSpot]
    
    init() {
        let results = CSVManager.sculptureData()
        spots = results.map { data in
            SculptureSpot(result: data)
        }
    }
    
}