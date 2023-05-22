//
//  EditViewController.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 14.04.2023.
//

import UIKit

protocol EditViewControllerDelegate: AnyObject {
    func transmissionFile (file: Items?)
}

class EditViewController: UIViewController {
    
    weak var delegate: EditViewControllerDelegate?
    var model: Items?
    private let serviceAPI = EditFileAPI()
    
    private var pathEnd = ""
    private var name = ""
    private var originName = ""
    private var doc = ""
    private var path = ""
    
    // MARK: - Properties
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = Constants.Colors.iconsAndOtherDetails
        return view
    }()
    
    private lazy var buttonBack : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: UIControl.State.normal)
        button.tintColor = Constants.Colors.iconsAndOtherDetails
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonBackView), for: .touchUpInside)
        return button
    }()

    private lazy var buttonDone : UIButton = {
        let button = UIButton()
        button.setTitle(Constants.TextPreviewFile.previewEditButton, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = Constants.Fonts.smallText
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonDoneView), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Constants.Fonts.header2
        label.text = Constants.TextPreviewFile.previewEditTitle
        label.textColor = Constants.Colors.black
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var contentsView: UIView = {
       let view = UIView(frame: .zero)
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowOpacity = 0.2
        view.layer.cornerRadius = 10
        view.backgroundColor = Constants.Colors.white
        view.addSubview(labelImage)
        view.addSubview(textField)
        view.addSubview(buttonEditTextField)
       return view
   }()

    private lazy var labelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = Constants.Colors.black
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Constants.Colors.white
        textField.font = Constants.Fonts.mainBody
        textField.textColor = Constants.Colors.black
        textField.placeholder = Constants.TextPreviewFile.previewEditTextFieldPlaceholder
        
                textField.clearButtonMode = .always
                let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: path)
                if let commaIndex = path.firstIndex(of: ".") {
                    attributedString.addAttribute(.foregroundColor,
                                                  value: UIColor.systemBlue,
                                                  range: NSRange(path.startIndex ..< commaIndex, in: path)
                    )
                    attributedString.addAttribute(.foregroundColor,
                                                  value: UIColor.systemRed,
                                                  range: NSRange(commaIndex ..< path.endIndex, in: path)
                    )
                }
                textField.attributedText = attributedString
        textField.addTarget(self,action: #selector(self.textFieldFilter), for: .editingChanged)
        return textField
    }()
    
    private lazy var buttonEditTextField : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "multiply.circle"), for: UIControl.State.normal)
        button.tintColor = Constants.Colors.iconsAndOtherDetails
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonEditText), for: .touchUpInside)
        return button
    }()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.white
        
        setNameAndPath(model?.path ?? "disk:/")
        textField.text = name
        loadImage(stringUrl: model?.preview ?? "") { image in
            if self.model?.type == "dir" {
                self.labelImage.image = UIImage(named: "Vector2")
            } else {
                self.labelImage.image = image
            }
        }
        setupSubViews()
        setupConstraints()
    }
    // MARK: - View Methods
    private func setupSubViews() {
        self.view.addSubview(buttonBack)
        self.view.addSubview(buttonDone)
        self.view.addSubview(labelTitle)

        self.view.addSubview(contentsView)
        self.view.addSubview(activityIndicator)
    }
    private func setupConstraints() {
        let margins = view.safeAreaLayoutGuide
        buttonBack.snp.makeConstraints { make in
            make.top.equalTo(margins.snp.top).inset(25)
            make.leading.equalTo(margins.snp.leading).inset(25)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        buttonDone.snp.makeConstraints { make in
            make.top.equalTo(margins.snp.top).inset(25)
            make.trailing.equalTo(margins.snp.trailing).inset(25)
            make.width.equalTo(55)
            make.height.equalTo(30)
        }
        labelTitle.snp.makeConstraints { make in
            make.top.equalTo(margins.snp.top).inset(30)
            make.leading.equalTo(buttonBack.snp.trailing).inset(-25)
            make.trailing.equalTo(buttonDone.snp.leading).inset(-25)
        }
        contentsView.snp.makeConstraints { make in
            make.top.equalTo(margins.snp.top).inset(105)
            make.height.equalTo(60)
            make.leading.equalTo(margins.snp.leading).inset(16)
            make.trailing.equalTo(margins.snp.trailing).inset(16)
        }
        labelImage.snp.makeConstraints { make in
            make.leading.equalTo(contentsView.snp.leading).inset(18)
            make.centerY.equalTo(self.contentsView)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        textField.snp.makeConstraints { make in
            make.leading.equalTo(labelImage.snp.trailing).inset(-15)
            make.trailing.equalTo(buttonEditTextField.snp.leading).inset(5)
            make.centerY.equalTo(contentsView.snp.centerY).inset(16)
        }
        buttonEditTextField.snp.makeConstraints { make in
            make.centerY.equalTo(contentsView.snp.centerY)
            make.trailing.equalTo(contentsView.snp.trailing).inset(14)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
    // MARK: - @objc Methods
    @objc
    private func buttonBackView () {
        self.dismiss(animated: true)
    }
    
    @objc
    private func buttonDoneView () {
        if name == originName {
            self.dismiss(animated: true)
        }
        name = textField.text ?? "Default"
        self.path = pathEnd + name + doc
        
        self.activityIndicator.startAnimating()
        self.serviceAPI.fetchEdit(from: model?.path ?? "disk:/", path: self.path) { result in
            switch result {
            case .success(let response):
                print(response)
                do {
                    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                    let documentDirectory = URL(fileURLWithPath: path)
                    let originPath = documentDirectory.appendingPathComponent(self.originName + self.doc)
                    let destinationPath = documentDirectory.appendingPathComponent(self.name + self.doc)
                    try FileManager.default.moveItem(at: originPath, to: destinationPath)
                } catch {
                    print(error)
                }
                self.model?.name = self.name + self.doc
                self.model?.path = self.path
                self.delegate?.transmissionFile(file: self.model)
                self.dismiss(animated: true, completion: nil)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                self.showAlertErrorNoInternet()
                print("Error loading recommended podcasts: \(error.localizedDescription)")
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    @objc
    private func textFieldFilter(_ textField: UITextField) {
        if textField.text?.count == 0 {
            buttonDone.isEnabled = false
            buttonDone.setTitleColor(Constants.Colors.red, for: .normal)
        } else {
            buttonDone.isEnabled = true
            buttonDone.setTitleColor(Constants.Colors.accent1, for: .normal)
        }
    }

    @objc
    private func buttonEditText () {
        textField.text = ""
        buttonDone.isEnabled = false
        buttonDone.setTitleColor(.red, for: .normal)
    }
    // MARK: - Private func
    private func setNameAndPath(_ path: String) {
        
        var paths = ""
        var nameDoc = ""
        if let range = path.range(of: "/", options: .backwards) {
            nameDoc = String(path[range.upperBound...])
        }
        if let lastIndex = nameDoc.lastIndex(of: ".") {
            name = String(nameDoc[..<lastIndex])
            originName = String(nameDoc[..<lastIndex])
        }
        if let lastIndex = path.lastIndex(of: ".") {
            paths = String(path[..<lastIndex])
            doc = String(path[lastIndex...])
        }
        if let lastIndex = paths.lastIndex(of: "/") {
            pathEnd = String(paths[...lastIndex])
        }
    }
}
// MARK: - Extension
extension EditViewController {
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
