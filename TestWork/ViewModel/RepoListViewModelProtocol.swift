//
//  RepoListViewModelProtocol.swift
//  TestWork
//
//  Created by Serhii Karev on 26.12.2020.
//

import Foundation
import RxSwift

protocol RepoListViewModelProtocol {
    var isLoadingObservable: Observable<Bool> { get }
    var repoListObservable: Observable<[Repo]> { get }
    
    func setPageTrigger(_ observable: Observable<Void>)
    func didSelectedRow(_ row: Int)
}

