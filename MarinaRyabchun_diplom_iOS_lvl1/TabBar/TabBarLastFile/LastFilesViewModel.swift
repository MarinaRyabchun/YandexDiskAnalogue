//
//  LastFilesViewModel.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 04.01.2023.
//

import Foundation

protocol LastFilesViewControllerProtocol: AnyObject {
    var cellIdentifier: String { get set }
    var viewModel: LastFilesViewModelProtocol { get set }
}

protocol LastFilesViewModelProtocol: AnyObject {
    var delegate: LastFilesViewControllerProtocol? { get set }
    func openPreviewFile(_ model: Items)
    var modelClass: LastFilesClass { get set }
    var serviceAPI: LastFilesAPI { get set }
}

final class LastFilesViewModel: LastFilesViewModelProtocol {
    
    var modelClass = LastFilesClass()
    var serviceAPI = LastFilesAPI()
    
    weak var delegate: LastFilesViewControllerProtocol?
    typealias Routes = PreviewFileRoute
    private let router: Routes

    init(router: Routes) {
        self.router = router
    }
    
    func openPreviewFile(_ model: Items) {
        router.openPreviewFile(model)
    }
}
