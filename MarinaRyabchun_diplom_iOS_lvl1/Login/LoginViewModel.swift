//
//  LoginViewModel.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 04.01.2023.


import Foundation
import WebKit


protocol LoginViewControllerProtocol: AnyObject {
    var viewModel: LoginViewModelProtocol? {get set}
}

protocol LoginViewModelProtocol: AnyObject {
    var delegate: LoginViewControllerProtocol? {get set}
    var model: LoginModel { get set }
    func openOAuth()
}

class LoginViewModel: LoginViewModelProtocol {
    
    weak var delegate: LoginViewControllerProtocol?
    var model = LoginModel.content
    
    typealias Routes = AuthRoute & Closable
    private let router: Routes
    
    init(router: Routes) {
        self.router = router
    }
    
    func openOAuth() {
        router.openAuthView()
    }
}

