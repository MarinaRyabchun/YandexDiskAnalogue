//
//  ArchiveRoute.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 04.01.2023.
//

import UIKit

protocol AllFilesRoute {
    func makeAllFiles() -> UIViewController
}

extension AllFilesRoute where Self: Router {
    func makeAllFiles() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = AllFilesViewModel(router: router)
        let viewController = AllFilesViewController(viewModel: viewModel)
        router.root = viewController
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: Constants.Image.tabBarIconArchive), tag: 2)
        viewController.navigationItem.title = Constants.TextAllFiles.navTitleAllFiles
        viewController.navigationItem.backBarButtonItem = .init(title: nil, style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem?.tintColor = Constants.Colors.iconsAndOtherDetails
        return navigation
    }
    
    func selectListTab() {
        root?.tabBarController?.selectedIndex = 2
    }
}

extension DefaultRouter: AllFilesRoute {}
