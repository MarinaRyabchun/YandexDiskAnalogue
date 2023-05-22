//
//  PreviewViewController.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 15.04.2023.
//

import UIKit
import PDFKit
import WebKit
import CoreData

class PreviewViewController: UIViewController{
    
    private var publicURL = ""
    private var urlDownloadFile = ""
    private let serviceAPI = PreviewAPI()
    private var filesData: ResponsePresenter?
    var model: Items?

    // MARK: - Properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.frame = UIScreen.main.bounds
        imageView.backgroundColor = Constants.Colors.black
        imageView.contentMode = .scaleAspectFit
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    private lazy var pdfView: PDFView = {
        let view = PDFView(frame: .zero)
        view.displayMode = .singlePageContinuous
        view.autoScales = true
        view.displayDirection = .vertical
        view.backgroundColor = Constants.Colors.black ?? .black
        return view
    }()
    
    private lazy var webView: WKWebView = {
        let view = WKWebView(frame: .zero)
        view.backgroundColor = Constants.Colors.black
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Constants.Fonts.mainBody
        label.text = Constants.TextPreviewFile.previewFileNotBeOpened
        label.textColor = Constants.Colors.white
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = Constants.Colors.iconsAndOtherDetails
        return view
    }()
    
    private lazy var labelNameFile: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Constants.Fonts.header2
        label.textColor = Constants.Colors.iconsAndOtherDetails
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var labelDateFile: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = Constants.Fonts.smallText
        label.textColor = Constants.Colors.iconsAndOtherDetails
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    private lazy var buttonBack : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: UIControl.State.normal)
        button.tintColor = Constants.Colors.iconsAndOtherDetails
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonBackView), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonEdit : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: UIControl.State.normal)
        button.tintColor = Constants.Colors.iconsAndOtherDetails
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonEditView), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonShare : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: UIControl.State.normal)
        button.tintColor = Constants.Colors.iconsAndOtherDetails
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonShareAlert), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonDelete : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: UIControl.State.normal)
        button.tintColor = Constants.Colors.iconsAndOtherDetails
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonDeleteAlert), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    init(model: Items?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle
    override func loadView() {
        super.loadView()
        
        setupSubViews()
        setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        self.labelNameFile.text = self.model?.name
        self.labelDateFile.text = self.model?.created?.dateFormater()
        
        setTypeView(model?.mime_type ?? "Error")
    }
    // MARK: - View Methods
    private func setupSubViews() {
        self.view.addSubview(imageView)
        self.view.addSubview(pdfView)
        self.view.addSubview(webView)
        self.view.addSubview(activityIndicator)
        self.view.addSubview(labelNameFile)
        self.view.addSubview(labelDateFile)
        self.view.addSubview(buttonBack)
        self.view.addSubview(buttonEdit)
        self.view.addSubview(buttonShare)
        self.view.addSubview(buttonDelete)
        self.view.addSubview(label)
        
        self.imageView.isHidden = true
        self.pdfView.isHidden = true
        self.webView.isHidden = true
        self.label.isHidden = true
    }
    private func setupConstraints() {
        let margins = view.safeAreaLayoutGuide

        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(margins)
            make.top.equalTo(margins.snp.top)
            make.leading.equalTo(margins.snp.leading)
        }
        pdfView.snp.makeConstraints { make in
            make.size.equalTo(margins)
            make.top.equalTo(margins.snp.top)
            make.leading.equalTo(margins.snp.leading)
        }
        webView.snp.makeConstraints { make in
            make.size.equalTo(margins)
            make.top.equalTo(margins.snp.top)
            make.leading.equalTo(margins.snp.leading)
        }
        labelNameFile.snp.makeConstraints { make in
            make.top.equalTo(margins.snp.top).inset(25)
            make.leading.equalTo(buttonBack.snp.trailing).inset(-25)
            make.trailing.equalTo(buttonEdit.snp.leading).inset(-25)
        }
        labelDateFile.snp.makeConstraints { make in
            make.top.equalTo(labelNameFile.snp.bottom).inset(-7)
            make.leading.equalTo(buttonBack.snp.trailing).inset(25)
            make.trailing.equalTo(buttonEdit.snp.leading).inset(25)
        }
        buttonBack.snp.makeConstraints { make in
            make.top.equalTo(margins.snp.top).inset(25)
            make.leading.equalTo(margins.snp.leading).inset(25)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        buttonEdit.snp.makeConstraints { make in
            make.top.equalTo(margins.snp.top).inset(25)
            make.trailing.equalTo(margins.snp.trailing).inset(25)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        buttonShare.snp.makeConstraints { make in
            make.bottom.equalTo(margins.snp.bottom).inset(37)
            make.leading.equalTo(margins.snp.leading).inset(57)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        buttonDelete.snp.makeConstraints { make in
            make.bottom.equalTo(margins.snp.bottom).inset(37)
            make.trailing.equalTo(margins.snp.trailing).inset(57)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        label.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
    
    // MARK: - @objc Methods
    @objc
    private func imageTapped(_ sender: UITapGestureRecognizer) {
        imageView.contentMode = .scaleAspectFill
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        imageView.addGestureRecognizer(tap)
    }

    @objc
    private func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        imageView.contentMode = .scaleAspectFit
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tap)
    }
    @objc
    private func buttonBackView () {
        self.dismiss(animated: true)
    }
    
    @objc
    private func buttonEditView () {
        let vc = EditViewController()
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.model = model
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc
    private func buttonShareAlert () {
        let alert = UIAlertController(title: Constants.TextPreviewFile.previewAlertShareTitle, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Constants.TextPreviewFile.previewAlertShareButtonFile, style: .default, handler: { action in
            
            self.presentShareSheetFile()
            
        }))
        alert.addAction(UIAlertAction(title: Constants.TextPreviewFile.previewAlertShareButtonLink, style: .default, handler: { action in
            
            self.activityIndicator.startAnimating()
            self.serviceAPI.fetchLine(self.model?.path ?? "disk:/") { result in
                    switch result {
                    case .success(let response):
                        print(response)
                        self.updateData(self.model?.path ?? "disk:/")
                        sleep(1)
                        DispatchQueue.main.async {
                            self.publicURL = self.filesData?.public_url ?? "Error"
                            self.presentShareSheetLink()
                            self.activityIndicator.stopAnimating()
                        }
                    case .failure(let error):
                        self.showAlertErrorNoInternet()
                        print("Error loading recommended podcasts: \(error.localizedDescription)")
                        self.activityIndicator.stopAnimating()
                    }
                }
        }))
        alert.addAction(UIAlertAction(title: Constants.TextPreviewFile.previewAlertShareButtonCancel, style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    private func buttonDeleteAlert () {
        let alert = UIAlertController(title: Constants.TextPreviewFile.previewAlertDeleteTitle, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: Constants.TextPreviewFile.previewAlertDeleteButtonOK, style: .destructive, handler: { action in
            
            self.activityIndicator.startAnimating()
            self.serviceAPI.fetchDelite(self.model?.path ?? "disk:/") { result in
                    switch result {
                    case .success(let response):
                        print(response)
                        self.activityIndicator.stopAnimating()
                        self.dismiss(animated: true)
                    case .failure(let error):
                        self.showAlertErrorNoInternet()
                        print("Error loading recommended podcasts: \(error.localizedDescription)")
                        self.activityIndicator.stopAnimating()
                    }
                }
        }))
        alert.addAction(UIAlertAction(title: Constants.TextPreviewFile.previewAlertDeleteButtonNo, style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Private func
    private func presentShareSheetFile () {
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationFileUrl = documentsUrl.appendingPathComponent(model?.name ?? "file")
        
        let shareShetVC = UIActivityViewController(activityItems: [destinationFileUrl], applicationActivities: nil)
        present(shareShetVC,animated: true)
    }
    
    private func presentShareSheetLink () {
        guard let url = URL(string: "\(publicURL)") else { return }
        let shareShetVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(shareShetVC,animated: true)
    }
    
    private func setTypeView (_ type: String) {
        activityIndicator.startAnimating()
        switch type {
        case _ where type.contains("image"):
            self.imageView.isHidden = false
        case _ where type.contains("application/vnd"):
            self.webView.isHidden = false
        case _ where type.contains("application/pdf"):
            self.pdfView.isHidden = false
        default:
            self.label.isHidden = false
            break
        }
        downloadFileFoLine()
    }
    
    private func downloadFileFoLine () {
        serviceAPI.fetchURLFile(model?.path ?? "disk:/") { result in
            switch result {
            case .success(let response):
                self.urlDownloadFile = response.href ?? ""
                self.downloadFilePhone()
            case .failure(let error):
                self.webViewInte(self.model?.mime_type ?? "Error")
                self.showAlertErrorNoInternet()
                print("Error loading recommended podcasts: \(error.localizedDescription)")
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func downloadFilePhone () {
        let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationFileUrl = documentsUrl.appendingPathComponent(model?.name ?? "file")
        
        guard let fileURL = URL(string: urlDownloadFile) else { return }
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:fileURL)

        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
                do {
                    try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
                    DispatchQueue.main.async {
                        self.webViewInte(self.model?.mime_type ?? "Error")
                    }
                } catch (let writeError) {
                    DispatchQueue.main.async {
                        self.webViewInte(self.model?.mime_type ?? "Error")
                    }
                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
                }
            } else {
                self.activityIndicator.stopAnimating()
                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription as Any)
            }
        }
        task.resume()
    }
    
    func getImageFoImageView(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent(named).path)
        }
        return nil
    }
    
    func webViewInte (_ type: String) {
        switch type {
        case _ where type.contains("image"):
            DispatchQueue.main.async {
                if let image = self.getImageFoImageView(named: self.model?.name ?? "file") {
                    self.imageView.image = image
                }
                self.activityIndicator.stopAnimating()
            }
        case _ where type.contains("application/vnd"):
            DispatchQueue.main.async {
                let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let destinationFileUrl = documentsUrl.appendingPathComponent(self.model?.name ?? "file")
                
                self.webView.load(URLRequest(url: destinationFileUrl))
                self.activityIndicator.stopAnimating()
            }
        case _ where type.contains("application/pdf"):
            DispatchQueue.main.async {
                let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let destinationFileUrl = documentsUrl.appendingPathComponent(self.model?.name ?? "file")
                if let pdfDocument = PDFDocument(url: destinationFileUrl) {
                    self.pdfView.document = pdfDocument
                }
                self.activityIndicator.stopAnimating()
            }
        default:
            self.showAlertErrorNoInternet()
            self.activityIndicator.stopAnimating()
            break
        }
    }
    
    private func updateData (_ path: String) {
        self.activityIndicator.startAnimating()
        serviceAPI.fetchPresenter(path) { result in
            switch result {
            case .success(let response):
                self.filesData = response
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                self.showAlertErrorNoInternet()
                print("Error loading recommended podcasts: \(error.localizedDescription)")
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
// MARK: - Extension
extension PreviewViewController : EditViewControllerDelegate {
    func transmissionFile(file: Items?) {
        self.model = file
        self.labelNameFile.text = self.model?.name
        self.labelDateFile.text = self.model?.created?.dateFormater()
        setTypeView(file?.mime_type ?? "Error")
    }
}


