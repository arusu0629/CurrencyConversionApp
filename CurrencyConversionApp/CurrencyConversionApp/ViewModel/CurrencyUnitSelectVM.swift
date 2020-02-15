//
//  CurrencyUnitSelectVM.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/15.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation

final class CurrencyUnitSelectVM: ObservableObject {

    @Published private(set) var units = [String]()
    @Published var selection = 1
    
    init() {
        fetchLiveInfo()
    }
    
    private func fetchLiveInfo() {
        // TODO: Live情報取得を正しく実装
        let currencies = liveData.quotes.map { (unit, amount) in Currency(unit: unit, amountBasedOnUSD: amount) }
        units = currencies.map { (currency) in currency.unit }
    }
}
