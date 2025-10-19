//
//  WalletPracticeView.swift
//  WalletCoreTutorial
//
//  Created by 이수현 on 10/10/25.
//

import SwiftUI

struct WalletPracticeView: View {
    @StateObject private var viewModel = WalletViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Wallet Core Practice")
                    .font(.title2)
                    .bold()
                HStack {
                    Button("Create New Wallet") {
                        viewModel.perform(.createWallet)
                    }
                    .buttonStyle(.borderedProminent)

                    Button("Show Private Keys") {
                        viewModel.perform(.showPrivateKeys)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.orange)
                }

                Divider().padding(.vertical, 10)

                switch viewModel.state {
                case .none:
                    EmptyView()
                case .created:
                    VStack(alignment: .leading, spacing: 8) {
                        VerticalContentView(title: "mnemonic", content: viewModel.mnemonic)
                        VerticalContentView(title: "Ethereum Address", content: viewModel.addressETH)
                        VerticalContentView(title: "Bitcoin Address", content: viewModel.addressBTC)
                        VerticalContentView(title: "BNB Address", content: viewModel.addressBNB)
                    }
                    .padding(.horizontal)
                case .showingPrivateKeys:
                    VStack(alignment: .leading, spacing: 8) {
                        VerticalContentView(title: "BTC Private Key", content: viewModel.privateKeyBTC)
                        VerticalContentView(title: "ETH Private Key", content: viewModel.privateKeyETH)
                        VerticalContentView(title: "BNB Private Key", content: viewModel.privateKeyBNB)
                    }
                }
                Spacer()
            }
        }
        .padding()
        .navigationTitle("Wallet Core")
    }
}

#Preview {
    WalletPracticeView()
}
