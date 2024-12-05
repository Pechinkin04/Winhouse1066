//
//  GoodsShowView.swift
//  Winhouse1066
//
//  Created by Александр Печинкин on 25.11.2024.
//

import SwiftUI

struct GoodsShowView: View {
    @EnvironmentObject var winVM: WinVM
    
    @Binding var addGood: Bool
    
    @State private var categPickFilter: Category?
    var goodFilter: [Good] {
        guard let categPickFilter else { return winVM.goods }
        return winVM.goods.filter { $0.category?.id == categPickFilter.id }
    }
    
    @State private var addCategoryAlert: Bool = false
    @State private var textFCategory: String = ""
    @State private var delCategoryAlert: Category?
    
    var body: some View {
        VStack(spacing: 0) {
            if winVM.goods.isEmpty {
                Spacer()
                VStack(spacing: 10) {
                    VStack(spacing: 8) {
                        Text("Empty")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                        Text("Create a product card")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color.label3C.opacity(0.6))
                    }
                    Button {
                        addGood.toggle()
                    } label: {
                        Text("Add")
                            .font(.system(size: 15))
                            .foregroundColor(.labelPrime)
                            .padding(.vertical, 4)
                            .padding(.horizontal, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 40)
                                    .fill(Color.blueC)
                            )
                    }
                }
                Spacer()
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(goodFilter) { good in
                            GoodCard(good: good)
                                .environmentObject(winVM)
                        }
                    }
                    .padding(.bottom, 50)
                    .padding(.top, 24)
                }
                .padding(.top, -24)
            }
            
            HStack(spacing: 12) {
                    if #available(iOS 15.0, *) {
                        Button {
                            addCategoryAlert.toggle()
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 15))
                                .foregroundColor(.labelPrime)
                                .frame(width: 40, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.bgSecond)
                                )
                        }

                        .alert("Adding a category", isPresented: $addCategoryAlert, actions: {
                            TextField("Enter", text: $textFCategory)
                            Button("Cancel") {}
                            Button("Save", role: .cancel, action: {
                                withAnimation {
                                    winVM.addElem(Category(name: textFCategory), to: &winVM.categories)
                                }
                                textFCategory = ""
                                winVM.saveCategories()
                            })
                        }, message: {
                            Text("Enter the name of the product group")
                        })
                    }
                    
                HStack(spacing: 0) {
                    Button {
                        categPickFilter = nil
                    } label: {
                        Text("All")
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.labelPrime)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(categPickFilter == nil ? Color.blueC : Color.label3C.opacity(0.18))
                            )
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(winVM.categories) { category in
                                HStack(spacing: 8) {
                                    Text(category.name)
                                        .font(.system(size: 15, weight: .semibold))
                                    //                                                        Image(systemName: "trash")
                                    //                                                            .font(.system(size: 12))
                                }
                                .foregroundColor(.labelPrime)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(categPickFilter?.id == category.id ? Color.blueC : Color.label3C.opacity(0.18))
                                )
                                .onTapGesture {
                                    withAnimation {
                                        categPickFilter = category
                                    }
                                }
                                .onLongPressGesture {
                                    delCategoryAlert = category
                                }
                            }
                        }
                        .padding(.leading, 8)
                        .padding(.trailing, 16)
                    }
                    .padding(.trailing, -16)
                }
                .alert(item: $delCategoryAlert) { category in
                    Alert(title: Text("Delete a category"),
                          message: Text("Do you want to delete a category Suits?"),
                          primaryButton: .default(Text("Cancel")),
                          secondaryButton: .destructive(Text("Delete"), action: {
                        withAnimation {
                            winVM.removeElem(category, to: &winVM.categories)
                            winVM.saveCategories()
                        }
                    }))
                }
            }
            .frame(height: 68)
            .padding(.horizontal, 16)
            .background(Color.labelPrime.ignoresSafeArea())
            .shadow(color: Color.black.opacity(0.04), radius: 2, y: -4)
        }
        
        .sheet(isPresented: $addGood) {
            AddEditGoodView()
                .environmentObject(winVM)
        }
    }
}

#Preview {
    GoodsShowView(addGood: .constant(false))
}
