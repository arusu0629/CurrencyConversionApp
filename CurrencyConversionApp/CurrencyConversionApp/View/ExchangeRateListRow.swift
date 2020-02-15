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
    
    init(viewModel: ExchangeRateListRowVM) {
        self.exchangeRateListRowVM = viewModel
    }
    
    var body: some View {
        HStack {
            Text(self.exchangeRateListRowVM.currency.unit)
            Spacer()
            Text("\(self.exchangeRateListRowVM.amountRate)")
        }
        .padding()
    }
}

struct ExchangeRateListRow_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRateListRow(viewModel: ExchangeRateListRowVM(currency: Currency(unit: "JPY", amountBasedOnUSD: 100)))
    }
}
