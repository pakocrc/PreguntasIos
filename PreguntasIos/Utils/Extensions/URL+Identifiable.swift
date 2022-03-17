//
//  URL+Identifiable.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 14/3/22.
//

import Foundation

extension URL: Identifiable {
    public var id: String {
        absoluteString
    }
}
