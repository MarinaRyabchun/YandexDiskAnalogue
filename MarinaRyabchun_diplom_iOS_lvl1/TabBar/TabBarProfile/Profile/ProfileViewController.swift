//
//  ProfileViewController.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 04.01.2023.
//

import UIKit
import WebKit
import Charts

protocol ProfileViewControllerProtocol: AnyObject {
    func updateData()
}

class ProfileViewController: UIViewController, ProfileViewControllerProtocol {
    
    private let viewModel: ProfileViewModelProtocol
    private let token = UserDefaults.standard.string(forKey: "token")
    // MARK: - Properties
    private lazy var pieView: PieChartView = {
        let view = PieChartView()
        return view
    }()
    
    private lazy var labelUsedSpace: UILabel = {
        let label = UILabel()
        label.text = "        \((self.viewModel.data?.used_space ?? 0).formatterForSizeValueFile()) - \(Constants.TextProfile.profileLabelBusy)"
        label.font = Constants.Fonts.mainBody
        label.textColor = Constants.Colors.black
        let image: UIImage = UIImage(named: Constants.Image.ellipse10)!
        var bgImage: UIImageView?
        bgImage = UIImageView(image: image)
        bgImage!.frame = CGRectMake(0,0,21,21)
        label.addSubview(bgImage!)
        return label
    }()
    
    private lazy var labelFreeSpace: UILabel = {
        let label = UILabel()
        label.text = "        \(((viewModel.data?.total_space ?? 0) - (viewModel.data?.used_space ?? 0)).formatterForSizeValueFile()) - \(Constants.TextProfile.profileLabelFree)"
        label.font = Constants.Fonts.mainBody
        label.textColor = Constants.Colors.black
        let image: UIImage = UIImage(named: Constants.Image.ellipse10_2)!
        var bgImage: UIImageView?
        bgImage = UIImageView(image: image)
        bgImage!.frame = CGRectMake(0,0,21,21)
        label.addSubview(bgImage!)
        return label
    }()
    
    private lazy var contentsButtonView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        view.layer.shadowOpacity = 0.2
        view.layer.cornerRadius = 10
        view.backgroundColor = Constants.Colors.white
        
        view.addSubview(labelImage)
        view.addSubview(buttonNextView)
        return view
    }()
    
    private lazy var buttonNextView : UIButton = {
        let button = UIButton()
        button.setTitle(Constants.TextProfile.profileButtonPublishedFiles, for: .normal)
        button.setTitleColor(Constants.Colors.black, for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = Constants.Fonts.mainBody
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(openPublishedFiles), for: .touchUpInside)
        return button
    }()
    private lazy var labelImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = Constants.Colors.iconsAndOtherDetails
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var tabBarButton : UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = Constants.Colors.iconsAndOtherDetails
        button.addTarget(self, action: #selector(tabBarButtonPressed), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        return button
    }()
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .gray
        return indicator
    }()
    
    // MARK: - Init
    init(viewModel: ProfileViewModelProtocol) {
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
        setupSubViews()
        setupConstraints()
        setupPieChart()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateData()
    }
    
    // MARK: - View Methods
    private func setupSubViews() {
        view.addSubview(pieView)
        view.addSubview(labelUsedSpace)
        view.addSubview(labelFreeSpace)
        view.addSubview(contentsButtonView)
        view.addSubview(tabBarButton)
        view.addSubview(activityIndicator)
    }
    private func setupConstraints() {
        pieView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(100)
            make.left.equalTo(view.snp.left).inset(32)
            make.height.equalTo(280)
            make.centerX.equalTo(self.view)
        }
        labelUsedSpace.snp.makeConstraints { make in
            make.top.equalTo(pieView.snp.bottom).inset(-25)
            make.left.equalTo(pieView.snp.left)
            make.height.equalTo(20)
        }
        labelFreeSpace.snp.makeConstraints { make in
            make.top.equalTo(labelUsedSpace.snp.bottom).inset(-25)
            make.left.equalTo(pieView.snp.left)
            make.height.equalTo(20)
        }
        contentsButtonView.snp.makeConstraints { make in
            make.top.equalTo(labelFreeSpace.snp.bottom).inset(-32)
            make.leading.equalTo(view.snp.leading).inset(16)
            make.trailing.equalTo(view.snp.trailing).inset(16)
            make.height.equalTo(45)
        }
        buttonNextView.snp.makeConstraints { make in
            make.centerY.equalTo(contentsButtonView)
            make.leading.equalTo(contentsButtonView.snp.leading).inset(19)
            make.width.equalTo(contentsButtonView)
        }
        labelImage.snp.makeConstraints { make in
            make.centerY.equalTo(contentsButtonView)
            make.trailing.equalTo(contentsButtonView.snp.trailing).inset(10)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(pieView.center)
        }
    }
    
    @objc
    private func openPublishedFiles () {
        viewModel.openPublishedFiles()
    }
    
    @objc
    private func tabBarButtonPressed() {
        let alert = UIAlertController(title: Constants.TextProfile.profileAllert1Title, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Constants.TextProfile.profileAllert1Button1, style: .destructive, handler: { action in
            let alert = UIAlertController(title: Constants.TextProfile.profileAllert2Title, message: Constants.TextProfile.profileAllert2Subtitle, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.TextProfile.profileAllert2ButtonNo, style: .destructive))
            alert.addAction(UIAlertAction(title: Constants.TextProfile.profileAllert2ButtonOk, style: .cancel, handler: { action in
                DispatchQueue.main.async { [weak self] in
                    self?.logOut()
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: Constants.TextProfile.profileAllert1Button2, style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }

    private func setupPieChart () {
        pieView.rotationAngle = 0
        pieView.drawEntryLabelsEnabled = false
        pieView.drawCenterTextEnabled = true
        pieView.holeRadiusPercent = 0.550
        
        let myAttribute = [ NSAttributedString.Key.font: Constants.Fonts.header2 ]
        let myAttrString = NSAttributedString(string: "0 \(Constants.TextProfile.profileLabelBt)", attributes: myAttribute as [NSAttributedString.Key : Any])
        pieView.centerAttributedText = myAttrString
        
        pieView.legend.enabled = false
        var entries: [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: (viewModel.data?.used_space ?? 50).formatterForSizeCharts(), label: Constants.TextProfile.profileLabelBusy))
        entries.append(PieChartDataEntry(value: ((viewModel.data?.total_space ?? 50) - (viewModel.data?.used_space ?? 0)).formatterForSizeCharts(), label: Constants.TextProfile.profileLabelFree))
        
        let dataSet = PieChartDataSet(entries: entries, label: "")
        
        let timeColorString = [NSUIColor(cgColor: UIColor(hexString: "#f1afaa").cgColor),NSUIColor(cgColor: UIColor(hexString: "#9e9e9e").cgColor) ]
        dataSet.colors = timeColorString
        dataSet.drawValuesEnabled = false
        
        pieView.data = PieChartData(dataSet: dataSet)
    }
    
    func updateData() {
        activityIndicator.startAnimating()
        
        viewModel.serviceAPI?.fetchSizeDisk() { result in
            switch result {
            case .success(let response):
                self.viewModel.data = response
                self.setupPieChart()
                self.labelUsedSpace.text = "        \((self.viewModel.data?.used_space ?? 0).formatterForSizeValueFile()) - \(Constants.TextProfile.profileLabelBusy)"
                self.labelFreeSpace.text = "        \(((self.viewModel.data?.total_space ?? 0) - (self.viewModel.data?.used_space ?? 0)).formatterForSizeValueFile()) - \(Constants.TextProfile.profileLabelFree)"
                let myAttribute = [ NSAttributedString.Key.font: Constants.Fonts.header2 ]
                let myAttrString = NSAttributedString(string: "\((self.viewModel.data?.total_space ?? 0).formatterForSizeValueFile())", attributes: myAttribute as [NSAttributedString.Key : Any])
                self.pieView.centerAttributedText = myAttrString
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                self.showAlertErrorNoInternet()
                print("Error loading recommended podcasts: \(error.localizedDescription)")
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func logOut() {
        UserDefaults.standard.removeObject(forKey: "userIsLogged")
        UserDefaults.standard.removeObject(forKey: "token")
        
        CoreDataManager.shared.deleteAllData("PublishedFiles")
        CoreDataManager.shared.deleteAllData("LastFiles")
        CoreDataManager.shared.deleteAllData("AllFiles")
        
        let fileManager = FileManager.default
        do {
            let documentDirectoryURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            let fileURLs = try fileManager.contentsOfDirectory(at: documentDirectoryURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            for url in fileURLs {
                try fileManager.removeItem(at: url)
            }
        } catch {
            print(error)
        }
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()){ records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
            }
        }
        self.viewModel.openLogin()
    }
}
