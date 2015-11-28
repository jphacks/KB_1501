//
//  FilmingLocationSpotRepository.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

class FilmingLocationSpotRepository {
    let spots: [FilmingLocationSpot]
    
    init() {
        let results = CSVManager.filmingLocationData()
        spots = results.map { data in
            FilmingLocationSpot(result: data)
        }
    }
    
}