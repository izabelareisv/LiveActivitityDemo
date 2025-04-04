//
//  MockDataManager.swift
//  LiveActivitityDemo
//
//  Created by Izabela Reis on 14/12/24.
//

import Foundation

// Gerenciador de dados simulados para a Live Activity
public struct MockDataManager {

    // Dados simulados dos pilotos da corrida
    static var mockData: [RaceAttributes.RaceStatus] = [
        .init(driverName: "Max Verstappen", bpm: 120, averageSpeed: 220, ranking: 1, totalLaps: 70, currentLap: 35),
        .init(driverName: "Lewis Hamilton", bpm: 125, averageSpeed: 218, ranking: 2, totalLaps: 70, currentLap: 36),
        .init(driverName: "Charles Leclerc", bpm: 130, averageSpeed: 215, ranking: 3, totalLaps: 70, currentLap: 37),
        .init(driverName: "Sergio Perez", bpm: 122, averageSpeed: 210, ranking: 4, totalLaps: 70, currentLap: 38),
        .init(driverName: "Fernando Alonso", bpm: 118, averageSpeed: 205, ranking: 5, totalLaps: 70, currentLap: 39)
    ]

    // Índice atual para controlar a rotação dos pilotos
    private static var currentIndex = 0

    /// Retorna os dados do próximo piloto na lista
    /// - Returns: `RaceAttributes.RaceStatus` com os dados do piloto atual
    static func nextRacer() -> RaceAttributes.RaceStatus {
        let participant = mockData[currentIndex]
        currentIndex = (currentIndex + 1) % mockData.count // Avança para o próximo índice
        return participant
    }

    /// Nome da corrida simulada
    static var raceName: String {
        "Grand Prix Brasil"
    }
}
