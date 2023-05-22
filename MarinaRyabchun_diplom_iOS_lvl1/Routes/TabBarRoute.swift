//
//  TabBarRoute.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 07.01.2023.
//

import UIKit

protocol TabBarRoute {
    func makeTabBar() -> UITabBarController
    func openTabBar()
}

extension TabBarRoute where Self: Router {
    func makeTabBar() -> UITabBarController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = TabBarViewModel(router: router)
        let tabBar = TabBarController(viewModel: viewModel)
        let tabs = [router.makeProfile(), router.makeLastFiles(), router.makeAllFiles()]
        tabBar.viewControllers = tabs
        tabBar.selectedIndex = 1
        return tabBar
    }
    
    func openTabBar(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = TabBarViewModel(router: router)
        let tabBar = TabBarController(viewModel: viewModel)
        let tabs = [router.makeProfile(), router.makeLastFiles(), router.makeAllFiles()]
        tabBar.viewControllers = tabs
        tabBar.selectedIndex = 1
        route(to: tabBar, as: transition)
    }
    
    func openTabBar() {
        openTabBar(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()))
    }
}

extension DefaultRouter: TabBarRoute {}
