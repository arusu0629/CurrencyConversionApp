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
    @ObservedObject var contentVM: ContentVM
    @ObservedObject var exchangeRateListVM: ExchangeRateListVM
    
    init(contentVM: ContentVM, exchangeRateListVM: ExchangeRateListVM) {
        self.contentVM = contentVM
        self.exchangeRateListVM = exchangeRateListVM
        
        contentVM.addGetCurrenciesCallback(callback: getCurrenciesCallback)
    }
    
    private func getCurrenciesCallback(currencies: [Currency]) {
        currencyUnitSelectVM.convertCurrenciesToUnits(currencies: currencies)
        currencyUnitSelectVM.setUSDSelectionIndex()
    }
    
    var body: some View {
        VStack {
            if (self.currencyUnitSelectVM.isExistUnits) {
                Picker(selection: $currencyUnitSelectVM.selection, label: labelView()) {
                    ForEach(0..<self.currencyUnitSelectVM.units.count, id: \.self) { index in
                        Text(self.currencyUnitSelectVM.units[index]).tag(index)
                    }
                }
                .frame(maxWidth: 100, maxHeight: 100)
                .clipped()
                .labelsHidden()
                .onReceive(Just(self.currencyUnitSelectVM.selection), perform: onChangeUnit)
            }
        }
    }
    
    private func labelView() -> some View {
        return EmptyView()
            .frame(maxWidth: 100, maxHeight: 35)
    }
    
    private func onChangeUnit(index: Int) {
        if (self.currencyUnitSelectVM.units.count <= index) {
            return
        }
        let selectedUnit = self.currencyUnitSelectVM.units[index]
        exchangeRateListVM.updateUnit(unit: selectedUnit)
    }
}

struct CurrencyUnitSelectView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyUnitSelectView(contentVM: ContentVM(), exchangeRateListVM: ExchangeRateListVM())
    }
}
