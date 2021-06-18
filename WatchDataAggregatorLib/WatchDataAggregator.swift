//
//  WatchDataAggregator.swift
//  WatchDataAggregator
//
//  Created by Tomás Mamede on 16/06/2021.
//

import Foundation
import CoreMotion

public class WatchDataAggregator: ObservableObject {
    
    private var sensors: [Sensor]
    private var updateInterval: TimeInterval
    private var dataCollectionInterval: TimeInterval
    
    private let motionManager = CMMotionManager()
    
    var accelerometerData = GravityData()
    var userAccelerationData = UserAccelerationData()
    var attitudeData = AttitudeData()
    var rotationData = RotationRateData()
    var magneticFieldData = MagneticFieldData()
    
    private let queue = OperationQueue()
    
    @Published var readNewDataFromSensor = true
    
    public init(sensors: [Sensor], updateInterval: TimeInterval, totalTimeGatheringData: TimeInterval) {
        
        self.sensors = sensors
        self.updateInterval = updateInterval
        self.dataCollectionInterval = totalTimeGatheringData
    }
    
    public func startDataCollection() {
        
        if  motionManager.isDeviceMotionAvailable {
            
            readSensorData()
        }
        else {
            fatalError("Some of the sensors chosen are not available on your device.")
        }
    }
    
    private func readSensorData() {
        
        motionManager.deviceMotionUpdateInterval = updateInterval // Updates occur 60 times per second.
        motionManager.showsDeviceMovementDisplay = true
        
        self.motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: self.queue, withHandler: { (motionData, error) in
            
            if let motionData = self.motionManager.deviceMotion {
                
                self.accelerometerData.appendData(timestamp: motionData.timestamp, newEntry: motionData.gravity)
                self.userAccelerationData.appendData(timestamp: motionData.timestamp, newEntry: motionData.userAcceleration)
                self.attitudeData.appendData(timestamp: motionData.timestamp, newEntry: motionData.attitude)
                self.rotationData.appendData(timestamp: motionData.timestamp, newEntry: motionData.rotationRate)
                self.magneticFieldData.appendData(timestamp: motionData.timestamp, newEntry: motionData.magneticField.field)
                
                DispatchQueue.main.async {
                    self.readNewDataFromSensor = !self.readNewDataFromSensor
                }
            }
        })
    }
    
    public func getLastAccelerometerReading() -> String? {
        
        let lastUserAccelerationReading = userAccelerationData.getLastReading()
        
        if let lastUserAccelerationReading = lastUserAccelerationReading {
            
            return "\(String(format: "%.3f", lastUserAccelerationReading.x)), \(String(format: "%.3f", lastUserAccelerationReading.y)), \(String(format: "%.3f", lastUserAccelerationReading.z))"
        }
        
        return nil
    }
    
    public func getLastMagnetometerReading() -> String? {
        
        let lastMagneticFieldReading = magneticFieldData.getLastReading()
        
        if let lastMagneticFieldReading = lastMagneticFieldReading {
            
            return "\(String(format: "%.3f", lastMagneticFieldReading.x)), \(String(format: "%.3f", lastMagneticFieldReading.y)), \(String(format: "%.3f", lastMagneticFieldReading.z))"
        }
        
        return nil
    }
    
    public func getLastGyroscopeReading() -> String? {
        
        let lastRotationRateReading = rotationData.getLastReading()
        
        if let lastRotationRateReading = lastRotationRateReading {
            
            return "\(String(format: "%.3f", lastRotationRateReading.x)), \(String(format: "%.3f", lastRotationRateReading.y)), \(String(format: "%.3f", lastRotationRateReading.z))"
        }
        
        return nil
    }
    
    public func stopDataCollection() {
        
        self.motionManager.stopDeviceMotionUpdates()
    }
    
    private func exportCSVFile() {
        
    }
}
