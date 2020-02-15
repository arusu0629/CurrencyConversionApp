//
//  ExchangeRateListVM.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/15.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation

final class ExchangeRateListVM: ObservableObject {
    @Published private(set) var currencies = [Currency]()
    
    init() {
        fetchCurrencies()
    }
    
    private func fetchCurrencies() {
        // TODO: Live情報取得を正しく実装
        self.currencies = liveData.quotes.map { (unit, amount) in Currency(unit: unit, amountBasedOnUSD: amount) }
    }
}
