//
//  PublishedFilesCell.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 14.04.2023.
//

import UIKit

final class PublishedFilesCell: TableCellDefault {
    
    // MARK: - Properties
    private var path = ""
    private var fileTableView : String?
    weak var delegate : PublishedTableViewCellDelegate?

    private lazy var buttonView : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: UIControl.State.normal)
        button.tintColor = Constants.Colors.iconsAndOtherDetails
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(presentAlert), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(buttonView)
        nameLabel.snp.makeConstraints { make in
            make.trailing.equalTo(buttonView.snp.trailing).inset(-5)
        }
        buttonView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView.snp.trailing).inset(5)
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View Methods
    func configure(_ file: Items) {
        activityIndicator.startAnimating()
        loadImage(stringUrl: file.preview ?? url) { image in
            if file.type == "dir" {
                self.labelImage.image = UIImage(named: "Vector2")
                self.subnameLabel.text = ((file.modified)!).dateFormater()
            } else {
                self.labelImage.image = image
                self.subnameLabel.text = ((Int(file.size ?? 0)) ).formatterForSizeValueFile() + " "
                + ((file.modified)!).dateFormater()
            }
        }
        activityIndicator.stopAnimating()
        nameLabel.text = file.name
        
        fileTableView = file.name
        path = file.path!
    }
    
    @objc
    private func presentAlert () {
        if let file = fileTableView {
            self.delegate?.presentAlertTableViewCell(self, subscribeButtonTappedFor: file, path: path)
        }
    }
}

