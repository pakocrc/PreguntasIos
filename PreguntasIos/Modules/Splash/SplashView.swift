//
//  SplashView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import SwiftUI

struct SplashView: View {
    @ObservedObject var viewModel: SplashViewModel

    var body: some View {
        VStack {
            Text(NSLocalizedString("app_name", comment: "App name").uppercased())
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding()

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .font(.largeTitle)
                .padding()
        }
        .alert(NSLocalizedString("splash_view_alert_title", comment: "Alert"),
               isPresented: $viewModel.showErrorMessage, actions: {
            Button(NSLocalizedString("splash_view_reload_button_title", comment: "Reload"), action: {
                viewModel.loadData()
            })
        }, message: { Text(viewModel.errorMessage ?? "") })
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SplashView(viewModel: SplashViewModel(apiClient: GameAPIClient()))

            SplashView(viewModel: SplashViewModel(apiClient: GameAPIClient()))
                .preferredColorScheme(.dark)
        }
    }
}
