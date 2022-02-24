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
            Text("PREGUNTAS")
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding()

            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .font(.largeTitle)
                .padding()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SplashView(viewModel: SplashViewModel())

            SplashView(viewModel: SplashViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
