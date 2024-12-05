//
//  OnBoardButton.swift
//  Winhouse1066
//
//  Created by Александр Печинкин on 24.11.2024.
//

import SwiftUI

struct OnBoardButton: View {
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundColor(.labelPrime)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blueC)
            )
    }
}

#Preview {
    OnBoardButton(text: "Next")
}
