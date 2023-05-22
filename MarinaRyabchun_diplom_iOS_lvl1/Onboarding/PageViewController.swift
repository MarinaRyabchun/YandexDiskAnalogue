//
//  PageViewController.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 06.01.2023.
//

import UIKit
import SnapKit

protocol PageViewControllerProtocol: AnyObject {
    var viewModel: PageViewModelProtocol? {get set}
    var newUser: Bool {get set}
}

class PageViewController: UIPageViewController, PageViewControllerProtocol {
    // MARK: - Properties
    var viewModel: PageViewModelProtocol?
    var newUser = UserDefaults.standard.bool(forKey: "newUser")
    var page = [PageModel]()
    var pagesVC = [UIViewController]()
    
    let nextButton = UIButton()
    let pageControl = UIPageControl()
    let initialPage = 0
    // MARK: - Init
    init(viewModel: PageViewModelProtocol) {
        self.viewModel = viewModel
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        setupSubViews()
        setupConstraints()
    }
}

extension PageViewController {
    // MARK: - View Methods
    
    private func setup() {
        dataSource = self
        delegate = self
        
        let page1 = PageModel(imageName: Constants.Image.onboardingImage1,
                              title: Constants.Text.onboardingTitle1)
        let page2 = PageModel(imageName: Constants.Image.onboardingImage2,
                              title: Constants.Text.onboardingTitle2)
        let page3 = PageModel(imageName: Constants.Image.onboardingImage3,
                              title: Constants.Text.onboardingTitle3)
        page.append(page1)
        page.append(page2)
        page.append(page3)
        
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        for model in page {
            pagesVC.append(OnboardingViewController(model: model))
        }
        setViewControllers([pagesVC[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    private func style() {
        nextButton.setTitle(Constants.Text.nextButton, for: .normal)
        nextButton.setTitleColor(Constants.Colors.white, for: .normal)
        nextButton.titleLabel?.font = Constants.Fonts.buttonText
        nextButton.backgroundColor = Constants.Colors.accent1
        nextButton.layer.cornerRadius = 10
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
        
        pageControl.numberOfPages = pagesVC.count
        pageControl.currentPage = initialPage
        pageControl.currentPageIndicatorTintColor = Constants.Colors.accent1
        pageControl.pageIndicatorTintColor = Constants.Colors.iconsAndOtherDetails
    }
    private func setupSubViews() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
    }
    private func setupConstraints() {
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(183)
            make.centerX.equalTo(self.view)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(92)
            make.centerX.equalTo(self.view)
            make.width.equalTo(320)
            make.height.equalTo(50)
        }
    }
}

// MARK: - DataSource

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pagesVC.firstIndex(of: viewController) else { return nil }
        if currentIndex == 0 {
            return nil
        } else {
            return pagesVC[currentIndex - 1]
        }
    }
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pagesVC.firstIndex(of: viewController) else { return nil }
        if currentIndex < pagesVC.count - 1 {
            return pagesVC[currentIndex + 1]
        } else {
            return nil
        }
    }
    
}

// MARK: - Delegates

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pagesVC.firstIndex(of: viewControllers[0]) else { return }
        pageControl.currentPage = currentIndex
        animateControlsIfNeeded()
    }
    
    private func animateControlsIfNeeded() {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: - Actions

extension PageViewController {
    @objc
    func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pagesVC[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        animateControlsIfNeeded()
    }
    @objc
    func nextTapped(_ sender: UIButton) {
        if  pageControl.currentPage < pagesVC.count - 1 {
            pageControl.currentPage += 1
            goToNextPage()
            animateControlsIfNeeded()
        } else {
            UserDefaults.standard.set(false, forKey: "newUser")
            print(newUser)
            viewModel?.openLogin()
        }
    }
}

// MARK: - Extensions

extension UIPageViewController {
    
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        
        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
}

