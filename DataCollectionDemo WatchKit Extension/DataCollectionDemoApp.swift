//
//  DataCollectionDemoApp.swift
//  DataCollectionDemo WatchKit Extension
//
//  Created by Tomás Mamede on 17/06/2021.
//

import SwiftUI

@main
struct DataCollectionDemoApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
