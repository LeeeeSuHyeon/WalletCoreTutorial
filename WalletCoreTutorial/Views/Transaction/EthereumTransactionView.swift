//
//  EthereumTransactionView.swift
//  WalletCoreTutorial
//
//  Created by 이수현 on 10/15/25.
//

import SwiftUI

struct EthereumTransactionView: View {
    @StateObject var viewModel = EthereumTransactionViewModel()

    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            if viewModel.state == .createdWallet {
                Button("Sign Ethereum Transaction") {
                    viewModel.signEthereumTransaction()
                }
                .buttonStyle(.borderedProminent)

                Divider()

                VerticalContentView(title: "Output", content: viewModel.transactionOutput)
            } else {
                Button("Create Wallet") {
                    viewModel.createWallet()
                }
                .buttonStyle(.borderedProminent)

                Text("이더리움 트랜잭션 생성 전, 지갑을 먼저 생성해주세요.")
            }
        }
        .padding(.horizontal)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    EthereumTransactionView()
}
