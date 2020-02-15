//
//  ExchangeRateListView.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/15.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import SwiftUI

struct ExchangeRateListView: View {
    
    @EnvironmentObject var exchangeRateListVM: ExchangeRateListVM
    
    var body: some View {
        List(exchangeRateListVM.exchangeRateListRowVMs) { viewModel in
            ExchangeRateListRow(viewModel: viewModel)
        }
    }
}

struct ExchangeRateListView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRateListView()
    }
}
