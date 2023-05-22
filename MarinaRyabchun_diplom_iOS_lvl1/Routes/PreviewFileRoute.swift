//
//  PreviewFileRoute.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 15.04.2023.
//

import UIKit

protocol PreviewFileRoute {
    func openPreviewFile(_ model: Items?)
}

extension PreviewFileRoute where Self: Router {
    func openPreviewFile(with transition: Transition, _ model: Items?) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = PreviewViewController(model: model)
        router.root = viewController
        route(to: viewController, as: transition)
    }

    func openPreviewFile(_ model: Items?) {
        openPreviewFile(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()), model)
    }
}

extension DefaultRouter: PreviewFileRoute {}

