//
//  FullFileTableViewCell2.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 14.04.2023.
//

import UIKit

final class AllFilesTableViewCell: TableCellDefault {
    
    func configure(_ file: Items) {
        activityIndicator.startAnimating()
        loadImage(stringUrl: file.preview ?? url) { image in
            if file.type == "dir" {
                self.labelImage.image = UIImage(named: "Vector2")
                self.subnameLabel.text = ((file.modified)!).dateFormater()
            } else {
                self.labelImage.image = image
                self.subnameLabel.text = (((file.size)) ?? 0).formatterForSizeValueFile() + " "
                + ((file.modified)!).dateFormater()
            }
        }
        activityIndicator.stopAnimating()
        nameLabel.text = file.name
    }
}

