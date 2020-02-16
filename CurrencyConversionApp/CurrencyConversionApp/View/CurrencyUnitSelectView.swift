//
//  CurrentcyUnitSelectView.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/15.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import SwiftUI
import Combine

struct CurrencyUnitSelectView: View {
    
    @ObservedObject var currencyUnitSelectVM = CurrencyUnitSelectVM()
    @EnvironmentObject var exchangeRateListVM: ExchangeRateListVM
    
    var body: some View {
        VStack {
            Picker(selection: $currencyUnitSelectVM.selection, label: labelView()) {
                ForEach(0..<currencyUnitSelectVM.units.count, id: \.self) { index in
                    Text(self.currencyUnitSelectVM.units[index]).tag(index)
                }
            }
            .frame(maxWidth: 100, maxHeight: 100)
            .clipped()
            .labelsHidden()
            .onReceive(Just(self.currencyUnitSelectVM.selection), perform: onChangeUnit)
        }
    }
    
    private func labelView() -> some View {
        return EmptyView()
            .frame(maxWidth: 100, maxHeight: 35)
    }
    
    private func onChangeUnit(index: Int) {
        let selectedUnit = self.currencyUnitSelectVM.units[index]
        exchangeRateListVM.updateUnit(unit: selectedUnit)
    }
}

struct CurrencyUnitSelectView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyUnitSelectView()
    }
}
