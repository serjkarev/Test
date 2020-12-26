//
//  NetworkServiceProtocol.swift
//  TestWork
//
//  Created by Serhii Karev on 26.12.2020.
//

import Foundation
import RxSwift

protocol NetworkServiceProtocol {
    func repoListRequest(page: Int) -> Observable<[Repo]>
}
