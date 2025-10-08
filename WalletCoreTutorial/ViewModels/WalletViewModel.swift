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
    enum WalletAction {
        case createWallet
        case showPrivateKeys
    }

    enum WalletState {
        case none
        case created
        case showingPrivateKeys
    }

    @Published var state: WalletState = .none

    private var wallet: HDWallet?

    @Published var mnemonic: String = ""
    @Published var addressBTC: String = ""
    @Published var addressETH: String = ""
    @Published var addressBNB: String = ""

    @Published var privateKeyBTC: String = ""
    @Published var privateKeyETH: String = ""
    @Published var privateKeyBNB: String = ""

    func perform(_ action: WalletAction) {
        switch action {
        case .createWallet:
            createWallet()
            state = .created
        case .showPrivateKeys:
            showPrivateKeys()
            state = .showingPrivateKeys
        }
    }

    private func createWallet() {
        /*
         HDWallet: Hierarchical Deterministic Wallet
            - 하나의 “마스터 키(seed)“로부터 여러 개의
            - 프라이빗 키 / 주소를 체계적으로 파생(Derive)

         strength: 니모닉(Mnemonic) 단어 개수를 결정하는 엔트로피 비트 수 (128비트 -> 12단어)
         passphrase: BIP-39 표준에 포함된 보안 확장 문구(Optional)
            - 니모닉 이후의 추가 보안 문구
            - 탈취자가 니모닉을 알아도, passphrase 없으면 접근 불가
         */


        // 새로운 니모닉(12단어) 생성
        wallet = HDWallet(strength: 128, passphrase: "")! // 지갑 생성
        guard let wallet else { return }
//        let wallet = HDWallet(mnemonic: "ripple scissors kick mammal hire column oak again sun offer wealth tomorrow wagon turn fatal", passphrase: "")! // 지갑 복구

        // 니모닉 단어 확인
        self.mnemonic = wallet.mnemonic

        // 코인별 주소 생성
        let addressBTC = wallet.getAddressForCoin(coin: .bitcoin)
        let addressETH = wallet.getAddressForCoin(coin: .ethereum)
        let addressBNB = wallet.getAddressForCoin(coin: .binance)
        self.addressBTC = addressBTC
        self.addressETH = addressETH
        self.addressBNB = addressBNB
    }

    // 코인별 비밀키 출력
    private func showPrivateKeys() {
        guard let wallet else { return }
        
        // 코인별 프라이빗 키 추출 (파생 경로에서 개인키 추출)
        let btcKey = wallet.getKeyForCoin(coin: .bitcoin)
        let ethKey = wallet.getKeyForCoin(coin: .ethereum)
        let bnbKey = wallet.getKeyForCoin(coin: .binance)

        // Hex 출력
        self.privateKeyBTC = btcKey.data.hexString
        self.privateKeyETH = ethKey.data.hexString
        self.privateKeyBNB = bnbKey.data.hexString
    }
}
