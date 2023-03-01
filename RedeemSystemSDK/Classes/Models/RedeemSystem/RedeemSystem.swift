//
//  RedeemSystem.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/3/1.
//

import Foundation

public class RedeemSystem {
    public static let shared = RedeemSystem()
    
    public internal(set) var environment: APIEnvironment = .mainnet
    var apiKey: String? = nil
    var network: Network = .eth
    var accessToken: String? = nil
    var refreshToken: String? = nil
    
    private init() {}
    
    public func configure(environment: APIEnvironment? = nil, apiKey: String? = nil, network: Network? = nil) {
        if let environment = environment {
            self.environment = environment
        }
        if let apiKey = apiKey {
            self.apiKey = apiKey
        }
        if let network = network {
            self.network = network
        }
    }
}
