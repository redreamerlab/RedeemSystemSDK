//
//  PassportTarget.swift
//  REVIEW
//
//  Created by 張家齊 on 2023/3/1.
//

import Foundation

protocol PassportTarget: TargetType {
    var environment: APIEnvironment { get }
    var apiKey: String { get }
    var accessToken: String? { get }
}

struct PassportEndpoint: Endpoint {
    let path: String
    let queryItems = [URLQueryItem]()
}

extension PassportTarget {
    var baseURL: URL {
        switch environment {
        case .Mainnet: return URL(string: "https://mainnet-api.redreamer.io/")!
        case .Testnet: return URL(string: "https://testnet-api.redreamer.io/")!
        case .Devnet: return URL(string: "https://devnet-api.redreamer.io")!
        case .Local: return URL(string: "http://localhost:5001")!
        }
    }
    var headers: [String : String]? {
        var headers = ["Content-Type": "application/json", "X-API-Key": apiKey]
        if let token = accessToken {
            headers["authorization"] = "Bearer \(token)"
        }
        return headers
    }
}
