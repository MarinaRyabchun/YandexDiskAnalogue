//
//  ModalTransition.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 04.01.2023.
//

import UIKit

final class ModalTransition: Transition {
    // MARK: - Transition
    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        from.present(viewController, animated: true, completion: completion)
    }

    func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        viewController.dismiss(animated: true, completion: completion)
    }
}
