//
//  SafariView.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 14/3/22.
//

import SafariServices
import SwiftUI

struct SafariView: UIViewControllerRepresentable {
    // MARK: Stored Properties
    let url: URL

    // MARK: Methods
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let configuration = SFSafariViewController.Configuration()
        configuration.barCollapsingEnabled = false
        return SFSafariViewController(url: url, configuration: configuration)
    }

    func updateUIViewController(_ controller: SFSafariViewController, context: Context) {

    }
}
