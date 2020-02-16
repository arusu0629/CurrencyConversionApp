//
//  CurrencyStoreManager.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/16.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation

final class CurrencyStoreManager {
    static let sharedManager = CurrencyStoreManager()
    
    private let saveKey = "currency_save_key"
    
    func save(currencies: [Currency]) throws {
        try UserDefaultManager.sharedManager.save(object: currencies, forKey: saveKey) { (hasSuccess) in
            print("[CurrencyStoreManage save] hasSuccess = \(hasSuccess)")
        }
    }
    
    func get(onDecode: @escaping ([Currency]?) -> Void) {
        UserDefaultManager.sharedManager.get(object: [Currency].self, forKey: saveKey, onDecode: onDecode)
    }
    
    func notExist() -> Bool {
        return UserDefaultManager.sharedManager.notExist(key: saveKey)
    }
}
