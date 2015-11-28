//
//  CSVManager.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

import Foundation

class CSVManager {
    class func sightseeingData() -> [[String]]{
        return readCSV("sightseeing", rows: 22)
    }
    
    class func nightViewData() -> [[String]] {
        return readCSV("nightView", rows: 9)
    }
    
    class func readCSV(fileName: String, rows: Int) -> [[String]] {
        var results: [[String]] = []
        var offsetString = ""
        if let csvPath = NSBundle.mainBundle().pathForResource(fileName, ofType: "csv") {
            let csvString = try! NSString(contentsOfFile: csvPath, encoding: NSUTF8StringEncoding)
            csvString.enumerateLinesUsingBlock { (line: String, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                if line.characters.count == 0 { // 空白行を殺す
                    return
                }
                
                if ((line as NSString).substringToIndex(2) == "No" || (line as NSString).substringToIndex(4) == "スポット") {
                    return
                }
                
                if (offsetString + line).componentsSeparatedByString(",").count < rows {
                    offsetString += line
                } else if (offsetString + line).componentsSeparatedByString(",").count == rows {
                    results.append((offsetString + line).componentsSeparatedByString(","))
                    offsetString = ""
                } else {
                    offsetString = ""
                }
            }
        }
        return results
    
    }

}