//
//  BitcoinTransactionViewModel.swift
//  WalletCoreTutorial
//
//  Created by 이수현 on 10/10/25.
//

import Foundation
import WalletCore
import Combine
import SwiftProtobuf

final class BitcoinTransactionViewModel: ObservableObject {
    @Published var pubkeyUTXOOutput: String = ""

    // UTXO(미사용 출력)를 직접 지정해서 Input + Output 구성
    func signExtendedPubkeyUTXO() {
        let wif = "L4BeKzm3AHDUMkxLRVKTSVxkp6Hz9FcMQPh18YCKU1uioXfovzwP" // Base58로 인코딩한 비트코인 비밀키
        let decoded = Base58.decode(string: wif)! // 인코딩된 비밀키를 디코딩
        let key = PrivateKey(data: decoded[1..<33])! // 개인키는 32바이트, 0번째 인덱스는 네트워크 구분자,마지막은 체크섬

        // 압축 여부에 따라 주소 결과도 달라짐 -> 사용하는 UTXO의 주소의 형식(압축/비압축)과 일치시켜야 함
        let pubkey = key.getPublicKeySecp256k1(compressed: false) // 공개키 생성(비압축: 65바이트, 압축 33바이트)

        let address = BitcoinAddress(data: [0x0] + Hash.sha256RIPEMD(data: pubkey.data))! // 주소 생성: 공개키를 해시한 결과
        let script = BitcoinScript.lockScriptForAddress(address: address.description, coin: .bitcoin) // 해당 주소로 비트코인을 잠그는 스크립트 생성 -> 사용하려면 해당 공개키와 유효한 서명 필요

        // 내가 가진 코인(UTXO) 설정
        let utxos: [BitcoinUnspentTransaction] = [
            .with {
                // 이 UTXO가 속한 과거 트랜잭션의 txid
                // 비트코인 raw 트랜잭션 포맷은 리틀엔디언으로 txid를 넣기 때문에 reverse 필수
                $0.outPoint.hash = Data.reverse(hexString: "6ae3f1d245521b0ea7627231d27d613d58c237d6bf97a1471341a3532e31906c")

                // 하나의 트랜잭션에는 여러 개의 Output이 존재할 수 있음 -> 그 중 몇 번째를 쓸거냐
                $0.outPoint.index = 0

                // 트랜잭션이 언제 유효해지는지 제어하는 프로퍼티(locktime 활성화, 수수료 재조정 가능)
                // 기본값: UINT32_MAX -> 즉시 유효 (locktime 없이 사용)
                $0.outPoint.sequence = UINT32_MAX

                // 이 UTXO 출력의 정확한 금액(사토시 단위)
                $0.amount = 16874

                // 이 UTXO가 어떤 조건으로 잠겨 있는지(주소 타입에 대응) 나타내는 locking script
                $0.script = script.data
            },
            .with {
                $0.outPoint.hash = Data.reverse(hexString: "fd1ea8178228e825d4106df0acb61a4fb14a8f04f30cd7c1f39c665c9427bf13")
                $0.outPoint.index = 0
                $0.outPoint.sequence = UINT32_MAX
                $0.amount = 10098
                $0.script = script.data
            }
        ]

        let input = BitcoinSigningInput.with {
            $0.utxo = utxos // 소비할 UTXO
            $0.privateKey = [key.data] // 각 입력에 대한 서명을 만들 개인키
            $0.hashType = BitcoinScript.hashTypeForCoin(coinType: .binance) // 서명 규칙
            $0.useMaxAmount = true // 전체 금액을 다 사용하겠다는 의미 -> change 없음
            $0.byteFee = 10 // 1 바이트 당 수수료 10 사토시
            $0.toAddress = "1FeyttPotRsSd4equWr678dbEvXaNSqmDT" // 받는 사람 주소
            $0.coinType = CoinType.bitcoin.rawValue // 코인 타입
            $0.amount = utxos.map { $0.amount }.reduce(0, +) // 전송 금액(모든 UTXO 합계)
        }

        let ouput: BitcoinSigningOutput = AnySigner.sign(input: input, coin: .bitcoin) // 서명 및 트랜잭션 생성
        pubkeyUTXOOutput = ouput.encoded.hexString
    }
}
