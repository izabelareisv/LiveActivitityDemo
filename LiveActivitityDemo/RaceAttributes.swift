//
//  TimerAttribuites.swift
//  LiveActivitityDemo
//
//  Created by Izabela Reis on 11/12/24.
//

import ActivityKit
import SwiftUI

// Definição de atributos para a Live Activity
struct RaceAttributes: ActivityAttributes {

    // Define o estado da corrida, representando o estado dinâmico da Live Activity
    public typealias RaceStatus = ContentState

    // Estrutura que armazena os dados dinâmicos da corrida
    public struct ContentState: Codable, Hashable {
        // Nome do piloto atual
        var driverName: String
        // Batimentos cardíacos do piloto
        var bpm: Int
        // Velocidade média do piloto (km/h)
        var averageSpeed: Int
        // Posição atual do piloto na corrida
        var ranking: Int
        // Total de voltas na corrida
        var totalLaps: Int
        // Volta atual que o piloto está correndo
        var currentLap: Int
    }

    // Atributo fixo da corrida, representando o nome da corrida
    var raceName: String
}
