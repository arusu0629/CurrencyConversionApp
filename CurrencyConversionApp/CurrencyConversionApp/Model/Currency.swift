//
//  Currency.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/15.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation

protocol CurrencyType {
    var unit: String { get set }
    var amountBasedOnUSD: Double { get }
    var id: String { get set }
}

struct Currency: CurrencyType, Codable, Identifiable {
    
    public var unit: String = ""
    // USD1ドルを基準にした通貨量
    public var amountBasedOnUSD: Double
    
    public var id: String = ""
    
    init(unit: String, amountBasedOnUSD: Double) {
        self.unit = unit
        self.amountBasedOnUSD = amountBasedOnUSD
        self.id = unit

        convertUnit()
    }
    
    // 渡される unit は prefix に基準通貨単位が付いているのでそれを消す
    // 例) USDが基準通貨の場合のJPY: USDJPY となるため JPY にする
    private mutating func convertUnit() {
        var removedPrefixUnit = unit
        removedPrefixUnit.removeSubrange(unit.startIndex..<unit.index(unit.startIndex, offsetBy: 3))
        
        self.unit = removedPrefixUnit
        self.id = removedPrefixUnit
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
