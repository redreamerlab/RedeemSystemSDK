//
//  REVIEWTarget.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/7/6.
//

import Foundation

protocol REVIEWTarget: TargetType {
    var environment: APIEnvironment { get }
    var apiKey: String { get }
}

struct REVIEWEndpoint: Endpoint {
    let path: String
    let queryItems = [URLQueryItem]()
}

extension REVIEWTarget {
    var baseURL: URL { URL(string: "https://redreamer.review")! }
    var headers: [String : String]? {
        var headers = ["Content-Type": "application/json", "X-API-Key": apiKey]
        return headers
    }
}
