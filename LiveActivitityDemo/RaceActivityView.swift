//
//  RaceActivityView.swift
//  LiveActivityDemo
//
//  Created by Izabela Reis on 11/12/24.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct RaceActivityView: View {

    let raceName: String
    let driverName: String
    let bpm: Int
    let averageSpeed: Int
    let ranking: Int
    let totalLaps: Int
    let currentLap: Int

    init(context: ActivityViewContext<RaceAttributes>) {
        self.raceName = context.attributes.raceName
        self.driverName = context.state.driverName
        self.bpm = context.state.bpm
        self.averageSpeed = context.state.averageSpeed
        self.ranking = context.state.ranking
        self.totalLaps = context.state.totalLaps
        self.currentLap = context.state.currentLap
    }

    init(raceName: String, driverName: String, bpm: Int, averageSpeed: Int, ranking: Int, totalLaps: Int, currentLap: Int) {
        self.raceName = raceName
        self.driverName = driverName
        self.bpm = bpm
        self.averageSpeed = averageSpeed
        self.ranking = ranking
        self.totalLaps = totalLaps
        self.currentLap = currentLap
    }

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            HStack(spacing: 5) {
                Text(raceName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 4)
            }
            HStack {
                Text("🏎️ Racer: \(driverName)")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer()
                Text("❤️ BPM: \(bpm)")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }

            HStack(spacing: 16) {
                Text("💨 Speed: \(averageSpeed) km/h")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer()
                Text("🏁 RTH: \(ranking)")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }

            Text("📍 Lap \(currentLap) of \(totalLaps)")
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.top, 4)

            progressView
        }
        .padding(16)
        .background(Color.black)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 2)
    }

   public var progressView: some View {
        ZStack(alignment: .leading) {
            ProgressView(value: Double(currentLap), total: Double(totalLaps))
                .progressViewStyle(LinearProgressViewStyle(tint: .red))
                .frame(height: 12)
                .background(Color.black.opacity(0.5))
                .cornerRadius(6)

            GeometryReader { geometry in
                let progress = Double(currentLap) / Double(totalLaps)
                Image(systemName: "flag.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundColor(.white)
                    .offset(x: CGFloat(progress) * geometry.size.width - 8)
            }
        }
        .padding(.top, 8)
    }
}

// MARK: - Previews
#Preview {
    let mock = MockDataManager.nextRacer()

    return RaceActivityView(raceName: MockDataManager.raceName,
                            driverName: mock.driverName,
                            bpm: mock.bpm,
                            averageSpeed: mock.averageSpeed,
                            ranking: mock.ranking,
                            totalLaps: mock.totalLaps,
                            currentLap: mock.currentLap)
}
