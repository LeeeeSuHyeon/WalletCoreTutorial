//
//  VerticalContentView.swift
//  WalletCoreTutorial
//
//  Created by 이수현 on 10/7/25.
//

import SwiftUI

struct VerticalContentView: View {
    private let title: String
    private let content: String

    init(title: String, content: String) {
        self.title = title
        self.content = content
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("\(title)")
                .font(.headline)
            Text("\(content)")
                .font(.footnote)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
        }
    }
}
