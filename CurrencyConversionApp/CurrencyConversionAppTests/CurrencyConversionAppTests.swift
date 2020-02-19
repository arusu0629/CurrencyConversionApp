//
//  CurrencyConversionAppTests.swift
//  CurrencyConversionAppTests
//
//  Created by Toru Nakandakari on 2020/02/18.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import XCTest
@testable import CurrencyConversionApp

class CurrencyConversionAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /*
     JPYの通貨情報(スタブ)
     */
    class JPYCurrencyTypeStub: CurrencyType {
        var unit: String = "JPY"
        var amountBasedOnUSD: Double = 109.819499 // 1ドルあたりの日本円 (LiveData.JSONから参照)
        var id: String = "JPY"
    }
    
    /*
     USD->JPYに変換するロジックのテスト
     */
    func testConvertUsdToJPY() {
        testConvertUsd100ToJPY()
        testConvertUsd375ToJPY()
        testConvertUsd555_5ToJPY()
    }

    func testConvertUsd100ToJPY() {
        let exchangeRateListRowVM = ExchangeRateListRowVM(currency: JPYCurrencyTypeStub())
        let inputAmount: Double = 100 // 100ドル
        exchangeRateListRowVM.updateRate(usdAmount: inputAmount)
        let result = exchangeRateListRowVM.amountRate
        let expected = 10981.9499
        XCTAssertEqual(result, expected, "inCorrect testConvertUsd100ToJPY")
    }
    
    func testConvertUsd375ToJPY() {
        let exchangeRateListRowVM = ExchangeRateListRowVM(currency: JPYCurrencyTypeStub())
        let inputAmount: Double = 375 // 375ドル
        exchangeRateListRowVM.updateRate(usdAmount: inputAmount)
        let result = exchangeRateListRowVM.amountRate
        let expected = 41182.312125
        XCTAssertEqual(result, expected, "inCorrect testConvertUsd375ToJPY")
    }
    
    func testConvertUsd555_5ToJPY() {
        let exchangeRateListRowVM = ExchangeRateListRowVM(currency: JPYCurrencyTypeStub())
        let inputAmount: Double = 555.5 // 555.5ドル
        exchangeRateListRowVM.updateRate(usdAmount: inputAmount)
        let result = exchangeRateListRowVM.amountRate
        let expected = 61004.7316945
        XCTAssertEqual(result, expected, "inCorrect testConvertUsd555_5ToJPY")
    }
    
    /*
     JPYの金額量 -> USDの金額量に変換するロジックのテスト
     */
    let exchagneRateListVM = ExchangeRateListVM()
    func testCalcUSDAmountInputJPYAmount() {
        testCalcUSDAmount_InputJPYAmount100()
        testCalcUSDAmount_InputJPYAmount375()
        testCalcUSDAmount_InputJPYAmount555_5()
    }
    func testCalcUSDAmount_InputJPYAmount100() {
        // JPY100はUSDに換算したらいくらなのかのテスト
        let inputAmount: Double = 100 // 100円
        let result = exchagneRateListVM.calcUSDAmount(inputAmount: inputAmount, amountBasedOnUSD: JPYCurrencyTypeStub().amountBasedOnUSD)
        let expected = 0.910585105
        // 10桁まで数値比較
        XCTAssertEqual(String(format: "%10", result), String(format: "%10", expected), "inCorrect testCalcUSDAmount_InputJPYAmount100")
    }
    
    func testCalcUSDAmount_InputJPYAmount375() {
        // JPY100はUSDに換算したらいくらなのかのテスト
        let inputAmount: Double = 375 // 375円
        let result = exchagneRateListVM.calcUSDAmount(inputAmount: inputAmount, amountBasedOnUSD: JPYCurrencyTypeStub().amountBasedOnUSD)
        let expected = 3.414694143
        // 10桁まで数値比較
        XCTAssertEqual(String(format: "%10", result), String(format: "%10", expected), "inCorrect testCalcUSDAmount_InputJPYAmount375")
    }
    
    func testCalcUSDAmount_InputJPYAmount555_5() {
        // JPY100はUSDに換算したらいくらなのかのテスト
        let inputAmount: Double = 555.5 // 555.5円
        let result = exchagneRateListVM.calcUSDAmount(inputAmount: inputAmount, amountBasedOnUSD: JPYCurrencyTypeStub().amountBasedOnUSD)
        let expected = 5.058300257
        // 10桁まで数値比較
        XCTAssertEqual(String(format: "%10", result), String(format: "%10", expected), "inCorrect testCalcUSDAmount_InputJPYAmoun555_5")
    }
}
