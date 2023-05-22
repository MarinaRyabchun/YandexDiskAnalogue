//
//  TabBarViewModel.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 07.01.2023.
//

import Foundation

final class TabBarViewModel {
    typealias Routes = ProfileRoute & LastFilesRoute & AllFilesRoute // & Closable
    private let router: Routes

    init(router: Routes) {
        self.router = router
    }

//    func setupVCs() {
//        router.openItem()
//    }
    
    
//    func close() {
//        router.close()
//    }
}
