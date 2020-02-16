//
//  ContentView.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/14.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let contentVM = ContentVM()
    let exchangeRateListVM = ExchangeRateListVM()
    
    init() {
        contentVM.addGetCurrenciesCallback(callback: getCurrenciesCallback)
    }
    
    private func getCurrenciesCallback(currencies: [Currency]) {
        exchangeRateListVM.createExchangeRateListRowVMs(currencies: currencies)
    }
    
    var body: some View {
        VStack {
            // 通貨量入力画面
            currencyAmountInputView
            HStack {
                Spacer()
                // 通貨単位選択画面
                currencyUnitSelectView
            }
            // 他通貨のレートリスト
            exchangeRateListView
        }
        .onDisappear(perform: contentVM.onDisappear)
    }
    
    var currencyAmountInputView: some View {
        return CurrencyAmountInputView(exchangeRateListVM: exchangeRateListVM)
    }
    
    var currencyUnitSelectView: some View {
        return CurrencyUnitSelectView(contentVM: contentVM, exchangeRateListVM: exchangeRateListVM)
    }

    var exchangeRateListView: some View {
        return ExchangeRateListView(exchangeRateListVM: exchangeRateListVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
