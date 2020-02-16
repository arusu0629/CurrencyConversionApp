//
//  CurrencyUnitSelectVM.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/15.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation

final class CurrencyUnitSelectVM: ObservableObject {

    @Published var selection = 0
    @Published private(set) var units = [String]()
    @Published private(set) var isExistUnits: Bool = false
    
    func convertCurrenciesToUnits(currencies: [Currency]) {
        units = currencies.map { (currency) in currency.unit }
        isExistUnits = units.count > 0
    }

    // PickerViewの最初の選択位置を決める
    func setUSDSelectionIndex() {
        guard let usdIndex = units.firstIndex(of: "USD") else {
            return
        }
        selection = usdIndex
    }
}
