//
//  OnBoardView.swift
//  Winhouse1066
//
//  Created by Александр Печинкин on 24.11.2024.
//

import SwiftUI
import StoreKit

struct OnBoardView: View {
    @State private var currentPage = 0
    @Binding var onBoardEnd: Bool
    var isReview: Bool
    let pushNotificationManager = PushNotificationManager()
    
    var body: some View {
        ZStack {
            if isReview {
                LinearGradient(colors: [Color.gradTop, Color.gradBot], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            } else {
                Image("onBoardBGUser")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                if !isReview {
                    OnBoardText(currentPage: currentPage, isReview: isReview)
                        .padding(.horizontal, 15)
                        .padding(.top, 16)
                }
                OnBoardCards(currentPage: currentPage, isReview: isReview)
                    .frame(maxHeight: .infinity, alignment: isReview ? .top : .bottom)
            }
            
            if isReview {
                VStack(spacing: 24) {
                    OnBoardTextReview(currentPage: currentPage, isReview: isReview)
                    HStack(spacing: 24) {
                        HStack(spacing: 8) {
                            ForEach(0..<2) { index in
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 40, height: 5)
                                    .foregroundColor(currentPage == index ? .blueC : .labelPrime)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        Button {
                            withAnimation {
                                if currentPage < 1 {
                                    currentPage += 1
                                } else {
                                    onBoardEnd = true
                                }
                            }
                        } label: {
                            OnBoardButton(text: "Next")
                        }
                    }
                }
                .padding([.horizontal, .top], 24)
                .padding(.bottom, 20)
                .background(
                    Rectangle()
                        .fill(Color.bgPrime)
                        .embedInCornRadius(cornradius: 20, botTrail: false, botLead: false)
                        .ignoresSafeArea()
                )
                .frame(maxHeight: .infinity, alignment: .bottom)
            } else {
                VStack {
                    Spacer()
                    VStack(spacing: 24) {
                        Button {
                            withAnimation {
                                if currentPage < 2 {
                                    currentPage += 1
                                } else if currentPage == 1 {
                                    SKStoreReviewController.requestReview()
                                    currentPage += 1
                                } else {
                                    Task { let _ = try? await pushNotificationManager.registerForNotifications() }
                                    onBoardEnd = true
                                }
                            }
                        } label: {
                            OnBoardButton(text: "Next")
                        }
                        HStack(spacing: 8) {
                            ForEach(0..<3) { index in
                                Circle()
                                    .frame(width: 10)
                                    .foregroundColor(currentPage == index ? .blueC : .labelPrime)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding([.horizontal, .top], 24)
                    .padding(.bottom, 20)
                    .background(
                        Rectangle()
                            .fill(Color.bgPrime)
                            .embedInCornRadius(cornradius: 20, botTrail: false, botLead: false)
                            .ignoresSafeArea()
                    )
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

#Preview {
    OnBoardView(onBoardEnd: .constant(false), isReview: true)
}

struct OnBoardTextReview: View {
    var currentPage: Int
    var isReview: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            Text("All your products from the store are now in one place")
                .modifier(Title1TextModifierReview())
                .frame(maxWidth: .infinity)
                .offset(x: CGFloat((0 - currentPage )) * UIScreen.main.bounds.width)
            
            Text("Statistics on revenue, sales and status of goods in the warehouse")
                .modifier(Title1TextModifierReview())
                .frame(maxWidth: .infinity)
                .offset(x: CGFloat((1 - currentPage )) * UIScreen.main.bounds.width)
        }
        .multilineTextAlignment(.center)
        .lineLimit(2)
    }
}

struct Title1TextModifierReview: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 22, weight: .bold))
//            .textCase(.uppercase)
            .foregroundColor(.labelPrime)
            .minimumScaleFactor(0.7)
            .multilineTextAlignment(.center)
    }
}

struct OnBoardText: View {
    var currentPage: Int
    var isReview: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            Text("Your guide to the world of betting statistics")
                .modifier(Title1TextModifier())
                .frame(maxWidth: .infinity)
                .offset(x: CGFloat((0 - currentPage )) * UIScreen.main.bounds.width)
            
            Text("Rate our app in the AppStore")
                .modifier(Title1TextModifier())
                .frame(maxWidth: .infinity)
                .offset(x: CGFloat((1 - currentPage )) * UIScreen.main.bounds.width)
            
            Text("Don’t miss anything events")
                .modifier(Title1TextModifier())
                .frame(maxWidth: .infinity)
                .offset(x: CGFloat((2 - currentPage )) * UIScreen.main.bounds.width)
        }
        .multilineTextAlignment(.center)
        .lineLimit(2)
    }
}

struct Title1TextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 34, weight: .bold))
//            .textCase(.uppercase)
            .foregroundColor(.labelPrime)
            .minimumScaleFactor(0.7)
            .multilineTextAlignment(.center)
    }
}


struct OnBoardCards: View {
    var currentPage: Int
    var isReview: Bool
    
    var body: some View {
        ZStack(alignment: isReview ? .top : .bottom) {
            if isReview {
                OnBoardIMG(img: "onBoard1")
                    .offset(x: CGFloat((0 - currentPage )) * UIScreen.main.bounds.width)
                OnBoardIMG(img: "onBoard2")
                    .offset(x: CGFloat((1 - currentPage )) * UIScreen.main.bounds.width)
            } else {
                OnBoardIMG(img: "onBoard1User")
                    .offset(x: CGFloat((0 - currentPage )) * UIScreen.main.bounds.width)
                OnBoardIMG(img: "onBoard2User")
                    .offset(x: CGFloat((1 - currentPage )) * UIScreen.main.bounds.width)
                OnBoardIMG(img: "onBoard3User")
                    .offset(x: CGFloat((2 - currentPage )) * UIScreen.main.bounds.width)
            }
        }
        .frame(maxWidth: .infinity, alignment: isReview ? .top : .bottom)
        .edgesIgnoringSafeArea(.bottom)
        //        .edgesIgnoringSafeArea(isReview ? .bottom : .top)
        //        .background(Color.bgMain.edgesIgnoringSafeArea(.horizontal))
    }
}

struct OnBoardIMG: View {
    var img: String
    
    var body: some View {
        Image(img)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .minimumScaleFactor(0.6)
//            .frame(width: UIScreen.main.bounds.width,
//                   height: UIScreen.main.bounds.width * 2)
//            .clipped()
//            .frame(height: UIScreen.main.bounds.height / 2)
    }
}
