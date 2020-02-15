//
//  Currency.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/15.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation

struct Currency: Codable, Identifiable {
    public let unit: String
    // USD1ドルを基準にした通貨量
    public let amountBasedOnUSD: Double
    
    public let id: String
    
    init(unit: String, amountBasedOnUSD: Double) {
        self.unit = unit
        self.amountBasedOnUSD = amountBasedOnUSD
        self.id = unit
    }
}

struct Live: Codable {
    public let source: String
    public let quotes: [String : Double]
}

extension Live {
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case quotes = "quotes"
    }
}
