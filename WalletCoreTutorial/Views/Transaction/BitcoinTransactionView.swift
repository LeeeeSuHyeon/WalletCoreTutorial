//
//  BitcoinTransactionView.swift
//  WalletCoreTutorial
//
//  Created by 이수현 on 10/10/25.
//

import SwiftUI

struct BitcoinTransactionView: View {
    @StateObject var viewModel = BitcoinTransactionViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button("execute SignExtendedPubkeyUTXO") {
                viewModel.signExtendedPubkeyUTXO()
            }
            .buttonStyle(.borderedProminent)
            VerticalContentView(title: "Output", content: viewModel.pubkeyUTXOOutput)

        }
        .padding(.horizontal)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    BitcoinTransactionView()
}
