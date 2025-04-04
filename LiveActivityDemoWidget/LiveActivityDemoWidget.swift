//
//  LiveActivityDemoWidget.swift
//  LiveActivityDemoWidget
//
//  Created by Izabela Reis on 11/12/24.
//

import ActivityKit
import SwiftUI
import WidgetKit

/// Widget principal para demonstrar a Live Activity.
/// Mostra informações de progresso de uma corrida.
struct LiveActivityDemoWidget: Widget {
    let kind: String = "LiveActivityDemoWidget" // Id único para o widget

    var body: some WidgetConfiguration {

        // MARK: - Configuração da Live Activity
        ActivityConfiguration(for: RaceAttributes.self) { context in
            // Visualização principal da Live Activity
            RaceActivityView(context: context)
                .containerBackground(for: .widget) {
                    Color.black
                }
        } dynamicIsland: { context in
            // MARK: - Configuração da Dynamic Island
            DynamicIsland {
                // MARK: - Região Expandida (Superior e Inferior)
                DynamicIslandExpandedRegion(.leading) {
                    Text("🏁 Race in Progress")
                        .foregroundColor(.white)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("RTH: \(context.state.ranking)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack(alignment: .center) {
                        // Nome do piloto
                        Text("\(context.state.driverName)")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.bottom, 4)

                        // Barra de progresso com ícone de bandeira
                        ZStack(alignment: .leading) {
                            ProgressView(value: Double(context.state.currentLap), total: Double(context.state.totalLaps))
                                .progressViewStyle(LinearProgressViewStyle(tint: .red)) // Estilo de progresso
                                .frame(height: 10)
                                .padding(.horizontal, 16)

                            // Ícone de bandeira se movendo na barra de progresso
                            GeometryReader { geometry in
                                let progress = Double(context.state.currentLap) / Double(context.state.totalLaps)
                                Image(systemName: "flag.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 16, height: 16)
                                    .foregroundColor(.white)
                                    .offset(x: CGFloat(progress) * geometry.size.width - 8)
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                }
            }
            // MARK: - Compact View (Dynamic Island)
            compactLeading: {
                Text("📍 \(context.state.ranking)") // Ranking na visão compacta à esquerda
            }
            compactTrailing: {
                Text("Lap \(context.state.currentLap)") // Lap atual na visão compacta à direita
            }
            minimal: {
                Text("🏁") // Ícone minimalista
            }
        }
    }
}

// MARK: - Previews
struct LiveActivityDemoWidget_Previews: PreviewProvider {

    static var previews: some View {
        // Mock de atributos e estado
        let mockAttributes = RaceAttributes(raceName: "Grand Prix Brasil")
        let mockState = RaceAttributes.ContentState(driverName: "Max Verstappen",
                                                    bpm: 120,
                                                    averageSpeed: 220,
                                                    ranking: 1,
                                                    totalLaps: 70,
                                                    currentLap: 35)

        // Widget Médio
        return Group {
            RaceActivityView(raceName: mockAttributes.raceName,
                             driverName: mockState.driverName,
                             bpm: mockState.bpm,
                             averageSpeed: mockState.averageSpeed,
                             ranking: mockState.ranking,
                             totalLaps: mockState.totalLaps,
                             currentLap: mockState.currentLap)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
            .containerBackground(for: .widget) {
                Color.black
            }
        }
    }
}
