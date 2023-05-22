//
//  AnimatedTransition.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 04.01.2023.
//

import UIKit

protocol AnimatedTransitionProtocol: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool { get set }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)

    func present(using transitionContext: UIViewControllerContextTransitioning)

    func dismiss(using transitionContext: UIViewControllerContextTransitioning)
}

final class AnimatedTransition: NSObject {
    var animatedTransition: AnimatedTransitionProtocol
    var isAnimated: Bool = true

    init(animatedTransition: AnimatedTransitionProtocol, isAnimated: Bool = true) {
        self.animatedTransition = animatedTransition
        self.isAnimated = isAnimated
    }
}

extension AnimatedTransition: Transition {
    // MARK: - Transition
    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        from.present(viewController, animated: isAnimated, completion: completion)
    }

    func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        viewController.dismiss(animated: isAnimated, completion: completion)
    }
}

extension AnimatedTransition: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransition.isPresenting = true
        return animatedTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransition.isPresenting = false
        return animatedTransition
    }
}

