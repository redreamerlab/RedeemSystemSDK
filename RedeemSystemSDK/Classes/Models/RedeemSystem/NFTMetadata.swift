//
//  NFTMetadata.swift
//  RedeemSystemSDK
//
//  Created by 張家齊 on 2023/3/1.
//

import Foundation

public class NFTMetadata: Decodable {
    /*
     {
         "name": "Winter crypto snowman #1",
         "description": "Collection of 20 winter crypto snowman NFTs",
         "image": "ipfs://QmY9KGDbeaJnXqBVSBAsfwUSN9tMuRbrMWniRz9HVxW8yY/1.png",
         "external_url": "",
         "animation_url": "",
         "attributes": [
             {
                 "trait_type": "Body",
                 "value": "Work suit"
             }
         ]
     }
     */
    public let tokenId: Int?
    public let name, description, image: String
    public let contractAddress: String?
    public let network: Network?
}
