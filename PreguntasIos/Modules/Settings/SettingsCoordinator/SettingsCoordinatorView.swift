//
//  SettingsCoordinatorView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 14/3/22.
//

import SwiftUI

struct SettingsCoordinatorView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var coordinator: SettingsCoordinator
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("settings_profile".localized())) {
                    ForEach(coordinator.settings.profile, id: \.self) { profileSetting in
                        Button {
                            coordinator.profileSettingSelected(profileSetting)
                        } label: {
                            Text(profileSetting.rawValue.localized())
                                .foregroundColor(Color.primary)
                        }

                    }
                }

//                Section(header: Text("settings_membership".localized())) {
//                    ForEach(viewModel.settings.membership, id: \.self) { membershipSetting in
//                        Button {
//                            viewModel.membershipSettingSelected(membershipSetting)
//                        } label: {
//                            Text(membershipSetting.rawValue.localized())
//                        }
//                    }
//                }

                Section(header: Text("settings_more".localized())) {
                    ForEach(coordinator.settings.more, id: \.self) { moreSetting in
                        Button {
                            coordinator.moreSettingSelected(moreSetting)
                        } label: {
                            Text(moreSetting.rawValue.localized())
                                .foregroundColor(Color.primary)
                        }
                    }
                }
            }
            .navigation(item: $coordinator.playersSetupViewModel, destination: { viewModel in
                PlayersSetupView(viewModel: viewModel)
            })
            .navigation(item: $coordinator.languageViewModel, destination: { viewModel in
                LanguageView(viewModel: viewModel)
            })
            .navigation(item: $coordinator.appFeedbackViewModel, destination: { viewModel in
                AppFeedbackView(viewModel: viewModel)
            })
            .sheet(item: $coordinator.openedURL) { url in
                SafariView(url: url)
                    .edgesIgnoringSafeArea(.all)
            }
            .navigationTitle("settings_title".localized())
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.primary)
                    })
                }
            })
        }
    }
}

struct SettingsCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SettingsCoordinatorView(coordinator: SettingsCoordinator(gameAPIService: GameApiClient()))
            SettingsCoordinatorView(coordinator: SettingsCoordinator(gameAPIService: GameApiClient()))
                .preferredColorScheme(.dark)
        }
    }
}
