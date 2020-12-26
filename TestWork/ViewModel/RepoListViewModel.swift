//
//  RepoListViewModel.swift
//  TestWork
//
//  Created by Serhii Karev on 26.12.2020.
//

import Foundation
import XCoordinator
import RxSwift
import RxCocoa

final class RepoListViewModel: RepoListViewModelProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let disposeBag = DisposeBag()
    
    private let isLoadingRelay: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    private let canFetchData: BehaviorRelay<Bool> = BehaviorRelay(value: true)
    private let repoListRelay: BehaviorRelay<[Repo]> = BehaviorRelay(value: [])
    var unownedRouter: UnownedRouter<MainAppRouter>?
    
    // MARK: - Output
    var isLoadingObservable: Observable<Bool>
    var repoListObservable: Observable<[Repo]>
    
    // MARK: - Input
    var loadNextPageTrigger: Observable<Void>!
    
    private lazy var page: Observable<Int> = {
        func nextPage(_ previousPage: Int?) -> Observable<Int> {
            let last = previousPage ?? 0
            return Observable.just(last + 1)
                .delaySubscription(.milliseconds(300), scheduler: MainScheduler.instance)
        }

        func hasNext(_ page: Int?) -> Bool {
            guard let last = page else { return true }
            return last < 5
        }

        return Observable.page(make: nextPage, while: hasNext, when: self.loadNextPageTrigger)
    }()
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        self.isLoadingObservable = self.isLoadingRelay.share()
        self.repoListObservable = repoListRelay.share()
    }
    
    func setPageTrigger(_ observable: Observable<Void>) {
        self.loadNextPageTrigger = observable
        observeTrigger()
        observePage()
    }
    
    func didSelectedRow(_ row: Int) {
        let repo = repoListRelay.value[row]
    }
}

extension RepoListViewModel {
    func observePage() {
        Observable.zip(page, canFetchData.filter({$0}))
            .observeOn(MainScheduler.asyncInstance)
            
            .flatMap({ [weak self] page, can -> Observable<[Repo]> in
                guard let self = self else {
                    return Observable.empty()
                }
                return self.networkService.repoListRequest(page: page)
            })
            .subscribe(onNext: { [weak self] repos in
                self?.updateRepoList(repos)
                self?.canFetchData.accept(false)
            })
            .disposed(by: disposeBag)
        
        page
            .subscribe(onCompleted: { [weak self] in
                self?.isLoadingRelay.accept(false)
            })
            .disposed(by: disposeBag)
    }
    
    func observeTrigger() {
        loadNextPageTrigger
            .subscribe(onNext: { [weak self] _ in
                self?.changeFetchDataIfNeed()
            }).disposed(by: disposeBag)
    }
}

extension RepoListViewModel {
    func updateRepoList(_ list: [Repo]) {
        var value = repoListRelay.value
        value += list
        repoListRelay.accept(value)
    }
    
    func changeFetchDataIfNeed() {
        if !canFetchData.value {
            canFetchData.accept(true)
        }
    }
}


