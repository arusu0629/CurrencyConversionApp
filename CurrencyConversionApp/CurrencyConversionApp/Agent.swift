//
//  File.swift
//  CurrencyConversionApp
//
//  Created by Toru Nakandakari on 2020/02/14.
//  Copyright © 2020 仲村渠亨. All rights reserved.
//

import Foundation
import Combine

struct Agent {
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum CurrencyLayerAPI {
    static let agent = Agent()
    static let base = URL(string: "http://api.currencylayer.com")!
    static let accessToken = "b6e1cf9dbfcd411718aa1b662c26e0cb"
}

extension CurrencyLayerAPI {
    static func live() -> AnyPublisher<Live, Error> {
        let url = base.appendingPathComponent("live")
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = [
            URLQueryItem(name: "access_key", value: accessToken),
        ]
        let request = URLRequest(url: urlComponents.url!)
        return agent.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
