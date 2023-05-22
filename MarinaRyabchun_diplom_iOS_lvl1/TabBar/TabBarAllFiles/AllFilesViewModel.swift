//
//  ArchiveViewModel.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 04.01.2023.
//

import Foundation

protocol AllFilesViewControllerProtocol: AnyObject {
    var path: String? { get set }
    var cellIdentifier: String { get set }
    var viewModel: AllFilesViewModelProtocol { get set }
}

protocol AllFilesViewModelProtocol: AnyObject {
    var delegate: AllFilesViewControllerProtocol? { get set }
    func openFilesDir(_ path: String?,_ title: String?)
    func openPreviewFile(_ model: Items)
}

final class AllFilesViewModel: AllFilesViewModelProtocol {
    
    weak var delegate: AllFilesViewControllerProtocol?
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
