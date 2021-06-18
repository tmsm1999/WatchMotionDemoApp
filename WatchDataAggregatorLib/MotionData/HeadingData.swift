//
//  HeadingData.swift
//  DataCollectionDemo WatchKit Extension
//
//  Created by Tomás Mamede on 18/06/2021.
//

import Foundation
import CoreMotion

public struct Heading {
    
    let value: Double
}

class HeadingData {
    
    var collectedHeadingData = [(TimeInterval, Heading)]()
    
    public func appendData(timestamp: TimeInterval, newEntry: Double) {
        
        let newHeadingEntry = Heading(value: newEntry)
        collectedHeadingData.append((timestamp, newHeadingEntry))
    }
    
    func getLastReading() -> Heading? {
        
        if collectedHeadingData.count > 0 {
            return collectedHeadingData[collectedHeadingData.count - 1].1
        }
        
        return nil
    }
}
