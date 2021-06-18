//
//  Attitude.swift
//  DataCollectionDemo WatchKit Extension
//
//  Created by Tomás Mamede on 18/06/2021.
//

import Foundation
import CoreMotion

class AttitudeData {
    
    struct Attitude {
        
        let pitch: Double
        let roll: Double
        let yaw: Double
    }
    
    var collectedAttitude = [(TimeInterval, Attitude)]()
    
    public func appendData(timestamp: TimeInterval, newEntry: CMAttitude) {
        
        let newGravityEntry = Attitude(pitch: newEntry.pitch, roll: newEntry.roll, yaw: newEntry.yaw)
        collectedAttitude.append((timestamp, newGravityEntry))
    }
    
    func getLastReading() -> Attitude? {
        
        if collectedAttitude.count > 0 {
            return collectedAttitude[collectedAttitude.count - 1].1
        }
        
        return nil
    }
}
