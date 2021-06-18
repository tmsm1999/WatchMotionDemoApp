//
//  Attitude.swift
//  DataCollectionDemo WatchKit Extension
//
//  Created by Tomás Mamede on 18/06/2021.
//

import Foundation
import CoreMotion

public struct Attitude {
    
    let pitch: Double
    let roll: Double
    let yaw: Double
}

class AttitudeData {
    
    var collectedAttitudeData = [(TimeInterval, Attitude)]()
    
    public func appendData(timestamp: TimeInterval, newEntry: CMAttitude) {
        
        let newGravityEntry = Attitude(pitch: newEntry.pitch, roll: newEntry.roll, yaw: newEntry.yaw)
        collectedAttitudeData.append((timestamp, newGravityEntry))
    }
    
    func getLastReading() -> Attitude? {
        
        if collectedAttitudeData.count > 0 {
            return collectedAttitudeData[collectedAttitudeData.count - 1].1
        }
        
        return nil
    }
}
