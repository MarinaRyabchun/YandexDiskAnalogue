////
////  LoginViewController.swift
////  MarinaRyabchun_diplom_iOS_lvl1
////
////  Created by Марина Рябчун on 04.01.2023.

import UIKit
import WebKit
import SnapKit


class LoginViewController: UIViewController, LoginViewControllerProtocol {
    
    var viewModel: LoginViewModelProtocol?
    // MARK: - Properties
    public lazy var blockImage: UIImageView = {
        let image = UIImage(named: viewModel?.model.imageName ?? "default.png")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle(viewModel?.model.titleButton ?? "text", for: .normal)
        button.setTitleColor(Constants.Colors.white, for: .normal)
        button.titleLabel?.font = Constants.Fonts.buttonText
        button.backgroundColor = Constants.Colors.accent1
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(loginButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.white
        viewModel?.delegate = self
        setupSubViews()
        setupConstraints()
    }
    // MARK: - View Methods
    private func setupSubViews() {
        view.addSubview(blockImage)
        view.addSubview(loginButton)
    }
    private func setupConstraints() {
        blockImage.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(271.05)
            make.centerX.equalTo(self.view)
            make.width.equalTo(195)
            make.height.equalTo(168)
        }
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(92)
            make.centerX.equalTo(self.view)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
    }
    
    @objc
    private func loginButton(_ sender: UIButton) {
        viewModel?.openOAuth()
    }
}
