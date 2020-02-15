//
//  ContentView.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/14.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            // 通貨量入力画面
            CurrencyAmountInputView()
            HStack {
                Spacer()
                // 通貨単位選択画面
                CurrencyUnitSelectView()
            }
            // 他通貨のレートリスト
            ExchangeRateListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
