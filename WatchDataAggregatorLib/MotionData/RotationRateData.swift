//
//  RotationRate.swift
//  DataCollectionDemo WatchKit Extension
//
//  Created by Tomás Mamede on 18/06/2021.
//

import Foundation
import CoreMotion

class RotationRateData {
    
    struct RotationRate {
        
        let x: Double
        let y: Double
        let z: Double
    }
    
    var collectedRotationRateData = [(TimeInterval, RotationRate)]()
    
    public func appendData(timestamp: TimeInterval, newEntry: CMRotationRate) {
        
        let newGravityEntry = RotationRate(x: newEntry.x, y: newEntry.y, z: newEntry.z)
        collectedRotationRateData.append((timestamp, newGravityEntry))
    }
    
    func getLastReading() -> RotationRate? {
        
        if collectedRotationRateData.count > 0 {
            return collectedRotationRateData[collectedRotationRateData.count - 1].1
        }
        
        return nil
    }
}


