//
//  PublishedFilesViewModel.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 12.04.2023.
//

import Foundation

protocol PublishedFilesViewControllerProtocol: AnyObject {
    var path: String? { get set }
    var cellIdentifier: String { get set }
    var viewModel: PublishedFilesViewModelProtocol { get set }
}

protocol PublishedFilesViewModelProtocol: AnyObject {
    var delegate: PublishedFilesViewControllerProtocol? { get set }
    func openFilesDir(_ path: String?,_ title: String?)
    func openPreviewFile(_ model: Items)
}

final class PublishedFilesViewModel: PublishedFilesViewModelProtocol {
    
    weak var delegate: PublishedFilesViewControllerProtocol?
    typealias Routes = FilesDirRoute & PreviewFileRoute
    private let router: Routes

    init(router: Routes) {
        self.router = router
    }
    
    func openFilesDir(_ path: String?,_ title: String?) {
        router.openFilesDir(path, title)
    }
    
    func openPreviewFile(_ model: Items) {
        router.openPreviewFile(model)
    }
}
