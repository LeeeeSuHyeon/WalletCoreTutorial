//
//  ContentView.swift
//  WalletCoreTutorial
//
//  Created by 이수현 on 10/4/25.
//

import SwiftUI
import WalletCore

struct ContentView: View {
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
                        AddressView(title: "mnemonic", content: viewModel.mnemonic)
                        AddressView(title: "Ethereum Address", content: viewModel.addressETH)
                        AddressView(title: "Bitcoin Address", content: viewModel.addressBTC)
                        AddressView(title: "BNB Address", content: viewModel.addressBNB)
                    }
                    .padding(.horizontal)
                case .showingPrivateKeys:
                    VStack(alignment: .leading, spacing: 8) {
                        AddressView(title: "BTC Private Key", content: viewModel.privateKeyBTC)
                        AddressView(title: "ETH Private Key", content: viewModel.privateKeyETH)
                        AddressView(title: "BNB Private Key", content: viewModel.privateKeyBNB)
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
    ContentView()
}
