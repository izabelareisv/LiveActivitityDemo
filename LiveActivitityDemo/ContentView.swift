//
//  ContentView.swift
//  LiveActivityDemo
//
//  Created by Izabela Reis on 11/12/24.
//

import ActivityKit
import SwiftUI
import UserNotifications

struct ContentView: View {

    @ObservedObject var viewModel: LiveActivityViewModel

    var body: some View {
        NavigationView {
            ZStack {
                backgroundImage
                actionButtons
            }
            .navigationTitle("Race Track 🏁")
        }
    }

    var backgroundImage: some View {
        Image("background2")
            .resizable()
            .scaledToFill()
            .edgesIgnoringSafeArea(.all)
    }

    var actionButtons: some View {
        VStack {
            Spacer()
            VStack(spacing:0) {
                Button(action: { viewModel.startActivity() }) {
                    HStack {
                        Spacer()
                        Text("Start Race 🏎️💨").font(.headline)
                        Spacer()
                    }.frame(height: 80)
                }.tint(.blue)

                Button(action: { viewModel.stopActivity() }) {
                    HStack {
                        Spacer()
                        Text("Cancel Race 🛑").font(.headline)
                        Spacer()
                    }.frame(height: 80)
                }.tint(.pink)
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle(radius: 0))
            .background(.thickMaterial)
            .cornerRadius(25)
            .padding(.horizontal,5)
        }
    }
}

#Preview {
    ContentView(viewModel: LiveActivityViewModel())
}
