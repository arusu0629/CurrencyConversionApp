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
    
    var body: some View {
        TextField("Input Currency Amount", text: $amountInputVM.amountText, onEditingChanged: amountInputVM.onChanged, onCommit: amountInputVM.onCommit)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .keyboardType(.numberPad)
    }
}

struct CurrencyAmountInputView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyAmountInputView()
    }
}
