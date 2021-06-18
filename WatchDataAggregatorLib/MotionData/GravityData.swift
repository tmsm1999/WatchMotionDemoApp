//
//  AccelerometerData.swift
//  WatchDataAggregator
//
//  Created by Tomás Mamede on 17/06/2021.
//

import Foundation
import CoreMotion

class GravityData {
    
    struct Gravity {
        
        let x: Double
        let y: Double
        let z: Double
    }
    
    var collectedAccelerometerData = [(TimeInterval, Gravity)]()
    
    public func appendData(timestamp: TimeInterval, newEntry: CMAcceleration) {
        
        let newGravityEntry = Gravity(x: newEntry.x, y: newEntry.y, z: newEntry.z)
        collectedAccelerometerData.append((timestamp, newGravityEntry))
    }
    
    func getLastReading() -> Gravity? {
        
        if collectedAccelerometerData.count > 0 {
            return collectedAccelerometerData[collectedAccelerometerData.count - 1].1
        }
        
        return nil
    }
}
