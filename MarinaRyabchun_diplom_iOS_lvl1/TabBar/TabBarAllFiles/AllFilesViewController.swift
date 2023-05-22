//
//  AllFilesViewController.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 04.01.2023.
//

import UIKit

class AllFilesViewController: TableViewControllerDefault, AllFilesViewControllerProtocol {

    var path: String? = nil
    var cellIdentifier: String = "FileTableViewCell"
    var viewModel: AllFilesViewModelProtocol
    private let serviceAPI = AllFilesAPI()
    private var modelClass = AllFilesClass()
    
    // MARK: - Properties
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Constants.Fonts.mainBody
        label.text = Constants.TextAllFiles.allFilesDirisEmpty
        label.textColor = Constants.Colors.black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    // MARK: - Init
    init(viewModel: AllFilesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AllFilesTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        setupSubViews()
        setupConstraints()
    }
    // MARK: - View Methods
    private func setupSubViews() {
        view.addSubview(label)
        self.label.isHidden = true
        self.tableView.isHidden = true
    }
    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
    internal override func updateData () {
        activityIndicator.startAnimating()
        serviceAPI.fetchFullDiskResponse(path,limit) { result in
            switch result {
            case .success(let response):
                print("All files: \(response._embedded?.items.count ?? 0)")
                
                var model : [Items] = []
                for item in response._embedded?.items ?? [] {
                    model.append(Items(name: item?.name,
                                       preview: item?.preview,
                                       created: item?.created,
                                       modified: item?.modified,
                                       path: item?.path,
                                       type: item?.type,
                                       mime_type: item?.mime_type,
                                       size: item?.size,
                                       file: item?.file))

                }
                
                self.modelClass.saveToCoreData(array: model)
                self.modelClass.saveData()
                
                self.tableView.reloadData()
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                self.showAlertErrorNoInternet()
                print("Error loading recommended podcasts: \(error.localizedDescription)")
                self.activityIndicator.stopAnimating()
            }
            
            if self.modelClass.connectContext().count == 0 {
                self.label.isHidden = false
            } else {
                self.tableView.isHidden = false
            }
        }
    }
}
// MARK: - Extension
extension AllFilesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelClass.connectContext().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let files = modelClass.connectContext()[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? AllFilesTableViewCell
        
        cell?.configure(files)
        
        if files.type == "dir" {
            cell?.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        } else {
            cell?.accessoryType = UITableViewCell.AccessoryType.none
        }
        cell?.accessoryView?.backgroundColor = .white
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = modelClass.connectContext()[indexPath.row]
        if model.type == "dir" {
            viewModel.openFilesDir(model.path, model.name)
        } else {
            viewModel.openPreviewFile(model)
        }
    }
}
