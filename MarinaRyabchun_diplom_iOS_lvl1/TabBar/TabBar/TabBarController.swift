//
//  TabBarController.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 07.01.2023.
//

import UIKit

class TabBarController: UITabBarController {
    private let viewModel: TabBarViewModel
    
    init(viewModel: TabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.white
        UITabBar.appearance().barTintColor = Constants.Colors.white
        tabBar.tintColor = Constants.Colors.accent1
    }
}
