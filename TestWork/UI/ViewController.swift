//
//  ViewController.swift
//  TestWork
//
//  Created by Serhii Karev on 26.12.2020.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {
    
    @IBOutlet weak var reposTableView: UITableView!
    
    var viewModel: RepoListViewModelProtocol!
    
    private let disposeBag = DisposeBag()
    private var showAnimatingCell = false
    
    lazy var loadNextPageTrigger: Observable<Void> = {
        return self.reposTableView.rx.contentOffset
            .flatMap { (offset) -> Observable<Void> in
                let isNearBottomEdge = self.reposTableView.isNearBottomEdge()
                return isNearBottomEdge
                    ? Observable.just(Void())
                    : Observable.empty()
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        registeTableView()
        viewModel.setPageTrigger(loadNextPageTrigger)
        title = "Repos List"
        bindViewModel()
    }
}

private extension ViewController {
    func registeTableView() {
        RepoCell.register(to: reposTableView)
        reposTableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        reposTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.reposTableView.deselectRow(at: indexPath, animated: true)
                self?.viewModel.didSelectedRow(indexPath.row)
        })
        .disposed(by: disposeBag)
    }
    
    func bindViewModel() {
        viewModel.repoListObservable
            .bind(to: reposTableView.rx.items(cellIdentifier: "RepoCell",
                                                    cellType: RepoCell.self)) {_, repo, cell in
                                                        cell.repo = repo
        }.disposed(by: disposeBag)
        
        viewModel
            .isLoadingObservable
            .subscribe(onNext: { [weak self] isLoading in
                self?.showAnimatingCell = isLoading
            })
            .disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RepoCell.cellHeight
    }
}

