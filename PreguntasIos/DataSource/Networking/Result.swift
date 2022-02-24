//
//  Result.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import Foundation

public enum Result<T: Equatable>: Equatable {
    case success(T)
    case failure(Error)

    public static func == (lhs: Result<T>, rhs: Result<T>) -> Bool {
        return true
    }
}
