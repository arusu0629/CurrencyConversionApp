//
//  ExchangeRateListRowVM.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/15.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation

final class ExchangeRateListRowVM: ObservableObject {

    @Published private(set) var currency: Currency
    
    init(currency: Currency) {
        self.currency = currency
    }
}
