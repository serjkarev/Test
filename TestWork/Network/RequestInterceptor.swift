//
//  RequestInterceptor.swift
//  TestWork
//
//  Created by Serhii Karev on 26.12.2020.
//

import Foundation
import Alamofire

final class RequestInterceptor: Alamofire.RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session,
               completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        guard let url = urlRequest.url,
            url.absoluteString.contains("https://dummyapi.io") else {
                completion(.success(urlRequest))
                return
        }
        
        var urlRequest = urlRequest
        urlRequest.setValue("5f673807c6cba67fb8284491", forHTTPHeaderField: "app-id")
        
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session,
               dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        guard let response = request.task?.response as? HTTPURLResponse,
            response.statusCode == 401 else {
                return completion(.doNotRetryWithError(error))
        }
    }
}

