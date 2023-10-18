//
//  REVIEWValidation.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/7/7.
//

import Foundation

public struct REVIEWValidation: Decodable {
    /*
     {
             "utility": {
                 "requester_address": "0x",
                 "campaign_uuid": "",
                 "token_id": 1,
                 "created_at": "2023-06-30T07:05:08.789Z",
                 "id": "0x00",
                 "contract_address": "0x",
                 "hash": "0a6cda6e-8957-4cd4-a619-2ba75566de21",
                 "network": "polygon",
                 "updated_at": "2023-06-30T07:07:41.839Z",
                 "validated": true,
                 "validator": "6I8UY-fP3LAfNUZP8cPHPukrvqryrfyliIepfixkYwE=",
                 "validated_at": "2023-06-30T07:07:41.839Z"
             },
             "validated_at": "2023-06-30T07:07:41.839Z"
         }
     */
    public let utility: REVIEWUtility
    public let validatedAt: String
}

public struct REVIEWUtility: Decodable {
    /*
     {
         "requester_address": "0x",
         "campaign_uuid": "",
         "token_id": 1,
         "created_at": "2023-06-30T07:05:08.789Z",
         "id": "0x00",
         "contract_address": "0x",
         "hash": "0a6cda6e-8957-4cd4-a619-2ba75566de21",
         "network": "polygon",
         "updated_at": "2023-06-30T07:07:41.839Z",
         "validated": true,
         "validator": "6I8UY-fP3LAfNUZP8cPHPukrvqryrfyliIepfixkYwE=",
         "validated_at": "2023-06-30T07:07:41.839Z"
     }
     */
    public let campaignUuid, requesterAddress, createdAt, id, contractAddress, hash, updatedAt, validator, validatedAt: String
    public let tokenId: Int
    public let network: Network
    public let validated: Bool
}
