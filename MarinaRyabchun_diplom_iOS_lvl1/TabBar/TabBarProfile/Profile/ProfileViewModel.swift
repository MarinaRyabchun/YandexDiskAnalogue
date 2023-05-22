//
//  ProfileViewModel.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 04.01.2023.
//

import Foundation
import UIKit
import WebKit

protocol ProfileViewModelProtocol: AnyObject {
    var delegate: ProfileViewControllerProtocol? {get set}
    var data: ProfileModel? {get set}
    var serviceAPI: ProfileAPI? {get set}
    func openPublishedFiles()
    func openLogin()
}

class ProfileViewModel: ProfileViewModelProtocol {
    
    weak var delegate: ProfileViewControllerProtocol?
    var data: ProfileModel?
    var serviceAPI: ProfileAPI? = ProfileAPI()
    
    typealias Routes = LoginRoute & PublishedFilesRoute
    private let router: Routes

    init(router: Routes) {
        self.router = router
    }
    
    func openPublishedFiles() {
        router.openPublishedFiles()
    }
    
    func openLogin() {
        router.openLogin()
    }
    
}
