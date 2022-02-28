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
        ScrollView {
            ForEach(viewModel.categories, id: \.self) { category in
                CategoryButtonView(category: category.rawValue) {
                    viewModel.categorySelected(category: category)
                }
            }
        }
        .navigationTitle(NSLocalizedString("app_name", comment: ""))

        .toolbar {
            NavigationLink(destination: SettingsView(viewModel: SettingsViewModel())) {
                Image(systemName: "gear")
            }

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            let categories = [QuestionCategory.friends,
                              QuestionCategory.life,
                              QuestionCategory.dirty,
                              QuestionCategory.mixed,
                              QuestionCategory.all]

            HomeView(viewModel: HomeViewModel(
                categories: categories,
                questions: []))
                .preferredColorScheme(.light)
            HomeView(viewModel: HomeViewModel(
                categories: categories,
                questions: []))
                .preferredColorScheme(.dark)
        }
    }
}
