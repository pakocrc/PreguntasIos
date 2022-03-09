//
//  SettingsView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 27/2/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        NavigationView {
            List {
                Section(header: Text(NSLocalizedString("settings_profile", comment: ""))) {
                    ForEach(viewModel.settings.profile, id: \.self) { profileSetting in
                        Button {
                            viewModel.profileSettingSelected(profileSetting)
                        } label: {
                            Text(NSLocalizedString(profileSetting.rawValue, comment: ""))
                        }

                    }
                }

                Section(header: Text(NSLocalizedString("settings_membership", comment: ""))) {
                    ForEach(viewModel.settings.membership, id: \.self) { membershipSetting in
                        Button {
                            viewModel.membershipSettingSelected(membershipSetting)
                        } label: {
                            Text(NSLocalizedString(membershipSetting.rawValue, comment: ""))
                        }
                    }
                }

                Section(header: Text(NSLocalizedString("settings_more", comment: ""))) {
                    ForEach(viewModel.settings.more, id: \.self) { moreSetting in
                        Button {
                            viewModel.moreSettingSelected(moreSetting)
                        } label: {
                            Text(NSLocalizedString(moreSetting.rawValue, comment: ""))
                        }
                    }
                }
            }
            .navigationTitle(NSLocalizedString("settings_title", comment: ""))
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel())
    }
}
