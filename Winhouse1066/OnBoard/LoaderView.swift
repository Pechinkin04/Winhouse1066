//
//  LoaderView.swift
//  Winhouse1066
//
//  Created by Александр Печинкин on 24.11.2024.
//

import SwiftUI

struct LoaderView: View {
    var isReview: Bool = true
    var body: some View {
        ZStack {
            Image(isReview ? "loader" : "loader")
                .resizable()
                .ignoresSafeArea()
                .aspectRatio(contentMode: .fill)
                .frame(height: 100)
            
            VStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(.circular)
                    .scaleEffect(2) // Масштабируем спиннер
                    .padding() // Добавляем немного отступа
                    .colorInvert()
//                    .colorMultiply(.white)
                    .colorMultiply(.bgPrime)
//                    .offset(y: 200)
            }
            .padding(.bottom, 130)
        }
    }
}

#Preview {
    LoaderView()
}
