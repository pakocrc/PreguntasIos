//
//  PreguntasIosApp.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import Combine
import SwiftUI

@main
struct PreguntasIosApp: App {
    @State private var loadingData = true

    private let splashViewModel = SplashViewModel(apiClient: GameApiClient())

    var body: some Scene {
        WindowGroup {
            if loadingData {
                SplashView(viewModel: splashViewModel)
                    .onReceive(splashViewModel.$dataLoaded.filter({ $0 == true })) { _ in
                        loadingData.toggle()
                    }
            } else {
                    HomeCoordinatorView(coordinator:
                                            HomeCoordinator(questions: splashViewModel.questions ??
                                                            Questions(questions: [], categories: [])))
            }
        }
    }
}
