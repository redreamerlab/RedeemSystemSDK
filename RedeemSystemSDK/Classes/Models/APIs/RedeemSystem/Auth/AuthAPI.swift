//
//  AuthAPI.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/3/1.
//

import Foundation

enum AuthAPI {
    struct GetNonce: AuthTarget {
        struct ResponseType: Decodable {
            let nonce: String
        }
        
        let environment: APIEnvironment
        let address: String
        var endpoint: Endpoint {
            AuthEndpoint(
                path: "/api/v1/auth/nonce",
                queryItems: [
                    URLQueryItem(name: "address", value: address)
                ]
            )
        }
        let method: HTTPMethod = .GET
        let body: Data? = nil
    }
    
    struct Login: AuthTarget {
        struct ResponseType: Decodable {
            let token, refreshToken: String
        }
        
        let address, signature: String
        let environment: APIEnvironment
        var endpoint: Endpoint {
            AuthEndpoint(path: "/api/v1/auth/login", queryItems: [])
        }
        var body: Data? {
            let jsonObject: [String: String] = [
                "address": address,
                "signature": signature
            ]
            return try? JSONSerialization.data(
                withJSONObject: jsonObject, options: .prettyPrinted
            )
        }
        let method: HTTPMethod = .POST
    }
}
