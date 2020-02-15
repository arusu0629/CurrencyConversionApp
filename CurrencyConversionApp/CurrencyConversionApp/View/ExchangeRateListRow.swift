//
//  ExchangeRateListRow.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/15.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import SwiftUI

struct ExchangeRateListRow: View {
    
    @ObservedObject var exchangeRateListRowVM: ExchangeRateListRowVM
    
    init(currency: Currency) {
        self.exchangeRateListRowVM = ExchangeRateListRowVM(currency: currency)
    }
    
    var body: some View {
        HStack {
            Text(self.exchangeRateListRowVM.currency.unit)
            Spacer()
            Text("\(self.exchangeRateListRowVM.currency.amountBasedOnUSD)")
        }
        .padding()
    }
}

struct ExchangeRateListRow_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRateListRow(currency: Currency(unit: "JPY", amountBasedOnUSD: 100))
    }
}
