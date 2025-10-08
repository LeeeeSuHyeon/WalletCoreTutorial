//
//  WalletViewModel.swift
//  WalletCoreTutorial
//
//  Created by 이수현 on 10/6/25.
//

import Foundation
import WalletCore
import Combine
import SwiftProtobuf // SwiftProtobuf.Message 접근 시 사용

@MainActor
final class WalletViewModel: ObservableObject {
    enum WalletAction {
        case createWallet
        case showPrivateKeys
        case signEthereumTransaction
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
        case .signEthereumTransaction:
            signEthereumTransaction()
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

    // 이더리움 트랜잭션 서명
    private func signEthereumTransaction() {
        guard let wallet else { return }

        // 트랜잭션 구성
        let input = EthereumSigningInput.with {
            $0.chainID = Data(hexString: "01")! // 이더리움 네트워크 식별자 (1: 메인넷, 3: 테스트넷)
            $0.gasPrice = Data(hexString: "d693a400")! // 단위 가스당 지불 가격 (wei 단위)
            $0.gasLimit = Data(hexString: "5208")! // 트랜잭션에 허용된 최대 가스
            $0.toAddress = "0xC37054b3b48C3317082E7ba872d7753D13da4986" // 송신자 주소
            $0.transaction = EthereumTransaction.with {
                $0.transfer = EthereumTransaction.Transfer.with {
                    $0.amount = Data(hexString: "0348bca5a16000")! // 전송 금액
                }
            }
            $0.privateKey = wallet.getKeyForCoin(coin: .ethereum).data // 트랜잭션 서명에 사용할 개인키
        }

        let output: EthereumSigningOutput = AnySigner.sign(input: input, coin: .ethereum) // 서명 로직
        print("SignIn Data: \(output.encoded.hexString)")
    }
}
