//
//  LiveActivityViewModel.swift
//  LiveActivitityDemo
//
//  Created by Izabela Reis on 15/12/24.
//

import ActivityKit
import SwiftUI

class LiveActivityViewModel: ObservableObject {

    private var activity: Activity<RaceAttributes>? = nil
    private var timer: Timer? = nil

    // MARK: - Start Activity
    func startActivity() {
        let attributes = RaceAttributes(raceName: MockDataManager.raceName)
        let state = MockDataManager.nextRacer()
        let activityContent = ActivityContent(state: state, staleDate: nil)

        do {
            activity = try Activity<RaceAttributes>.request(attributes: attributes, content: activityContent, pushType: nil)
            print("Live Activity criada com piloto: \(state.driverName)")

            startUpdateTimer() // Inicia o Timer para atualizações periódicas
        } catch {
            print("Erro ao criar Live Activity: \(error.localizedDescription)")
        }
    }

    // MARK: - Stop Activity
    func stopActivity() {
        guard let activity = activity else {
            print("Nenhuma Live Activity em andamento para finalizar.")
            return
        }

        Task {
            await activity.end(nil, dismissalPolicy: .immediate)
            print("Live Activity finalizada.")
            stopUpdateTimer() // Para o Timer ao finalizar
            self.activity = nil // Limpar referência
        }
    }

    // MARK: - Atualizações com Timer
    func startUpdateTimer() {
        stopUpdateTimer() // Para qualquer Timer existente antes de iniciar um novo
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
            self.updateActivityWithMockData()
        }
        print("Timer iniciado para atualizações a cada 5 segundos.")
    }

    func stopUpdateTimer() {
        timer?.invalidate()
        timer = nil
        print("Timer parado.")
    }

    func updateActivityWithMockData() {
        guard let activity = activity else {
            print("Nenhuma Live Activity em andamento para atualizar.")
            return
        }

        let state = MockDataManager.nextRacer() // Obter os dados do próximo piloto
        let activityContent = ActivityContent(state: state, staleDate: nil)

        Task {
            await activity.update(activityContent)
            print("Live Activity atualizada para piloto: \(state.driverName)")
        }
    }
}
