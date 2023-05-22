//
//  Onboarding.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 06.01.2023.
//
import UIKit
import SnapKit

protocol OnboardingViewProtocol: AnyObject {
}

final class OnboardingViewController: UIViewController {
    // MARK: - Properties
    
    public lazy var blockImage: UIImageView = {
        let image = UIImage(named: "default.png")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        return view
    }()
    private lazy var titleLable: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.header2
        label.textColor = Constants.Colors.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    init(model: PageModel) {
        super.init(nibName: nil, bundle: nil)
        
        blockImage.image = UIImage(named: model.imageName )
        titleLable.text = model.title
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
    }
    // MARK: - View Methods
    private func setupSubViews() {
        view.addSubview(blockImage)
        view.addSubview(titleLable)
    }
    private func setupConstraints() {
        blockImage.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).inset(271.05)
            make.centerX.equalTo(self.view)
            make.width.equalTo(195)
            make.height.equalTo(168)
        }
        titleLable.snp.makeConstraints { make in
            make.top.equalTo(blockImage.snp.bottom).inset(-62.37)
            make.centerX.equalTo(self.view)
            make.width.equalTo(243.9)
        }
    }
}

// MARK: - Extension
extension OnboardingViewController: OnboardingViewProtocol {}

