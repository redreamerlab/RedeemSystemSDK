//
//  PassportAPI.swift
//  REVIEW
//
//  Created by 張家齊 on 2023/3/1.
//

import Foundation

enum PassportAPI {
    struct Verify: PassportTarget {
        typealias ResponseType = PassportCampaign
        
        let environment: APIEnvironment
        let apiKey: String
        let accessToken: String? = nil
        let passportQRCode: PassportQRCode
        var method: HTTPMethod { .POST }
        var body: Data? {
            var jsonObject: [String: Any] = [:]
            if passportQRCode.network == "wax" {
                jsonObject = [
                    "requester": passportQRCode.requester ?? "",
                    "asset_id": passportQRCode.assetId ?? 1,
                    "hash": passportQRCode.hash,
                    "collection_name": passportQRCode.collectionName ?? ""
                ]
            } else {
                jsonObject = [
                    "requester_address": passportQRCode.requesterAddress ?? "",
                    "contract_address": passportQRCode.contractAddress ?? "",
                    "token_id": passportQRCode.tokenId ?? 1,
                    "hash": passportQRCode.hash,
                    "validator": apiKey
                ]
            }
            return try? JSONSerialization.data(
                withJSONObject: jsonObject, options: .prettyPrinted
            )
        }
        var endpoint: Endpoint { PassportEndpoint(path: "/api/v1/passport/\(passportQRCode.network)/campaigns/\(passportQRCode.campaignUuid)/validate") }
    }
    
    struct Campaigns: PassportTarget {
        struct ResponseType: Decodable {
            var data: [PassportCampaign]
        }
        
        let network: Network
        let environment: APIEnvironment
        let apiKey: String
        var endpoint: Endpoint { PassportEndpoint(path: "/api/v1/passport/\(network)/campaigns") }
        let method: HTTPMethod = .GET
        let body: Data? = nil
        let accessToken: String? = nil
    }
    
    struct GetRNFTs: PassportTarget {
        struct ResponseType: Decodable {
            var data: [NFTMetadata]
        }
        
        let network: Network
        let environment: APIEnvironment
        let apiKey, campaignUuid: String
        var endpoint: Endpoint { PassportEndpoint(path: "/api/v1/passport/\(network)/campaigns/\(campaignUuid)/nfts") }
        let method: HTTPMethod = .GET
        let body: Data? = nil
        let accessToken: String?
    }
    
    struct PostRedemption: PassportTarget {
        typealias ResponseType = PassportRedemption
        
        let network: Network
        let environment: APIEnvironment
        let apiKey, campaignUuid, signature, contractAddress: String
        let tokenId: Int
        var endpoint: Endpoint { PassportEndpoint(path: "/api/v1/passport/\(network)/campaigns/\(campaignUuid)/redemption") }
        let method: HTTPMethod = .POST
        var body: Data? {
            var jsonObject: [String: Any?] = [:]
            jsonObject["contract_address"] = contractAddress
            jsonObject["token_id"] = tokenId
            jsonObject["signature"] = signature
            return try? JSONSerialization.data(
                withJSONObject: jsonObject, options: .prettyPrinted
            )
        }
        let accessToken: String?
    }
}
