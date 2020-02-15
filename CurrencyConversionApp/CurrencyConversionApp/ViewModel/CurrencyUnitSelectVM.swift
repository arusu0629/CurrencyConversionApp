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
    @Published var selection = 0
    
    init() {
        fetchLiveInfo()
        decideInitialSelectionIndex()
    }
    
    private func fetchLiveInfo() {
        // TODO: Live情報取得を正しく実装
        let currencies = liveData.quotes.map { (unit, amount) in Currency(unit: unit, amountBasedOnUSD: amount) }
        units = currencies.map { (currency) in currency.unit }
    }
    
    // PickerViewの最初の選択位置を決める
    // 仕様：USDを初期選択状態にしておく
    private func decideInitialSelectionIndex() {
        guard let usdIndex = units.firstIndex(of: "USD") else {
            return
        }
        selection = usdIndex
    }
}
