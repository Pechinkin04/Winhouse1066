//
//  WarehouseShowView.swift
//  Winhouse1066
//
//  Created by Александр Печинкин on 25.11.2024.
//

import SwiftUI

struct WarehouseShowView: View {
    @EnvironmentObject var winVM: WinVM
    @Binding var addWarehouse: Bool
    
    var body: some View {
        VStack(spacing: 8) {
            wareHouseCalcStats
            
            if winVM.warehouses.isEmpty {
                Spacer()
                VStack(spacing: 10) {
                    VStack(spacing: 8) {
                        Text("Empty")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.black)
                        Text("Add product information")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(Color.label3C.opacity(0.6))
                    }
                    Button {
                        addWarehouse.toggle()
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
                Spacer()
            } else {
                ForEach(winVM.warehouses) { warehouse in
                    WarehouseCard(warehouse: warehouse)
                        .environmentObject(winVM)
                }
            }
        }
    }
    
    var wareHouseCalcStats: some View {
        VStack(spacing: 16) {
            HStack {
                HStack(spacing: 8) {
                    Image(systemName: "shippingbox")
                        .font(.system(size: 12, weight: .medium))
                    Text("\(winVM.availabilityTotal)")
                        .font(.system(size: 11))
                }
                .foregroundColor(.bgPrime)
                .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack(spacing: 8) {
                    Image(systemName: "truck.box")
                        .font(.system(size: 12, weight: .medium))
                    Text("\(winVM.soldTotal)")
                        .font(.system(size: 11))
                }
                .foregroundColor(.bgPrime)
                .frame(maxWidth: .infinity, alignment: .center)
                
                HStack(spacing: 8) {
//                    Text("$\(String(format: "%.2f", winVM.revenueTotal))")
                    Text("$\(amountFormatterDouble.string(from: NSNumber(value: winVM.revenueTotal)) ?? "0")")
//                    Text("$\(winVM.revenueTotal, formatter: amountFormatterDouble)")
                        .font(.system(size: 11))
                }
                .foregroundColor(.bgPrime)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            VStack(spacing: 16) {
                WarehouseCalcRoundRect(text: "In stock", percentage: winVM.stockPart)
                WarehouseCalcRoundRect(text: "For sale", percentage: winVM.forSalePart)
                WarehouseCalcRoundRect(text: "Delivery", percentage: winVM.deliveryPart)
                WarehouseCalcRoundRect(text: "Sold out", percentage: winVM.soldOutPart)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.labelPrime)
        )
        .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
        .shadow(color: .black.opacity(0.04), radius: 2, y: 3)
        .padding(.horizontal, 14)
    }
}

#Preview {
    WarehouseShowView(addWarehouse: .constant(false))
        .environmentObject(WinVM())
}
