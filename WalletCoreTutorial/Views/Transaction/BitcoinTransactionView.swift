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
            HStack {
                Button("SignExtendedPubkeyUTXO") {
                    viewModel.signExtendedPubkeyUTXO()
                }
                .buttonStyle(.borderedProminent)

                Button("SignP2SH_P2WPKH") {
                    viewModel.signP2SH_P2WPKH	()
                }
                .buttonStyle(.borderedProminent)
                .tint(.orange)
            }

            Divider()

            VerticalContentView(title: "ExtendedPubkey - Output", content: viewModel.pubkeyUTXOOutput)
            VerticalContentView(title: "P2SH_P2WPKH - Output", content: viewModel.P2SH_P2WPKHOutput)

        }
        .padding(.horizontal)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    BitcoinTransactionView()
}
