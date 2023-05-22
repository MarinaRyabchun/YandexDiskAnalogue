//
//  AuthViewModel.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 29.03.2023.
//

import Foundation
import WebKit

protocol AuthViewModelProtocol: AnyObject {
    var delegate: AuthViewControllerProtocol? {get set}
    var model: LoginModel { get set }
    func loginOauth() -> URLRequest?
    func openTabBar()
}

class AuthViewModel: AuthViewModelProtocol {
    
    weak var delegate: AuthViewControllerProtocol?
    
    typealias Routes = TabBarRoute & Dismissable
    private let router: Routes
    var model = LoginModel.content
    
    init(router: Routes) {
        self.router = router
    }
    
    func loginOauth() -> URLRequest? {
        guard var urlComponents = URLComponents(string: "https://oauth.yandex.ru/authorize") else { return nil }
        urlComponents.queryItems = [
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "client_id", value: delegate?.clientId)
        ]
        guard let url = urlComponents.url else { return nil }
        return URLRequest(url: url)
    }
    
    func openTabBar() {
        router.openTabBar()
    }
}


