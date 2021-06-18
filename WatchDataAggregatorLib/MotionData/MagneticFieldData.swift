//
//  MagneticFieldData.swift
//  DataCollectionDemo WatchKit Extension
//
//  Created by Tomás Mamede on 18/06/2021.
//

import Foundation
import CoreMotion

public struct MagneticField {
    
    let x: Double
    let y: Double
    let z: Double
}

class MagneticFieldData {
    
    var collectedMagneticFieldData = [(TimeInterval, MagneticField)]()
    
    public func appendData(timestamp: TimeInterval, newEntry: CMMagneticField) {
        
        let newMagneticFieldEntry = MagneticField(x: newEntry.x, y: newEntry.y, z: newEntry.z)
        collectedMagneticFieldData.append((timestamp, newMagneticFieldEntry))
    }
    
    func getLastReading() -> MagneticField? {
        
        if collectedMagneticFieldData.count > 0 {
            return collectedMagneticFieldData[collectedMagneticFieldData.count - 1].1
        }
        
        return nil
    }
}
