//
//  TableViewDefaulf.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 12.04.2023.
//

import UIKit

public class TableViewControllerDefault: UIViewController, UIScrollViewDelegate {
    
    var limit: Int = 20
    var isMoreDataLoading = false
    // MARK: - Properties
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.color = .gray
        return view
    }()
    
    let refreshControl = UIRefreshControl()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.backgroundColor = .white
        view.rowHeight = 60
        view.addSubview(refreshControl)
        view.separatorStyle = .none
        return view
    }()
    
    // MARK: - View Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.Colors.white
        self.navigationController?.navigationBar.barTintColor = Constants.Colors.white
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        setupSubViews()
        setupConstraints()
    }
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateData()
    }
    // MARK: - View Methods
    private func setupSubViews() {
        self.view.addSubview(tableView)
        self.view.addSubview(activityIndicator)
    }
    
    private func setupConstraints() {
        let margins = view.safeAreaLayoutGuide
        tableView.snp.makeConstraints { make in
            make.size.equalTo(margins)
            make.top.equalTo(margins.snp.top)
            make.leading.equalTo(margins.snp.leading)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
    
    @objc
    func refresh(_ sender: AnyObject) {
        updateData()
        refreshControl.endRefreshing()
    }
    
    @objc
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                limit += 20
                updateData()
                print("Update TableView")
            }
        }
    }
    
    func updateData () {
    }
}

