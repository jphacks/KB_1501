//
//  NightViewSpotRepository.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

class NightViewSpotRepository {
    let spots: [NightViewSpot]
    
    init() {
        let results = CSVManager.nightViewData()
        spots = results.map { data in
            NightViewSpot(result: data)
        }
    }

}