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

### Initialization

```swift
import RedeemSystemSDK
```

In the `application:didFinishLaunchingWithOptions:` method, initialize the `RedeemSystem` object:

```swift
RedeemSystem.shared.configure(environment: .mainnet, apiKey: “${apiKey}“, network: .eth)
```

| Parameter   | Value | Description |
|-------------|-------|-------------|
| environment | `mainnet` / `testnet` / `devnet` / `local` |             |
| apiKey      | String                                     | Contact dev@redreamer.io to get the API key |
| network     | `eth` / `polygon` / `tt` / `bnb`           | Unique identifier of the network |

### Auth

#### STEP 1 - Get the message to be signed

The function below will return `String` message which needs to be signed by the connected wallet.

```swift
Auth.shared.loginSignMessage(address: address)
```

| Parameter   | Value | Description |
|-------------|-------|-------------|
| address | String | The wallet address of the user |

#### STEP 2 - Login with your wallet address

Sign the `String` message from STEP 1 with the connected wallet private key.

#### STEP 3 - Login with your wallet address

Connect the wallet which sign the message and call the `login` method:

```swift
Auth.shared.login(address: address, signature: signature)
```

| Parameter   | Value | Description |
|-------------|-------|-------------|
| address | String | The wallet address of the user |
| signature | String | Signed message from STEP 2 |

The `login` method will store the `accessToken` and `refreshToken` to `RedeemSystem`. The token needs to be used for all API endpoints which need authorization.

### Redeem Passport

#### List Passport campaigns by given network

`getCampaigns` function will return list of public Passport campaigns by given network. By default, parameters in `RedeemSystem` will be used.

```swift
Passport.shared.getCampaigns()
```

If it's needed, parameters also can be specified when calling this function.

```swift
Passport.shared.getCampaigns(network: network, apiKey: apiKey, environment: environment)
```

| Parameter   | Value | Description |
|-------------|-------|-------------|
| network     | `eth` / `polygon` / `tt` / `bnb`           | Unique identifier of the network |
| apiKey      | String                                     | Contact dev@redreamer.io to get the API key |
| environment | `mainnet` / `testnet` / `devnet` / `local` |             |

#### List all Redeemable NFTs by given Passport campaign

```swift
Passport.shared.getRNFTs(campaignUuid: campaignUuid)
```

| Parameter   | Value | Description |
|-------------|-------|-------------|
| campaignUuid | String | The unique identifier of the campaign for which the list of eligible RNFTs is being retrieved |

#### Redeem an NFT by given Passport campaign

**STEP 1 - Sign the message**

Below message needs to be signed by RNFT holder wallet.

```
campaign_uuid:${campaignUuid},contract_address:${contractAddress},token_id:${tokenId}
```

**STEP 2 - Redeem the NFT**

The signed message from STEP 1 can be used to redeem the NFT by calling function below.

```swift
Passport.shared.postRedemption(campaignUuid: campaignUuid, contractAddress: contractAddress, signature: signature, tokenId: tokenId)
```

| Parameter   | Value | Description |
|-------------|-------|-------------|
| campaignUuid | String | The unique identifier of the campaign |
| contractAddress | String | The address of the smart contract for the selected NFT |
| signature | String | Signed message from STEP 1 |
| tokenId | String | Unique identifier for an NFT within a specific smart contract |

After calling `postRedemption`, `passportQRCode` will be returned. This `passportQRCode` could be validated by calling `verify` function.

#### Verify a redemption

> **Warning**: make sure your API key has permission to do validation, i.e. `passport:validate` before calling `verify` function

Call function below to verify the `passportQRCode`

```swift
Passport.shared.verify(passportQRCode)
```

## Development

To develop Redeem System software in this repository, ensure that you have at least the following software:

- Xcode 14.2 (or later)

## Testing

### Running Unit Tests

1. Select a scheme
2. Press Command-U to build a component
3. Run this unit test

## Author

RE:DREAMER Lab, dev@redreamer.io

## License

RedeemSystemSDK is available under the MIT license. See the LICENSE file for more info.
