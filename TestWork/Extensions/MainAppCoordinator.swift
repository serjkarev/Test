//
//  MainAppCoordinator.swift
//  TestWork
//
//  Created by Serhii Karev on 26.12.2020.
//

import Foundation
import XCoordinator
import SwiftUI

enum MainAppRouter: Route {
    case repoList
}

class MainAppCoordinator: NavigationCoordinator<MainAppRouter> {
    
    private let networkService: NetworkServiceProtocol = NetworkService()
    
    init() {
        super.init(initialRoute: .repoList)
    }
    
    override func prepareTransition(for route: MainAppRouter) -> NavigationTransition {
        switch route {
        case .repoList:
            let vc = UIStoryboard.mainViewController()
            let viewModel = RepoListViewModel(networkService: networkService)
            viewModel.unownedRouter = unownedRouter
            vc.viewModel = viewModel
            return .push(vc)
        }
    }
}
