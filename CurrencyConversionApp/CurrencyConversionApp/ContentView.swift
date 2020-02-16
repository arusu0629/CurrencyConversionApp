//
//  ContentView.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/14.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let exchangeRateListVM = ExchangeRateListVM()
    
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
    }
    
    var currencyAmountInputView: some View {
        return CurrencyAmountInputView().environmentObject(exchangeRateListVM)
    }
    
    var currencyUnitSelectView: some View {
        return CurrencyUnitSelectView().environmentObject(exchangeRateListVM)
    }
    
    var exchangeRateListView: some View {
        return ExchangeRateListView().environmentObject(exchangeRateListVM)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
