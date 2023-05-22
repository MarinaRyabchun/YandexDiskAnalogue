//
//  ProfileAPI.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 12.04.2023.
//

import UIKit

class ProfileAPI: ServiceProtocol {
    
    var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchSizeDisk(completion: @escaping (Result<ProfileModel, APIError>) -> Void ) {
        let token = UserDefaults.standard.string(forKey: "token")
        let components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk")
        let url = components?.url
        var request = URLRequest(url: url!)
        request.setValue("OAuth \(token ?? "")", forHTTPHeaderField: "Authorization")
        print("<<< MARK: 1.0 URL - \(String(describing: url))")

        perform(request: request, completion: parseDecodable(completion: completion))
    }
}
