//
//  Passport.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/3/1.
//

import Combine

public class Passport {
    public static let shared = Passport()
    
    private init() {}
}

extension Passport {
    public func verify(environment: APIEnvironment? = nil, apiKey: String? = nil, passportQRCode: PassportQRCode) -> AnyPublisher<PassportCampaign, RedeemSystemError> {
        let apiKey = apiKey ?? RedeemSystem.shared.apiKey
        guard let apiKey = apiKey else { return Fail<PassportCampaign, RedeemSystemError>(error: .unknown).eraseToAnyPublisher() }
        return PassportAPI.Verify(
            environment: environment ?? RedeemSystem.shared.environment,
            apiKey: apiKey,
            passportQRCode: passportQRCode
        )
        .request()
        .mapRedeemSystemError()
        .eraseToAnyPublisher()
    }
    
    public func getCampaigns(network: Network? = nil, apiKey: String? = nil, environment: APIEnvironment? = nil) -> AnyPublisher<[PassportCampaign], RedeemSystemError> {
        let apiKey = apiKey ?? RedeemSystem.shared.apiKey
        guard let apiKey = apiKey else { return Fail<[PassportCampaign], RedeemSystemError>(error: .unknown).eraseToAnyPublisher() }
        return PassportAPI.Campaigns(
            network: network ?? RedeemSystem.shared.network,
            environment: environment ?? RedeemSystem.shared.environment,
            apiKey: apiKey
        )
        .request()
        .mapRedeemSystemError()
        .map { $0.data }
        .eraseToAnyPublisher()
    }
    
    public func getRNFTs(network: Network? = nil, apiKey: String? = nil, environment: APIEnvironment? = nil, campaignUuid: String) -> AnyPublisher<[NFTMetadata], RedeemSystemError> {
        let apiKey = apiKey ?? RedeemSystem.shared.apiKey
        guard let apiKey = apiKey else { return Fail<[NFTMetadata], RedeemSystemError>(error: .unknown).eraseToAnyPublisher() }
        return PassportAPI.GetRNFTs(
            network: network ?? RedeemSystem.shared.network,
            environment: environment ?? RedeemSystem.shared.environment,
            apiKey: apiKey,
            campaignUuid: campaignUuid,
            accessToken: RedeemSystem.shared.accessToken
        )
        .request()
        .mapRedeemSystemError()
        .map { $0.data }
        .eraseToAnyPublisher()
    }
    
    public func postRedemption(
        network: Network? = nil,
        apiKey: String? = nil,
        environment: APIEnvironment? = nil,
        campaignUuid: String,
        contractAddress: String,
        signature: String,
        tokenId: Int
    ) -> AnyPublisher<PassportRedemption, RedeemSystemError> {
        let apiKey = apiKey ?? RedeemSystem.shared.apiKey
        guard let apiKey = apiKey else { return Fail<PassportRedemption, RedeemSystemError>(error: .unknown).eraseToAnyPublisher() }
        return PassportAPI.PostRedemption(
            network: network ?? RedeemSystem.shared.network,
            environment: environment ?? RedeemSystem.shared.environment,
            apiKey: apiKey,
            campaignUuid: campaignUuid,
            signature: signature,
            contractAddress: contractAddress,
            tokenId: tokenId,
            accessToken: RedeemSystem.shared.accessToken
        )
        .request()
        .mapRedeemSystemError()
        .eraseToAnyPublisher()
    }
}
