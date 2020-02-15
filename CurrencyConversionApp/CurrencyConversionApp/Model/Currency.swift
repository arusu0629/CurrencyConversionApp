//
//  Currency.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/15.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation

struct Currency: Codable {
    public let unit: String
    // USD1ドルを基準にした通貨量
    public let amountBasedOnUSD: Double
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
