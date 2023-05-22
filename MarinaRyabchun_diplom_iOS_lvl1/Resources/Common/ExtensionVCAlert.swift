//
//  ExtensionVCAlert.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 12.04.2023.
//


import UIKit

extension UIViewController {
    
    func showAlertErrorNoInternet() {
        let alertController = UIAlertController(title: Constants.Text.errorAllertTitle, message: Constants.Text.errorAllertSubtitle, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: Constants.Text.errorAllertButton, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
