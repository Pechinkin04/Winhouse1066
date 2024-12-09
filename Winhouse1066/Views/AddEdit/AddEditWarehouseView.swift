//
//  AddEditWarehouseView.swift
//  Winhouse1066
//
//  Created by Александр Печинкин on 24.11.2024.
//

import SwiftUI

struct AddEditWarehouseView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var winVM: WinVM
    @State var warehouse: Warehouse = Warehouse()
    var isNew: Bool = true
    var isDisabled: Bool { warehouse.category == nil }
    
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
                                            warehouse.category = category
                                        }
                                    } label: {
                                        Text(category.name)
                                            .font(.system(size: 15, weight: .semibold))
                                            .foregroundColor(.labelPrime)
                                            .padding(.vertical, 12)
                                            .padding(.horizontal, 16)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(warehouse.category?.id == category.id ? Color.bgSecond : Color.label3C.opacity(0.18))
                                            )
                                    }
                                }
                                .onAppear {
                                    warehouse.category = winVM.categories.first
                                }
                            }
                            .padding(.horizontal, 24)
                        }
                        .padding(.horizontal, -24)
                        
                        Menu {
                            ForEach(WareStatus.allCases) { status in
                                Button {
                                    warehouse.status = status
                                } label: {
                                    Text(status.raw)
                                    if warehouse.status == status {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        } label: {
                            HStack(spacing: 0) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(.bgPrime)
                                    .frame(width: 24)
                                Text(warehouse.status.raw)
                                    .font(.system(size: 17))
                                    .foregroundColor(.bgPrime)
                            }
                            .frame(height: 44)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 7)
                            .padding(.trailing, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.labelPrime)
                            )
                            .shadow(color: .black.opacity(0.12), radius: 4, y: 2)
                            .shadow(color: .black.opacity(0.04), radius: 10, y: -2)
                        }
                        
                        ZStack(alignment: .bottom) {
                            HStack(spacing: 0) {
                                Text("Availability")
                                    .foregroundColor(.bgPrime)
                                    .frame(width: 100, alignment: .leading)
                                TextField("0", value: $warehouse.availability, formatter: amountFormatter)
                                    .keyboardType(.numberPad)
                            }
                            .frame(height: 44)
                            
                            Rectangle()
                                .fill(Color.blueC)
                                .frame(height: 0.33)
                        }
                        
                        ZStack(alignment: .bottom) {
                            HStack(spacing: 0) {
                                Text("Sold")
                                    .foregroundColor(.bgPrime)
                                    .frame(width: 100, alignment: .leading)
                                TextField("0", value: $warehouse.sold, formatter: amountFormatter)
                                    .keyboardType(.numberPad)
                            }
                            .frame(height: 44)
                            
                            Rectangle()
                                .fill(Color.blueC)
                                .frame(height: 0.33)
                        }
                        
                        ZStack(alignment: .bottom) {
                            HStack(spacing: 0) {
                                Text("Revenue")
                                    .foregroundColor(.bgPrime)
                                    .frame(width: 100, alignment: .leading)
                                TextField("0", value: $warehouse.revenue, formatter: amountFormatterDouble)
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
            
            .navigationTitle("Warehouse")
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
                            winVM.addElem(warehouse, to: &winVM.warehouses)
                        } else {
                            winVM.editElem(warehouse, to: &winVM.warehouses)
                        }
                        
                        winVM.saveWarehouses()
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
    AddEditWarehouseView(warehouse: mockWarehouses[0], isNew: false)
        .environmentObject(WinVM())
}
