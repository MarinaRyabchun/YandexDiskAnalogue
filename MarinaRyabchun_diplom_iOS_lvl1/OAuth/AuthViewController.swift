//
//  AuthViewController.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 19.03.2023.

import UIKit
import WebKit
import SnapKit


protocol AuthViewControllerProtocol: AnyObject {
    var viewModel: AuthViewModelProtocol? {get set}
    var token: String? {get set}
    var clientId: String {get set}
    var userIsLogged: Bool {get set}
}

class AuthViewController: UIViewController, AuthViewControllerProtocol {
    
    var viewModel: AuthViewModelProtocol?
    var token: String? = UserDefaults.standard.string(forKey: "token")
    var clientId: String = "ae7ccb177a424d3a967e10a9f291806b"
    var userIsLogged: Bool = UserDefaults.standard.bool(forKey: "userIsLogged")
    
    // MARK: - Properties
    private lazy var webView: WKWebView = {
        let webConfig = WKWebViewConfiguration()
        let webview = WKWebView(frame: .zero, configuration: webConfig)
        return webview
    }()
    // MARK: - Init
    init(viewModel: AuthViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = webView
        viewModel?.delegate = self
        guard let request = viewModel?.loginOauth() else { return }
        webView.load(request)
        webView.navigationDelegate = self
    }
}
   // MARK: - Extension
extension AuthViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        if let url = navigationAction.request.url, url.scheme == "myfiles" {
            decisionHandler(.allow)
            let targetString = url.absoluteString.replacingOccurrences(of: "#", with: "?")
            guard let components = URLComponents(string: targetString) else { return }
            if let token = components.queryItems?.first(where: { $0.name == "access_token" })?.value {
                UserDefaults.standard.set(token, forKey: "token")
                UserDefaults.standard.set(true, forKey: "userIsLogged")
            }
            viewModel?.openTabBar()
        } else {
            decisionHandler(.allow)
        }
    }
}


