//
//  HomeView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    var body: some View {
        VStack {
            Text("Home!!")
                .padding()
            Text("Presenting categories")
                .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(
            categories: [QuestionCategory.friends, QuestionCategory.life, QuestionCategory.dirty],
            questions: []))
    }
}
