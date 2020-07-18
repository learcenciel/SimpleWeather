//
//  HTTPClient.swift
//  SimpleWeather
//
//  Created by Alexander on 25.05.2020.
//  Copyright © 2020 Alexander Team. All rights reserved.
//

import Alamofire
import Foundation

enum HTTPErrors: Error {
    case parsingError
}

class HTTPClient {
    
    static let commonParameters: [String: Any] = [
        "appid": "7c14050dc2468d9a5ceb40d2edf24188",
    ]
    
    func get<T: Decodable>(url: String,
                           parameters: [String: Any]?, completionHandler: @escaping(Result<T, HTTPErrors>) -> Void) {
        var queryParameters = HTTPClient.commonParameters

        if let parameters = parameters {
            for key in parameters.keys {
                queryParameters[key] = parameters[key]
            }
        }
        
        AF.request(url, method: .get, parameters: queryParameters).validate().responseData { data in
            switch data.result {
            case .success(let responseData):
                do {
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .secondsSince1970
                    let decodedResponseData = try jsonDecoder.decode(T.self, from: responseData)
                    completionHandler(.success(decodedResponseData))
                } catch {
                    completionHandler(.failure(.parsingError))
                }
            case .failure:
                completionHandler(.failure(.parsingError))
            }
        }
    }
}
