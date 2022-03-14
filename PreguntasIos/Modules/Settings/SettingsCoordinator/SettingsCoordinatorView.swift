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
//
//                Section(header: Text("settings_more".localized())) {
//                    ForEach(viewModel.settings.more, id: \.self) { moreSetting in
//                        Button {
//                            viewModel.moreSettingSelected(moreSetting)
//                        } label: {
//                            Text(moreSetting.rawValue.localized())
//                        }
//                    }
//                }
            }
            .navigation(item: $coordinator.playersSetupViewModel, destination: { viewModel in
                PlayersSetupView(viewModel: viewModel)
            })
            .navigation(item: $coordinator.languageViewModel, destination: { viewModel in
                LanguageView(viewModel: viewModel)
            })
            .navigationTitle("settings_title".localized())
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: { Image(systemName: "xmark") })
                }
            })
        }
    }
}

struct SettingsCoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCoordinatorView(coordinator: SettingsCoordinator())
    }
}
