//
//  NetworkService.swift
//  TestWork
//
//  Created by Serhii Karev on 26.12.2020.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkService {
    private let interceptor = RequestInterceptor()
    private let alamofire: Session
    
    init() {
        self.alamofire = Session(interceptor: interceptor)
    }
}

extension NetworkService: NetworkServiceProtocol{
    
    func repoListRequest(page: Int) -> Observable<[Repo]> {
        return Observable.create { [weak self] observer -> Disposable in
            let route: RepoRouter = .fecthReposList(page: page, limit: 30)
            
            self?.alamofire.request(route)
                .validate()
                .responseDecodable(of: RepoResponse.self) { result in
                    switch result.result {
                    case .success(let repoResponse):
                        observer.onNext(repoResponse.data)
                    case .failure(let error): observer.onError(error)
                    }
            }
            return Disposables.create()
        }
    }
}

