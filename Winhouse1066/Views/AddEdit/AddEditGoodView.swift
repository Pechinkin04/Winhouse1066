//
//  AddEditGoodView.swift
//  Winhouse1066
//
//  Created by Александр Печинкин on 25.11.2024.
//

import SwiftUI

struct AddEditGoodView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var winVM: WinVM
    @State var good: Good = Good()
    var isNew: Bool = true
    var isDisabled: Bool { good.category == nil }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.bgTertiary.ignoresSafeArea()
                    .onTapGesture {
                        hideKeyboard()
                    }
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(winVM.categories) { category in
                                    Button {
                                        withAnimation {
                                            good.category = category
                                        }
                                    } label: {
                                        Text(category.name)
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.labelPrime)
                                            .padding(.vertical, 12)
                                            .padding(.horizontal, 16)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(good.category?.id == category.id ? Color.bgSecond : Color.label3C.opacity(0.18))
                                            )
                                    }
                                }
                                .onAppear {
                                    good.category = winVM.categories.first
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                        .padding(.horizontal, -24)
                        
                        ImgPickCardEdit(imgStringItem: $good.img)
                        
                        ZStack(alignment: .bottom) {
                            HStack(spacing: 0) {
                                Text("Name")
                                    .foregroundColor(.bgPrime)
                                    .frame(width: 100, alignment: .leading)
                                TextField("Enter", text: $good.name)
                            }
                            .frame(height: 44)
                            
                            Rectangle()
                                .fill(Color.blueC)
                                .frame(height: 0.33)
                        }
                        
                        ZStack(alignment: .bottom) {
                            HStack(spacing: 0) {
                                Text("Brand")
                                    .foregroundColor(.bgPrime)
                                    .frame(width: 100, alignment: .leading)
                                TextField("Enter", text: $good.brand)
                            }
                            .frame(height: 44)
                            
                            Rectangle()
                                .fill(Color.blueC)
                                .frame(height: 0.33)
                        }
                        
                        ZStack(alignment: .bottom) {
                            HStack(spacing: 0) {
                                Text("Country")
                                    .foregroundColor(.bgPrime)
                                    .frame(width: 100, alignment: .leading)
                                TextField("Enter", text: $good.country)
                            }
                            .frame(height: 44)
                            
                            Rectangle()
                                .fill(Color.blueC)
                                .frame(height: 0.33)
                        }
                        
                        ZStack(alignment: .bottom) {
                            HStack(spacing: 0) {
                                Text("Code")
                                    .foregroundColor(.bgPrime)
                                    .frame(width: 100, alignment: .leading)
                                TextField("00000", value: $good.code, formatter: amountFormatter)
                                    .keyboardType(.numberPad)
                            }
                            .frame(height: 44)
                            
                            Rectangle()
                                .fill(Color.blueC)
                                .frame(height: 0.33)
                        }
                        
                        ZStack(alignment: .bottom) {
                            HStack(spacing: 0) {
                                Text("Code")
                                    .foregroundColor(.bgPrime)
                                    .frame(width: 100, alignment: .leading)
                                TextField("00000", value: $good.price, formatter: amountFormatterDouble)
                                    .keyboardType(.numbersAndPunctuation)
                            }
                            .frame(height: 44)
                            
                            Rectangle()
                                .fill(Color.blueC)
                                .frame(height: 0.33)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 18)
                    .background(
                        Color.labelPrime
                            .onTapGesture {
                                hideKeyboard()
                            }
                    )
                }
            }
            
            .navigationTitle("Goods")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.light)
            .colorScheme(.light)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.system(size: 17))
                            .padding(2)
                            .foregroundColor(.bgPrime)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        if isNew {
                            winVM.addElem(good, to: &winVM.goods)
                        } else {
                            winVM.editElem(good, to: &winVM.goods)
                        }
                        
                        winVM.saveGoods()
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                            .font(.system(size: 17))
                            .padding(2)
                            .foregroundColor(.blueC)
                    }
                    .disabled(isDisabled)
                    .opacity(isDisabled ? 0.3 : 1)
                }
            }
        }
    }
}

#Preview {
    AddEditGoodView(good: mockGoods[0], isNew: false)
        .environmentObject(WinVM())
}
