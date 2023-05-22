//
//  LoginRoute.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 04.01.2023.
//

import UIKit

protocol LoginRoute {
    func makeLogin() -> UIViewController
    func openLogin()
}

extension LoginRoute where Self: Router {
    func makeLogin() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LoginViewModel(router: router)
        let viewController = LoginViewController(viewModel: viewModel)
        router.root = viewController
        return viewController
    }
    
    func openLogin(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = LoginViewModel(router: router)
        let viewController = LoginViewController(viewModel: viewModel)
        router.root = viewController
        route(to: viewController, as: transition)
    }

    func openLogin() {
        openLogin(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()))
    }
}

extension DefaultRouter: LoginRoute {}
