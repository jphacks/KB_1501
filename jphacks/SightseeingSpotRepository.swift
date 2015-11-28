//
//  SightseeingSpotRepository.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

class SightseeingSpotRepository {
    let spots: [SightseeingSpot]

    init() {
        let results = CSVManager.sightseeingData()
        spots = results.map { data in
            SightseeingSpot(result: data)
        }
    }

}