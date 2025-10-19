//
//  BitcoinTestnetView.swift
//  WalletCoreTutorial
//
//  Created by 이수현 on 10/19/25.
//

import SwiftUI
import Combine

struct BitcoinTestnetView: View {
    @StateObject var viewModel = BitcointTestnetViewModel()

    var body: some View {
        VStack {
            Button("Create Bitcoint Testnet Address") {
                viewModel.createAndSaveBitcoinTestnetAccount()
            }
            .buttonStyle(.glassProminent)
            .padding()

            Divider()

            if viewModel.myAddress != "" {
                VerticalContentView(title: "My Current Address", content: viewModel.myAddress)
                    .padding()
            }

            Divider()

            Button("Sign Faucet Transaction") {
                viewModel.SignFaucetTransaction()
            }
            .buttonStyle(.glassProminent)
            .padding()

            if viewModel.output != "" {
                VerticalContentView(title: "Output", content: viewModel.output)
            }

            if viewModel.txID != "" {
                VerticalContentView(title: "Transaction ID", content: viewModel.txID)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    BitcoinTestnetView()
}
