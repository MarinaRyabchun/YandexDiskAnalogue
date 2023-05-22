//
//  AuthViewRoute.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 25.03.2023.
//

import UIKit

protocol AuthRoute {
    func openAuthView()
}

extension AuthRoute where Self: Router {
    func openAuthView(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = AuthViewModel(router: router)
        let viewController = AuthViewController(viewModel: viewModel)
        router.root = viewController
        route(to: viewController, as: transition)
    }
    func openAuthView() {
        openAuthView(with: ModalTransition())
    }
    
}

extension DefaultRouter: AuthRoute {}
