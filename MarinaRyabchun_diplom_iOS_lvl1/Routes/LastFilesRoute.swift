//
//  FileRoute.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 04.01.2023.
//

import UIKit

protocol LastFilesRoute {
    func makeLastFiles() -> UIViewController
}

extension LastFilesRoute where Self: Router {
    func makeLastFiles() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = LastFilesViewModel(router: router)
        let viewController = LastFilesViewController(viewModel: viewModel)
        router.root = viewController
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: Constants.Image.tabBarIconFile), tag: 1)
        viewController.navigationItem.title = Constants.TextLastFiles.navTitleLastFiles
        return navigation
    }
    
    func selectListTab() {
        root?.tabBarController?.selectedIndex = 1
    }
}

extension DefaultRouter: LastFilesRoute {}
