//
//  PageViewModel.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 06.01.2023.
//

import Foundation

protocol PageViewModelProtocol: AnyObject {
    func openLogin()
}

class PageViewModel: PageViewModelProtocol {
    
    typealias Routes = LoginRoute & Closable
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
    
    func openLogin() {
        router.openLogin()
    }
}
