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
            Text("app_name".localized().uppercased())
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding()

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .font(.largeTitle)
                .padding()
        }
        .alert("alert".localized(),
               isPresented: $viewModel.showErrorMessage, actions: {
            Button("splash_view_reload_button_title".localized(), action: {
                viewModel.loadData()
            })
        }, message: { Text(viewModel.errorMessage ?? "") })
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SplashView(viewModel: SplashViewModel(apiClient: GameApiClient()))

            SplashView(viewModel: SplashViewModel(apiClient: GameApiClient()))
                .preferredColorScheme(.dark)
        }
    }
}
