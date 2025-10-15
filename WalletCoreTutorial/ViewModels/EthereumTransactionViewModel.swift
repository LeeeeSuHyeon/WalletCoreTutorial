//
//  EthereumTransactionViewModel.swift
//  WalletCoreTutorial
//
//  Created by 이수현 on 10/15/25.
//

import Foundation
import WalletCore
import Combine
import SwiftProtobuf

final class EthereumTransactionViewModel: ObservableObject {
    enum EthereumTransactionAction {
        case createWallet
        case signEthereumTransaction
    }

    enum EthereumTransactionState {
        case none
        case createdWallet
    }

    private var wallet: HDWallet?

    @Published var state: EthereumTransactionState = .none
    @Published var transactionOutput: String = ""

    func createWallet() {
        // 새로운 니모닉(12단어) 생성
        wallet = HDWallet(strength: 128, passphrase: "")! // 지갑 생성
        state = .createdWallet
    }

    // 이더리움 트랜잭션 서명
    func signEthereumTransaction() {
        guard let wallet else { return }

        // 트랜잭션 구성
        let input = EthereumSigningInput.with {
            $0.chainID = Data(hexString: "01")! // 이더리움 네트워크 식별자 (1: 메인넷, 3: 테스트넷)
            $0.gasPrice = Data(hexString: "d693a400")! // 단위 가스당 지불 가격 (wei 단위)
            $0.gasLimit = Data(hexString: "5208")! // 트랜잭션에 허용된 최대 가스
            $0.toAddress = "0xC37054b3b48C3317082E7ba872d7753D13da4986" // 수신자 주소
            $0.transaction = EthereumTransaction.with {
                $0.transfer = EthereumTransaction.Transfer.with {
                    $0.amount = Data(hexString: "0348bca5a16000")! // 전송 금액
                }
            }
            $0.privateKey = wallet.getKeyForCoin(coin: .ethereum).data // 트랜잭션 서명에 사용할 개인키
        }

        let output: EthereumSigningOutput = AnySigner.sign(input: input, coin: .ethereum) // 서명 로직
        self.transactionOutput = output.encoded.hexString
    }
}
