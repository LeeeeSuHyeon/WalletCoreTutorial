//
//  WalletViewModel.swift
//  WalletCoreTutorial
//
//  Created by 이수현 on 10/6/25.
//

import Foundation
import WalletCore
internal import Combine

@MainActor
final class WalletViewModel: ObservableObject {
    @Published var addressBTC: String = ""
    @Published var addressETH: String = ""
    @Published var addressBNB: String = ""

    func createWallet() {

        // HDWallet 생성
        let wallet = HDWallet(mnemonic: "ripple scissors kick mammal hire column oak again sun offer wealth tomorrow wagon turn fatal", passphrase: "")!

        // 코인별 주소 생성
        let addressBTC = wallet.getAddressForCoin(coin: .bitcoin)
        let addressETH = wallet.getAddressForCoin(coin: .ethereum)
        let addressBNB = wallet.getAddressForCoin(coin: .binance)
        self.addressBTC = addressBTC
        self.addressETH = addressETH
        self.addressBNB = addressBNB

    }
}
