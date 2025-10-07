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
                Text("🪙 Wallet Core Practice")
                    .font(.title2)
                    .bold()

                Button("Create New Wallet") {
                    viewModel.createWallet()
                }
                .buttonStyle(.borderedProminent)

                Divider().padding(.vertical, 10)

                VStack(alignment: .leading, spacing: 8) {
                    AddressView(title: "mnemonic", content: viewModel.mnemonic)
                    AddressView(title: "Ethereum Address", content: viewModel.addressETH)
                    AddressView(title: "Bitcoin Address", content: viewModel.addressBTC)
                    AddressView(title: "BNB Address", content: viewModel.addressBNB)
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Wallet Core")
    }
}

#Preview {
    ContentView()
}
