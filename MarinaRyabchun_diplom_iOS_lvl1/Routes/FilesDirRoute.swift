//
//  FilesDirRoute.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 15.04.2023.
//

import UIKit

protocol FilesDirRoute {
    func openFilesDir(_ path: String?,_ title: String?)
}

extension FilesDirRoute where Self: Router {
    func openFilesDir(with transition: Transition,_ path: String?,_ title: String?) {
        let router = DefaultRouter(rootTransition: transition)
        let viewModel = AllFilesViewModel(router: router)
        let viewController = FilesDirViewController(viewModel: viewModel)
        viewController.title = title
        viewController.path = path
        viewController.navigationItem.backBarButtonItem = .init(title: nil, style: .plain, target: nil, action: nil)
        viewController.navigationItem.backBarButtonItem?.tintColor = Constants.Colors.iconsAndOtherDetails
        router.root = viewController

        route(to: viewController, as: transition)
    }

    func openFilesDir(_ path: String?,_ title: String?) {
        openFilesDir(with: PushTransition(), path, title)
    }
}

extension DefaultRouter: FilesDirRoute {}


