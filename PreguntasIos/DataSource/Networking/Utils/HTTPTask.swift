//
//  HTTPTaks.swift
//  PreguntasIos
//
//  Created by Francisco Cordoba on 23/2/22.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public enum HTTPTask {
    case request
    case requestParameters(bodyParameters: Parameters?, bodyEncoding: ParameterEncoding, urlParameters: Parameters?)
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                     bodyEncoding: ParameterEncoding,
                                     urlParameters: Parameters?,
                                     additionHeaders: HTTPHeaders?)
    // case download, upload, etc...
}
