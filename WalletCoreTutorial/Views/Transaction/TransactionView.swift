//
//  TransactionView.swift
//  WalletCoreTutorial
//
//  Created by 이수현 on 10/10/25.
//

import SwiftUI

struct TransactionView: View {
    @State private var selectedNetwork: String = "Bitcoin"
    private let networks = ["Bitcoin", "Ethereum"]

    var body: some View {
        VStack {
            Picker("Select Network", selection: $selectedNetwork) {
                ForEach(networks, id: \.self) { network in
                    Text(network)
                }
            }
            .pickerStyle(.segmented)
            .padding(.top, 8)
            .padding()


            if selectedNetwork == "Bitcoin" {
                BitcoinTransactionView()
            } else {
                EthereumTransactionView()
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    TransactionView()
}
