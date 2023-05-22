//
//  ProfileRoute.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 04.01.2023.
//

import UIKit

protocol ProfileRoute {
    func makeProfile() -> UIViewController
}

extension ProfileRoute where Self: Router {
    func makeProfile() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewModel = ProfileViewModel(router: router)
        let viewController = ProfileViewController(viewModel: viewModel)
        router.root = viewController
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: Constants.Image.tabBarIconPerson), tag: 0)
        viewController.navigationItem.title = Constants.TextProfile.navTitleProfile
        viewController.navigationItem.backBarButtonItem = .init(title: nil, style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem?.tintColor = Constants.Colors.iconsAndOtherDetails
        return navigation
    }
    
    func selectListTab() {
        root?.tabBarController?.selectedIndex = 0
    }
}

extension DefaultRouter: ProfileRoute {}
