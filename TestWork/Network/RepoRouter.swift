//
//  RepoRouter.swift
//  TestWork
//
//  Created by Serhii Karev on 26.12.2020.
//

import Foundation
import Alamofire

enum RepoRouter {
    case fecthReposList(page: Int, limit: Int)
    case repoDetail(id: String)
}

extension RepoRouter {
    var baseURL: String {
        return "https://dummyapi.io"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .fecthReposList: return "/data/api/user"
        case .repoDetail(let id): return "/data/api/user/\(id)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .fecthReposList(let page, let limit):
            return ["page": page, "limit": limit]
        case .repoDetail:
            return nil
        }
    }
}

extension RepoRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
                
        if let parameters = self.parameters {
            request = try URLEncoding.queryString.encode(request, with: parameters)
        }
        
        request.method = method
        return request
    }
}

