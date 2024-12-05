//
//  SettingsView.swift
//  Winhouse1066
//
//  Created by Александр Печинкин on 24.11.2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.openURL) var openURL
    @State private var isShareSheetShowing = false
    @State private var shareApp = "https://..."
    @State private var policy = "https://www."
    
    var body: some View {
        ZStack {
            Color.bgPrime.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.labelC2)
                        .frame(width: 30, height: 30)
                        .background(
                            Circle()
                                .fill(Color.label7F.opacity(0.5))
                        )
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .frame(height: 42, alignment: .top)
                .padding(.horizontal, 13)
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Setting")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.labelPrime)
                    
                    VStack {
                        Button {
                            SKStoreReviewController.requestReview()
                        } label: {
                            SettingsButton(imgSF: "hand.thumbsup", text: "Rate our app", help: "Rate")
                        }
                        
                        Button {
                            isShareSheetShowing.toggle()
                        } label: {
                            SettingsButton(imgSF: "paperclip", text: "Share our app", help: "Share")
                        }
                        .sheet(isPresented: $isShareSheetShowing, onDismiss: {
                            print("Share sheet dismissed")
                        }) {
                            ShareSheet(activityItems: [shareApp])
                        }
                        
                        Button {
                            if let url = URL(string: policy) {
                                openURL(url)
                            }
                        } label: {
                            SettingsButton(imgSF: "list.dash.header.rectangle", text: "Usage Policy", help: "Read")
                        }
                    }
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding(.horizontal, 16)
            .padding(.top, 20)
        }
    }
}

#Preview {
    SettingsView()
}

struct SettingsButton: View {
    var imgSF: String
    var text: String
    var help: String
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(spacing: 6) {
                Image(systemName: imgSF)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.labelPrime)
                    .frame(height: 32)
                Text(text)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.labelPrime)
                    .frame(height: 14)
            }
            
            Text(help)
                .font(.system(size: 15))
                .foregroundColor(.labelPrime)
                .padding(.vertical, 4)
                .padding(.horizontal, 10)
                .background(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color.blueC)
                )
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.bgSecond)
        )
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

