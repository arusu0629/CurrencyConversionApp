//
//  Currency.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/15.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation

struct Currency: Codable {
    public let source: String
    public let quotes: [String : Double]
}

extension Currency {
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case quotes = "quotes"
    }
}
