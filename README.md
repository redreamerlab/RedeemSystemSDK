# RedeemSystemSDK

[![CI Status](https://img.shields.io/travis/redreamerlab/RedeemSystemSDK.svg?style=flat)](https://travis-ci.org/redreamerlab/RedeemSystemSDK)
[![Version](https://img.shields.io/cocoapods/v/RedeemSystemSDK.svg?style=flat)](https://cocoapods.org/pods/RedeemSystemSDK)
[![License](https://img.shields.io/cocoapods/l/RedeemSystemSDK.svg?style=flat)](https://cocoapods.org/pods/RedeemSystemSDK)
[![Platform](https://img.shields.io/cocoapods/p/RedeemSystemSDK.svg?style=flat)](https://cocoapods.org/pods/RedeemSystemSDK)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

RedeemSystemSDK requires iOS 13.0+.

## Installation

RedeemSystemSDK is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod ‘RedeemSystemSDK’
```

## Usage

### Initialize the Redeem System SDK

```swift
import RedeemSystemSDK
```

Then, in the `application:didFinishLaunchingWithOptions:` method, initialize the `RedeemSystem` object:

```swift
RedeemSystem.shared.configure(environment: .mainnet, apiKey: “${apiKey}“, network: .eth)
```

APIEnvironment has 4 attributes.

- mainnet
- testnet
- devnet
- local

And Network has 4 blockchains supported by Redeem Sytem.

- eth
- polygon
- tt
- bnb

### Auth

#### Get the login message to sign

Get the login message of the address to sign.

```swift
Auth.shared.loginSignMessage(address: address)
```

#### Log in with your wallet address

Connect a wallet that allows users to sign a `loginSignMessage`. When a user signs the signature, call the `login` method:

```swift
Auth.shared.login(address: address, signature: signature)
```

And it will store the `accessToken` and `refreshToken` to `RedeemSystem`, token will be used for all of the APIs that need authorization.

### Passport

#### List Passport campaigns by network

List all of the public campaigns by the network.

```swift
Passport.shared.getCampaigns()
```

It will use the default parameters stored in `RedeemSystem`, and you also can use specific parameters in this function.

```swift
Passport.shared.getCampaigns(network: network, apiKey: apiKey, environment: environment)
```

#### List all Redeemable NFTs by the campaign

```swift
Passport.shared.getRNFTs(campaignUuid: campaignUuid)
```

#### Create a redemption of Passport by campaign

The signature is signed by the RNFT holder within the message format:

```
campaign_uuid:${campaignUuid},contract_address:${contractAddress},token_id:${tokenId}
```

```swift
Passport.shared.postRedemption(campaignUuid: campaignUuid, contractAddress: contractAddress, signature: signature, tokenId: tokenId)
```

When users create a redemption, they will sometimes return the Passport QR code content for the redemption, which could be validated by Verify API.

#### Verify a redemption

With the API key has the scope (`passport:validate`) to verify the Passport QR code.

```swift
Passport.shared.verify(passportQRCode)
```

## Development

To develop Redeem System software in this repository, ensure that you have at least the following software:

- Xcode 14.2 (or later)

## Testing

### Running Unit Tests

Select a scheme, press Command-U to build a component, and run this unit test.

## Author

RE:DREAMER Lab, dev@redreamer.io

## License

RedeemSystemSDK is available under the MIT license. See the LICENSE file for more info.
