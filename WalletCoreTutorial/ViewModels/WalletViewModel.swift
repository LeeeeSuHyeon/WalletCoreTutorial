//
//  WalletViewModel.swift
//  WalletCoreTutorial
//
//  Created by 이수현 on 10/6/25.
//

import Foundation
import WalletCore
import Combine

@MainActor
final class WalletViewModel: ObservableObject {
    @Published var mnemonic: String = ""
    @Published var addressBTC: String = ""
    @Published var addressETH: String = ""
    @Published var addressBNB: String = ""

    func createWallet() {
        // 새로운 니모닉(12단어) 생성
        let wallet = HDWallet(strength: 128, passphrase: "")!

        // 니모닉 단어 확인
        self.mnemonic = wallet.mnemonic

        // HDWallet 생성
//        let wallet = HDWallet(mnemonic: "ripple scissors kick mammal hire column oak again sun offer wealth tomorrow wagon turn fatal", passphrase: "")!

        // 코인별 주소 생성
        let addressBTC = wallet.getAddressForCoin(coin: .bitcoin)
        let addressETH = wallet.getAddressForCoin(coin: .ethereum)
        let addressBNB = wallet.getAddressForCoin(coin: .binance)
        self.addressBTC = addressBTC
        self.addressETH = addressETH
        self.addressBNB = addressBNB

    }
}
