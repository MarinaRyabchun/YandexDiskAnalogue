//
//  LoginModel.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 04.01.2023.
//

import Foundation

struct LoginModel {
    let imageName: String?
    let titleButton: String?
}

extension LoginModel {
    static var content = LoginModel(imageName: Constants.Image.startImage, titleButton: Constants.Text.loginButton)
}
