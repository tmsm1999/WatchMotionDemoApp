//
//  UserAccelerationData.swift
//  DataCollectionDemo WatchKit Extension
//
//  Created by Tomás Mamede on 18/06/2021.
//

import Foundation
import CoreMotion

class UserAccelerationData {
    
    struct UserAcceleration {
        
        let x: Double
        let y: Double
        let z: Double
    }
    
    var collectedUserAccelerationData = [(TimeInterval, UserAcceleration)]()
    
    public func appendData(timestamp: TimeInterval, newEntry: CMAcceleration) {
        
        let newGravityEntry = UserAcceleration(x: newEntry.x, y: newEntry.y, z: newEntry.z)
        collectedUserAccelerationData.append((timestamp, newGravityEntry))
    }
    
    func getLastReading() -> UserAcceleration? {
        
        if collectedUserAccelerationData.count > 0 {
            return collectedUserAccelerationData[collectedUserAccelerationData.count - 1].1
        }
        
        return nil
    }
}

