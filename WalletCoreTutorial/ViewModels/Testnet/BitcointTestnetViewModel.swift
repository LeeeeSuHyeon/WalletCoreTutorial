//
//  BitcointTestnetViewModel.swift
//  WalletCoreTutorial
//
//  Created by 이수현 on 10/19/25.
//

import Foundation
import Combine
import WalletCore
import SwiftProtobuf


final class BitcointTestnetViewModel: ObservableObject {
    @Published var myAddress: String = ""
    @Published var output: String = ""
    @Published var txID: String = ""

    init() {
        showMyAddress()
    }

    private func showMyAddress() {
        guard let testnetAddress = UserDefaults.standard.object(forKey: "TestnetAddress") as? String else { return }
        myAddress = testnetAddress
    }

    func createAndSaveBitcoinTestnetAccount() {
        // WalletCore에서는 테스트넷 주소 생성을 지원하지 않아 외부 사이트에서 생성함
        let mnemonic = "stem hungry toilet domain volcano cheese recipe divert fit banana sand truly"
        let address = "tb1qcncxfxr8j7cz2xx0khsywflfjrw5fpvneeg3sm" // P2WPKH

        UserDefaults.standard.set(mnemonic, forKey: "mnemonic")
        UserDefaults.standard.set(address, forKey: "TestnetAddress")
        myAddress = address

        print("Mnemonic:", mnemonic)
        print("Testnet Address:", address)
    }

    // Faucet에서 받은 테스트넷 비트코인을 다시 전달하는 메서드
    func SignFaucetTransaction() {

        let wif = "cS51LEwwoKGF9Xt41k7wFyZGrGrhRU7CGnib3pqPJoqNsPbWUfEr"
        let decoded = Base58.decode(string: wif)!
        let keyData = decoded[1..<33] // 32바이트 프라이빗키
        let privateKey = PrivateKey(data: keyData)!
        let publicKey = privateKey.getPublicKeySecp256k1(compressed: true)

        // 내가 사용할 UTXO가 잠겨있는 스크립트
        let script = BitcoinScript.buildPayToWitnessPubkeyHash(hash: publicKey.bitcoinKeyHash)

        // 내가 가진 코인(UTXO) 설정
        let utxos: [BitcoinUnspentTransaction] = [
            .with {
                $0.outPoint.hash = Data.reverse(hexString: "ae7f36bbd7ee16bbcbf3eebc7986e2fe895e9beb13407b1fcf60684b6d8277d9")
                $0.outPoint.index = 1
                $0.outPoint.sequence = UINT32_MAX
                $0.amount = 4000
                $0.script = script.data
            }
        ]

        // 트랜잭션 설정
        let plan = BitcoinTransactionPlan.with {
            $0.amount = 4000 - 300
            $0.fee = 300
            $0.change = 0
            $0.utxos = utxos
        }

        let input = BitcoinSigningInput.with {
            $0.plan = plan
            $0.toAddress = "tb1qlj64u6fqutr0xue85kl55fx0gt4m4urun25p7q" // Faucet의 주소
            $0.coinType = CoinType.bitcoin.rawValue
            $0.privateKey = [privateKey.data]
            $0.hashType = BitcoinScript.hashTypeForCoin(coinType: .bitcoin)
            $0.scripts = [
                publicKey.bitcoinKeyHash.hexString: script.data
            ]
        }

        let output: BitcoinSigningOutput = AnySigner.sign(input: input, coin: .bitcoin)
        self.output = output.encoded.hexString
        print(output.encoded.hexString)
    }
}
