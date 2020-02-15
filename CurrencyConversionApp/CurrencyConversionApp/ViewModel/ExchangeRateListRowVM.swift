//
//  ExchangeRateListRowVM.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/15.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation

final class ExchangeRateListRowVM: ObservableObject, Identifiable {

    @Published private(set) var currency: Currency
    
    // 基準通貨に対するこの通貨のレート
    @Published private(set) var amountRate: Double
    
    public let id: String
    
    init(currency: Currency) {
        self.currency = currency
        self.amountRate = currency.amountBasedOnUSD
        self.id = currency.id
    }
    
    // 基準となるUSDの通貨量が渡される
    func updateRate(usdAmount: Double) {
        amountRate = self.currency.amountBasedOnUSD * usdAmount
    }
}
