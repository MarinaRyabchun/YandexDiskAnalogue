//
//  AllFilesAPI.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 14.04.2023.
//

import UIKit

class AllFilesAPI: ServiceProtocol {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchFullDiskResponse(_ path: String?,_ limit: Int, completion: @escaping (Result<ResponsePresenter, APIError>) -> Void ) {
        let token = UserDefaults.standard.string(forKey: "token")
        var components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk/resources")
        components?.queryItems = [
            URLQueryItem(name: "path", value: path != nil ? path : "disk:/"),
            URLQueryItem(name: "limit", value: "\(limit)"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "preview_crop", value: "true"),
            URLQueryItem(name: "preview_size", value: "50x50"),
            URLQueryItem(name: "sort", value: "-created")
        ]
        let url = components?.url
        var request = URLRequest(url: url!)
        request.setValue("OAuth \(token ?? "")", forHTTPHeaderField: "Authorization")
        print("<<< MARK: 3.0 URL - \(String(describing: url))")

        perform(request: request, completion: parseDecodable(completion: completion))
    }
}
