//
//  PublishedFilesViewController2.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 14.04.2023.
//

import UIKit

final class PublishedFilesViewController: TableViewControllerDefault, PublishedFilesViewControllerProtocol {
    
    var path: String?
    var cellIdentifier: String = "UpDateTableViewCell"
    var viewModel: PublishedFilesViewModelProtocol
    private var filesData = PublishedFileClass()
    private let serviceAPI = PublishedFilesAPI()
     
    // MARK: - Properties
    private lazy var blockImage: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(named: Constants.Image.group21168)
        return image
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Constants.Fonts.header2
        label.text = Constants.TextPublishedFiles.publishedFilesLabel
        label.textColor = Constants.Colors.black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var buttonUpdate: UIButton = {
        let button = UIButton(frame: .zero)
        button.layer.cornerRadius = 10
        button.backgroundColor = Constants.Colors.accent2
        button.setTitle(Constants.TextPublishedFiles.publishedFilesButton, for: .normal)
        button.setTitleColor(Constants.Colors.black, for: .normal)
        button.titleLabel?.font = Constants.Fonts.buttonText
        button.addTarget(self, action: #selector(update), for: .touchUpInside)
        return button
        }()
    
    // MARK: - Init
    init(viewModel: PublishedFilesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]

        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = Constants.Colors.iconsAndOtherDetails
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PublishedFilesCell.self, forCellReuseIdentifier: cellIdentifier)
        setupSubViews()
        setupConstraints()
    }
    
    // MARK: - View Methods
    
    func setupSubViews() {
        self.view.addSubview(blockImage)
        self.view.addSubview(textLabel)
        self.view.addSubview(buttonUpdate)
        
        self.blockImage.isHidden = true
        self.textLabel.isHidden = true
        self.buttonUpdate.isHidden = true
        self.tableView.isHidden = true
    }
    
    func setupConstraints() {
        blockImage.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(224)
            make.centerX.equalTo(self.view)
            make.width.equalTo(150)
            make.height.equalTo(150)
        }
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(blockImage.snp.bottom).inset(-35)
            make.centerX.equalTo(self.view)
            make.width.equalTo(260)
        }
        buttonUpdate.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(100)
            make.centerX.equalTo(self.view)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
    }
    
    internal override func updateData () {
        activityIndicator.startAnimating()

        serviceAPI.fetchPublishedFiles(limit) { result in
            switch result {
            case .success(let response):
                print("Published files: \(response.items.count)")
        
                var model : [Items] = []
                for item in response.items {
                    model.append(Items(name: item?.name,
                                       preview: item?.preview,
                                       created: item?.created,
                                       modified: item?.modified,
                                       path: item?.path,
                                       type: item?.type,
                                       mime_type: item?.mime_type,
                                       size: item?.size,
                                       file: item?.file
                                      ))

                }
                
                self.filesData.saveToCoreData(array: model)
                self.filesData.seveData()
                
                self.tableView.reloadData()
                self.isMoreDataLoading = false
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                self.showAlertErrorNoInternet()
                print("Error loading recommended podcasts: \(error.localizedDescription)")
                self.activityIndicator.stopAnimating()
            }
            
            if self.filesData.connectContext().count == 0 {
                self.blockImage.isHidden = false
                self.textLabel.isHidden = false
                self.buttonUpdate.isHidden = false
            } else {
                self.tableView.isHidden = false
            }
        }
    }
    
    @objc
    private func update (_ sender: UIButton){
        updateData()
    }
}

// MARK: - Table View Data Source
extension PublishedFilesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filesData.connectContext().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let files = filesData.connectContext()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? PublishedFilesCell
        
        cell?.configure(files)
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let model = filesData.connectContext()[indexPath.row]
        if model.type == "dir" {
            viewModel.openFilesDir(model.path, model.name)
        } else {
            viewModel.openPreviewFile(model)
        }
    }
}

// MARK: - Table View Cell Delegate Protocol
protocol PublishedTableViewCellDelegate: AnyObject {
    func presentAlertTableViewCell(_ tableViewCell: PublishedFilesCell, subscribeButtonTappedFor nameFile: String, path: String)
}

// MARK: - Table View Cell Delegate
extension PublishedFilesViewController : PublishedTableViewCellDelegate {
    func presentAlertTableViewCell(_ tableViewCell: PublishedFilesCell, subscribeButtonTappedFor nameFile: String, path: String) {
        
        let alert = UIAlertController(title: "\(nameFile)", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Constants.TextPublishedFiles.publishedFilesAllertTitle, style: .destructive, handler: { action in
            
            self.activityIndicator.startAnimating()
            self.serviceAPI.fetchDeleteActiveLink(path) { result in
                switch result {
                case .success(let response):
                    print(response)
                    self.tableView.reloadData()
                    self.activityIndicator.stopAnimating()
                    self.updateData()
                case .failure(let error):
                    self.showAlertErrorNoInternet()
                    print("Error loading recommended podcasts: \(error.localizedDescription)")
                    self.activityIndicator.stopAnimating()
                }
            }
        }))
        alert.addAction(UIAlertAction(title: Constants.TextPublishedFiles.publishedFilesAllertCancel, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}




