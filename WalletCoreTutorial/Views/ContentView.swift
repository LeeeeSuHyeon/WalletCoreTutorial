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
                    Text("Ethereum Address")
                        .font(.headline)
                    Text(viewModel.addressETH)
                        .font(.footnote)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)

                    Text("Bitcoin Address")
                        .font(.headline)
                    Text(viewModel.addressBTC)
                        .font(.footnote)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    Text("BNB Address")
                        .font(.headline)
                    Text(viewModel.addressBNB)
                        .font(.footnote)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
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
