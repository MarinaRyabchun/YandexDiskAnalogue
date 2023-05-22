//
//  TableViewCellDefault.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 12.04.2023.
//

import UIKit

public class TableCellDefault: UITableViewCell {
    
    // MARK: - Properties
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .gray
        return view
    }()
    
    lazy var labelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.black
        label.font = Constants.Fonts.mainBody
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    lazy var subnameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.iconsAndOtherDetails
        label.font = Constants.Fonts.smallText
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = Constants.Colors.white
        contentView.addSubview(labelImage)
        contentView.addSubview(nameLabel)
        contentView.addSubview(subnameLabel)
        contentView.addSubview(activityIndicator)
        
        labelImage.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).inset(18)
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(labelImage.snp.trailing).inset(-15)
            make.trailing.equalTo(contentView.snp.trailing).inset(18)
            make.top.equalTo(contentView.snp.top).inset(14)
        }
        subnameLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.top.equalTo(nameLabel.snp.bottom).inset(-2)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.labelImage)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func LoadImage
    let url = "https://www.macworld.com/wp-content/uploads/2021/03/macos-high-sierra-folder-icon-100773103-orig-3.jpg?resize=300%2C200&quality=50&strip=all"
    
    func loadImage(stringUrl: String, completion: @escaping ((UIImage?) -> Void)) {
        let token = UserDefaults.standard.string(forKey: "token")
        guard let url = URL(string: stringUrl) else { return }
        var request = URLRequest(url: url)
        request.setValue("OAuth \(token ?? "")", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }
        task.resume()
    }

}

