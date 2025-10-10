//
//  ContentView.swift
//  WalletCoreTutorial
//
//  Created by 이수현 on 10/4/25.
//

import SwiftUI
import WalletCore

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Wallet", systemImage: "wallet.pass") {
                WalletPracticeView()
            }
            Tab("Transaction", systemImage: "envelope.fill") {
                TransactionView()
            }
        }
    }
}

#Preview {
    ContentView()
}
