//
//  ContentView.swift
//  DataCollectionDemo WatchKit Extension
//
//  Created by Tomás Mamede on 17/06/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var aggregator = WatchDataAggregator(sensors: [.accelerometer], updateInterval: 1.0 / 60.0, totalTimeGatheringData: 30)
    
    var body: some View {
        VStack {
            VStack {
                Text(aggregator.getLastAccelerometerReading() ?? "AD: No data")
                    .font(.caption)
                    .padding()
                Text(aggregator.getLastMagnetometerReading() ?? "MD: No data")
                    .font(.caption)
                    .padding()
                Text(aggregator.getLastGyroscopeReading() ?? "GD: No data")
                    .font(.caption)
                    .padding()
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    aggregator.startDataCollection()
                }, label: {
                    Text("Start")
                })
                Button(action: {
                    aggregator.stopDataCollection()
                }, label: {
                    Text("Stop")
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
