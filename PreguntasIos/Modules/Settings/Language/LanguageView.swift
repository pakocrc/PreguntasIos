//
//  LanguageView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 14/3/22.
//

import SwiftUI

struct LanguageView: View {
    @ObservedObject var viewModel: LanguageViewModel

    var body: some View {
        List {
            ForEach(Language.allCases, id: \.self) { language in
                Button(action: {
                    if language != viewModel.preferedLanguage {
                        viewModel.setLanguage(language: language)
                    }
                }, label: {
                    HStack {
                        Text(getLanguageText(language))
                            .font(.body)
                            .foregroundColor(.primary)

                        if language == viewModel.preferedLanguage {
                            Spacer()
                            Image(systemName: "checkmark")
                                .font(.body)
                                .foregroundColor(.primary)
                        }
                    }
                })
            }
        }
        .navigationTitle(Text("language_view_title".localized()))
        .alert(isPresented: $viewModel.showAlertMessage, content: {
            return Alert(title: Text("alert".localized()),
                         message: Text(viewModel.alertMessage ?? ""),
                         primaryButton:
                                .destructive(Text("cancel".localized())),
                         secondaryButton: .default(Text("ok".localized()),
                                                   action: {
                viewModel.setLanguageConfirmed()
            }))
        })
    }

    private func getLanguageText(_ language: Language) -> String {
        var languageText = ""

        switch language {
        case .en:
            languageText = "language_view_en".localized()
        case .es:
            languageText = "language_view_es".localized()
        case .pt:
            languageText = "language_view_pt".localized()
        }

        return languageText
    }
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LanguageView(viewModel: LanguageViewModel())

            LanguageView(viewModel: LanguageViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
