//
//  CurrencyAmountInputVM.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/15.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation

final class CurrencyAmountInputVM: ObservableObject {

    // 10桁まで入力可能
    private let maxLength: Int = 10
    
    @Published var amountText: String = "1.00"
    var amount: Double {
        return Double(amountText) ?? 0.0
    }
    
    func onChanged(onChange: Bool) {
    }
    
    func onCommit() {
        checkDegitLimit()
    }
    
    // 桁数をチェックする
    private func checkDegitLimit() {
        if (amountText.count <= maxLength) {
            return
        }
        // 指定桁数を超えていたらそれ以降の桁を削除する
        removeOverCharacters()
    }
    
    private func removeOverCharacters() {
        let startIndex = amountText.index(amountText.startIndex, offsetBy: maxLength)
        let endIndex = amountText.endIndex
        let removeRange = startIndex..<endIndex
        amountText.removeSubrange(removeRange)
    }
}
