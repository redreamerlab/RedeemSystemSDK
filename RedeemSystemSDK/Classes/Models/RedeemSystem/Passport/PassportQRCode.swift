//
//  PassportQRCode.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/3/1.
//

import Foundation

public struct PassportQRCode: Codable {
    /*
     REDREAMER:eyJuZXR3b3JrIjoiZXRoIiwiY2FtcGFpZ25faWQiOiI5ZjYzYjA1Mi02ZDAwLTQ5NzQtOWI0OS1mZDJjZDgyMjA5N2MiLCJjb250cmFjdF9hZGRyZXNzIjoiMHhlNTRiOGYzMDU5ZDQxYzk0YTc4ODM1OTI5MWRlYTk1MDk5ZjBhYWRjIiwidG9rZW5faWQiOjI5LCJyZXF1ZXN0ZXJfYWRkcmVzcyI6IjB4ODViN2NhMTYxYzMxMWQ5YTVmMDA3N2Q1MDQ4Y2FkZmFjZTg5YTI2NyIsImhhc2giOiJkYjNmNDM5Ny1lMmJmLTQ1ZDgtYjU5Mi1iNTYzZTliYTljZjIifQ==
     
     {
     "network" : "eth"
     "campaign_uuid" : "9f63b052-6d00-4974-9b49-fd2cd822097c"
     "contract_address : "0xe54b8f3059d41c94a788359291dea95099f0aadc"
     "requester_address : "0x85b7ca161c311d9a5f0077d5048cadface89a267"
     "hash" : "db3f4397-e2bf-45d8-b592-b563e9ba9cf2"
     "tokenId" : 29
     }
     */
    public let network, campaignUuid, hash: String
    public let contractAddress, requesterAddress, collectionName, requester: String?
    public let tokenId, assetId: Int?
    
    public init?(qrcode: String) {
        guard qrcode.hasPrefix("REDREAMER:") else { return nil }
        let base64 = String(qrcode.dropFirst("REDREAMER:".count))
        guard let data = Data(base64Encoded: base64) else { return nil }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let passportQRCode = try? decoder.decode(PassportQRCode.self, from: data) else { return nil }
        self = passportQRCode
    }
}
