//
//  MainView.swift
//  Winhouse1066
//
//  Created by Александр Печинкин on 24.11.2024.
//

import SwiftUI

struct MainView: View {
    @AppStorage("isOnboardingCompleted") private var isOnboardingCompleted: Bool = false
    @State var winVM = WinVM()
    
    @State private var settingsSheet: Bool = false
    
    @State private var goodsShow: Bool = false
    @State private var addWarehouse: Bool = false
    @State private var addGood: Bool = false
    
    var body: some View {
        if isOnboardingCompleted {
            NavigationView {
                ZStack {
                    Color.bgTertiary.ignoresSafeArea()
                    
                    VStack(spacing: 24) {
                        Picker("", selection: $goodsShow) {
                            Text("Warehouse").tag(false)
                            Text("Goods").tag(true)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                        
                        if goodsShow {
                            GoodsShowView(addGood: $addGood)
                                .environmentObject(winVM)
                        } else {
                            WarehouseShowView(addWarehouse: $addWarehouse)
                                .environmentObject(winVM)
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                }
                
                .sheet(isPresented: $addWarehouse) {
                    AddEditWarehouseView()
                        .environmentObject(winVM)
                }
                
                .sheet(isPresented: $settingsSheet) {
                    if #available(iOS 16.0, *) {
                        SettingsView()
                            .presentationDetents([.fraction(0.8)])
                    } else {
                        SettingsView()
                    }
                }
                
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            if goodsShow {
                                addGood.toggle()
                            } else {
                                addWarehouse.toggle()
                            }
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 15, weight: .medium))
                                .foregroundColor(.blueC)
                                .frame(width: 30, height: 30)
                        }
                        .opacity(goodsShow ? winVM.goods.isEmpty ? 0 : 1 : winVM.warehouses.isEmpty ? 0 : 1)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            settingsSheet.toggle()
                        } label: {
                            Image(systemName: "gearshape")
                                .font(.system(size: 17))
                                .foregroundColor(.bgSecond)
                                .frame(width: 30, height: 30)
                        }
                    }
                }
                
                .preferredColorScheme(.light)
                .colorScheme(.light)
                .navigationBarTitleDisplayMode(.inline)
            }
        } else {
            OnBoardView(onBoardEnd: $isOnboardingCompleted, isReview: true)
        }
    }
}

#Preview {
    MainView()
}

struct WarehouseCalcRoundRect: View {
    var text: String
    var percentage: Double
    
    let wRoundRect = UIScreen.main.bounds.width - 142
    
    var body: some View {
        HStack(spacing: 8) {
            Text(text)
                .font(.system(size: 11))
                .foregroundColor(.bgPrime)
                .frame(width: 44)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.bgPrime)
                    .frame(width: wRoundRect, height: 16)
                
                RoundedRectangle(cornerRadius: 4)
                    .fill(Color.blueC)
                    .frame(width: wRoundRect * percentage, height: 16)
            }
            Text("\(Int(percentage * 100))%")
                .font(.system(size: 11))
                .foregroundColor(.bgPrime)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
    }
}

struct WarehouseCard: View {
    @EnvironmentObject var winVM: WinVM
    var warehouse: Warehouse
    
    @State private var delAlert: Bool = false
    @State private var editSheet: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(warehouse.category?.name ?? suitsCategory.name)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.bgPrime)
            HStack(spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "tag")
                        .font(.system(size: 12, weight: .medium))
                        .frame(width: 16, height: 16)
                    Text(warehouse.status.raw)
                        .font(.system(size: 11))
                }
                .foregroundColor(.bgPrime)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 8) {
                    Image(systemName: "shippingbox")
                        .font(.system(size: 12, weight: .medium))
                        .frame(width: 16, height: 16)
                    Text(String(warehouse.availability))
                        .font(.system(size: 11))
                }
                .foregroundColor(.bgPrime)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 8) {
                    Image(systemName: "truck.box")
                        .font(.system(size: 12, weight: .medium))
                        .frame(width: 16, height: 16)
                    Text(String(warehouse.sold))
                        .font(.system(size: 11))
                }
                .foregroundColor(.bgPrime)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 8) {
                    let revenueFormat = amountFormatterDouble.string(from: NSNumber(value: warehouse.revenue))
                    Text("$\(revenueFormat == "" ? "0" : revenueFormat ?? "0")")
                        .font(.system(size: 11))
                }
                .foregroundColor(.bgPrime)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Menu {
                Button {
                    editSheet.toggle()
                } label: {
                    Text("Edit")
                    Image(systemName: "square.and.pencil")
                }
                
                Button {
                    delAlert.toggle()
                } label: {
                    Text("Delete")
                    Image(systemName: "trash")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.bgPrime)
                    .frame(width: 16, height: 16)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.labelPrime)
        )
        .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
        .shadow(color: .black.opacity(0.04), radius: 2, y: 3)
        .padding(.horizontal, 14)
        
        .sheet(isPresented: $editSheet) {
            AddEditWarehouseView(warehouse: warehouse, isNew: false)
                .environmentObject(winVM)
        }
        
        .alert(isPresented: $delAlert) {
            Alert(title: Text("Delete product information"),
                  message: Text("Do you want to delete information Suits?"),
                  primaryButton: .default(Text("Cancel")),
                  secondaryButton: .destructive(Text("Delete"), action: {
                withAnimation {
                    winVM.removeElem(warehouse, to: &winVM.warehouses)
                    winVM.saveWarehouses()
                }
            }))
        }
    }
}

struct GoodCard: View {
    @EnvironmentObject var winVM: WinVM
    var good: Good
    
    @State private var delAlert: Bool = false
    @State private var editSheet: Bool = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            ImgPickCard(imgStringItem: .constant(good.img))
            
            VStack(alignment: .leading, spacing: 16) {
                Text(good.name)
                    .font(.system(size: 15, weight: .semibold))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                HStack(spacing: 5) {
                    Image(systemName: "tag")
                        .font(.system(size: 12, weight: .medium))
                        .frame(width: 16, height: 16)
                    Text(good.brand)
                        .font(.system(size: 11))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                
                HStack(spacing: 5) {
                    Image(systemName: "globe")
                        .font(.system(size: 12, weight: .medium))
                        .frame(width: 16, height: 16)
                    Text(good.country)
                        .font(.system(size: 11))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                
                HStack(spacing: 5) {
                    Image(systemName: "qrcode")
                        .font(.system(size: 12, weight: .medium))
                        .frame(width: 16, height: 16)
                    Text("\(good.code)")
                        .font(.system(size: 11))
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                
                HStack {
                    HStack(spacing: 5) {
                        Image(systemName: "dollarsign")
                            .font(.system(size: 12, weight: .medium))
                            .frame(width: 16, height: 16)
                        let priceFormat = amountFormatterDouble.string(from: NSNumber(value: good.price))
                        Text("\(priceFormat == "" ? "0" : priceFormat ?? "0")")
                            .font(.system(size: 11))
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                    }
                    .foregroundColor(.blueC)
                    Spacer()
                    
                    Menu {
                        Button {
                            editSheet.toggle()
                        } label: {
                            Text("Edit")
                            Image(systemName: "square.and.pencil")
                        }
                        
                        Button {
                            delAlert.toggle()
                        } label: {
                            Text("Delete")
                            Image(systemName: "trash")
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.bgPrime)
                            .frame(width: 16, height: 16)
                    }
                }
            }
            .foregroundColor(.bgPrime)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.labelPrime)
        )
        .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
        .shadow(color: .black.opacity(0.04), radius: 2, y: 3)
        .padding(.horizontal, 14)
        
        .sheet(isPresented: $editSheet) {
            AddEditGoodView(good: good, isNew: false)
                .environmentObject(winVM)
        }
        
        .alert(isPresented: $delAlert) {
            Alert(title: Text("Delete product card"),
                  message: Text("Do you want to delete a product \(good.name)?"),
                  primaryButton: .default(Text("Cancel")),
                  secondaryButton: .destructive(Text("Delete"), action: {
                withAnimation {
                    winVM.removeElem(good, to: &winVM.goods)
                    winVM.saveGoods()
                }
            }))
        }
    }
}
