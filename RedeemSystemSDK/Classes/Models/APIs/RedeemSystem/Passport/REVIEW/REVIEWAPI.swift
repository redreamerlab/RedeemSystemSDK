//
//  REVIEWAPI.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/7/6.
//

import Foundation

enum REVIEWAPI {
    struct VerifyQRCode: REVIEWTarget {
        typealias ResponseType = REVIEWResponse
        
        let environment: APIEnvironment
        let apiKey: String
        let reviewQRCode: REVIEWQRCode
        var method: HTTPMethod { .POST }
        var body: Data? {
            var jsonObject: [String: Any] = [:]
            if reviewQRCode.network == "wax" {
                jsonObject = [
                    "requester": reviewQRCode.requester ?? "",
                    "asset_id": reviewQRCode.assetId ?? 1,
                    "hash": reviewQRCode.hash,
                    "collection_name": reviewQRCode.collectionName ?? ""
                ]
            } else {
                jsonObject = [
                    "requester_address": reviewQRCode.requesterAddress ?? "",
                    "contract_address": reviewQRCode.contractAddress ?? "",
                    "token_id": reviewQRCode.tokenId ?? 1,
                    "hash": reviewQRCode.hash,
                    "validator": apiKey
                ]
            }
            return try? JSONSerialization.data(
                withJSONObject: jsonObject, options: .prettyPrinted
            )
        }
        var endpoint: Endpoint {
            REVIEWEndpoint(path: "/api/v1/\(environment.rawValue.lowercased())/validations")
        }
    }
    
    struct Validations: REVIEWTarget {
        typealias ResponseType = [REVIEWValidation]
        
        let environment: APIEnvironment
        let apiKey: String
        let network: Network
        var method: HTTPMethod { .GET }
        var body: Data? { nil }
        var endpoint: Endpoint {
            REVIEWEndpoint(path: "/api/v1/\(network)/\(environment.rawValue.lowercased())/validations")
        }
    }
}

public struct REVIEWResponse: Decodable {
    public let message: String
    public let utility: REVIEWUtility
}

public struct REVIEWErrorResponse: Decodable, Error {
    public let message: String
}
