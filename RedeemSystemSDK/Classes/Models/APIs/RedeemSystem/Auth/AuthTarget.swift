//
//  AuthTarget.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/3/1.
//

import Foundation

protocol AuthTarget: TargetType {
    var environment: APIEnvironment { get }
}

struct AuthEndpoint: Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension AuthTarget {
    var baseURL: URL {
        switch environment {
        case .mainnet: return URL(string: "https://mainnet-api.redreamer.io")!
        case .testnet: return URL(string: "https://testnet-api.redreamer.io")!
        case .devnet: return URL(string: "https://devnet-api.redreamer.io")!
        case .local: return URL(string: "http://localhost:5001")!
        }
    }
    var headers: [String : String]? { nil }
}
