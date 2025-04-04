//
//  LiveActivitityDemoApp.swift
//  LiveActivitityDemo
//
//  Created by Izabela Reis on 11/12/24.
//

import SwiftUI

@main
struct LiveActivityDemoApp: App {
    
    @StateObject var viewModel = LiveActivityViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
