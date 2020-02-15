//
//  CurrencyAmountInputView.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/15.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import SwiftUI

struct CurrencyAmountInputView: View {
    
    @ObservedObject var amountInputVM = CurrencyAmountInputVM()
    @EnvironmentObject var exchangeRateListVM: ExchangeRateListVM
    
    var body: some View {
        TextField("Input Currency Amount", text: $amountInputVM.amountText, onEditingChanged: amountInputVM.onChanged, onCommit: self.onCommit)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.numberPad)
    }
    
    private func onCommit() {
        self.amountInputVM.onCommit()
        self.exchangeRateListVM.updateInputAmount(amount: self.amountInputVM.amount)
    }
}

struct CurrencyAmountInputView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyAmountInputView()
    }
}
