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
}
