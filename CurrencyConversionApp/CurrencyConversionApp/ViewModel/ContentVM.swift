//
//  ContentVM.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/16.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation
import Combine

final class ContentVM: ObservableObject {
    
    // LiveAPIを叩くまでのインターバル時間(=30分=1800秒)
    private let liveAPIRequestIntevalTimeSec: Int = 30 * 60
    // LiveAPIを最後に叩いた時間を保存しているKey
    private let lastRequestedTimeKey = "lastRequestedTimeKey"

    private(set) var currencies = [Currency]() {
        didSet {
            units = currencies.map { (currency) in currency.unit }
            getCurrenciesCallback.forEach { (callback) in callback(currencies) } 
        }
    }
    @Published private(set) var units = [String]()
    
    private var getCurrenciesCallback = [([Currency]) -> Void]()
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        initializeCurrencies()
    }
    
    func addGetCurrenciesCallback(callback: @escaping ([Currency]) -> Void) {
        getCurrenciesCallback.append(callback)
        callback(self.currencies)
    }
    
    func onDisappear() {
        for anyCancellable in cancellableSet {
            anyCancellable.cancel()
        }
        cancellableSet.removeAll()
        
        getCurrenciesCallback.removeAll()
    }
    
    private func initializeCurrencies() {
        let lastRequestedTime = UserDefaults.standard.value(forKey: lastRequestedTimeKey) as? Date ?? Date(timeIntervalSince1970: 0)
        // ローカルデータが存在しない or 前回APIを叩いてから指定時間経っていたらFetchをする
        let notExist = CurrencyStoreManager.sharedManager.notExist()
        let isPassedTime = isPassedTimeFromNow(lastRequestedTime, intervalTimeSeconds: liveAPIRequestIntevalTimeSec)
        if (notExist || isPassedTime) {
            self.fetchCurrencies()
            return
        }
        // ローカルデータから通貨情報を取得する
        self.loadCurrenciesFromLocal()
    }
    
    private func loadCurrenciesFromLocal() {
        CurrencyStoreManager.sharedManager.get { (currencies) in
            // 取得に失敗したらFetchをする
            guard let currencies = currencies else {
                self.fetchCurrencies()
                return
            }
            self.currencies = currencies
        }
    }
    
    // 最後にAPIを叩いてから指定時間過ぎたかどうか
    private func isPassedTimeFromNow(_ lastRequestedTime: Date, intervalTimeSeconds: Int) -> Bool {
        let currentTime = Date()
        let diffSeconds = Calendar.current.dateComponents([.second], from: lastRequestedTime, to: currentTime).second ?? 0
        return diffSeconds >= intervalTimeSeconds
    }
    
    private func fetchCurrencies() {
        // LiveAPIを叩いて通貨情報を取得する
        CurrencyLayerAPI.live()
            .print()
            .sink(receiveCompletion: { _ in }, receiveValue: onFetchCompleted)
            .store(in: &cancellableSet)
    }
    
    private func onFetchCompleted(live: Live) {
        // 通貨情報が無い場合はFetchし直す
        if (live.quotes.count <= 0) {
            fetchCurrencies()
            return
        }
        
        self.currencies = live.quotes.map { (unit, amount) in Currency(unit: unit, amountBasedOnUSD: amount) }

        // ローカルデータに保存する
        self.saveCurrencies(currencies: self.currencies)

        // liveAPIを叩いた時間を保存しておく
        let currentTime = Date()
        UserDefaults.standard.set(currentTime, forKey: self.lastRequestedTimeKey)
    }
    
    private func saveCurrencies(currencies: [Currency]) {
        try? CurrencyStoreManager.sharedManager.save(currencies: currencies)
    }
}
