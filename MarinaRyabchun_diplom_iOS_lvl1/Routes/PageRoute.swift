//
//  PageRoute.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 06.01.2023.
//

import UIKit

protocol PageRoute {
    func makePage() -> UIPageViewController
}

extension PageRoute where Self: Router {
    func makePage() -> UIPageViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = PageViewModel(router: router)
        let viewController = PageViewController(viewModel: viewModel)
        router.root = viewController
        return viewController
    }
}

extension DefaultRouter: PageRoute {}


