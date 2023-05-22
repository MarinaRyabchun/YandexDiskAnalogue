//
//  PublishedFilesRoute.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 13.04.2023.
//

import UIKit

protocol PublishedFilesRoute {
    func openPublishedFiles()
}

extension PublishedFilesRoute where Self: Router {
    func openPublishedFiles(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = PublishedFilesViewModel(router: router)
        let viewController = PublishedFilesViewController(viewModel: viewModel)
        viewController.navigationItem.title = Constants.TextPublishedFiles.navTitlePublishedFiles
        router.root = viewController
        route(to: viewController, as: transition)
    }

    func openPublishedFiles() {
        openPublishedFiles(with: PushTransition())
    }
}

extension DefaultRouter: PublishedFilesRoute {}
