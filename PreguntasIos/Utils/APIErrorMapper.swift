//
//  APIErrorMapper.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 25/2/22.
//

import Foundation

struct APIErrorMapper {
    // MARK: - Properties
    let error: APIError

    // MARK: - Public API
    var message: String {
        switch error {
        case .unreachable:
            return NSLocalizedString("api_error_mapper_unreachable", comment: "")
        case .unknown,
                .failedRequest,
                .invalidResponse,
                .unauthorized:
            return NSLocalizedString("api_error_mapper_failed_request", comment: "")
        }
    }
}
