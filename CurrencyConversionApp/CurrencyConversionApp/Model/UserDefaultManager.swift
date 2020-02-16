//
//  UserDefaultManager.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/16.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation

final class UserDefaultManager {

    public static let sharedManager = UserDefaultManager()

    func save<T: Encodable>(object: T, forKey: String, onEncode: @escaping (Bool) -> Void) throws {
        do {
            try UserDefaults.standard.set(object: object, for: forKey, onEncode:  onEncode)
        }
        catch (let error) {
            print("failed to encode error = \(error)")
        }
    }
    
    func get<T: Decodable>(object type: T.Type, forKey: String, onDecode: @escaping (T?) -> Void) {
        UserDefaults.standard.get(object: type, for: forKey, onDecode: onDecode)
    }
    
    func notExist(key: String) -> Bool {
        return UserDefaults.standard.value(forKey: key) == nil
    }
}

public extension UserDefaults {
    func set<T: Encodable>(object type: T, for key: String, onEncode: @escaping (Bool) -> Void) throws {

        JSONEncoder().encodeInBackground(from: type) { [weak self] (data) in
            guard let data = data, let `self` = self else {
                onEncode(false)
                return
            }
            self.set(data, forKey: key)
            onEncode(true)
        }
    }
    func get<T: Decodable>(object type: T.Type, for key: String, onDecode: @escaping (T?) -> Void) {
        let data = value(forKey: key) as? Data
        JSONDecoder().decodeInBackground(from: data, onDecode: onDecode)
    }
}

extension JSONDecoder {
       func decode<T: Decodable>(from data: Data?) -> T? {
           guard let data = data else {
               return nil
           }
           return try? self.decode(T.self, from: data)
       }
       func decodeInBackground<T: Decodable>(from data: Data?, onDecode: @escaping (T?) -> Void) {
           DispatchQueue.global().async {
               let decoded: T? = self.decode(from: data)

               DispatchQueue.main.async {
                   onDecode(decoded)
               }
           }
       }
}

public extension JSONEncoder {
    func encode<T: Encodable>(from value: T?) -> Data? {
        guard let value = value else {
            return nil
        }
        return try? self.encode(value)
    }
    func encodeInBackground<T: Encodable>(from encodableObject: T?, onEncode: @escaping (Data?) -> Void) {
        DispatchQueue.global().async {
            let encode = self.encode(from: encodableObject)

            DispatchQueue.main.async {
                onEncode(encode)
            }
        }
    }
}
