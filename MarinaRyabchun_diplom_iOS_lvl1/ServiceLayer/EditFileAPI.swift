//
//  EditFileAPI.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 14.04.2023.
//

import UIKit

class EditFileAPI: ServiceProtocol {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchEdit(from: String, path: String, completion: @escaping (Result<Response, APIError>) -> Void ) {
        let token = UserDefaults.standard.string(forKey: "token")
        var components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk/resources/move")
        components?.queryItems = [
            URLQueryItem(name: "from", value: from),
            URLQueryItem(name: "path", value: path),
        ]
        let url = components?.url
        var request = URLRequest(url: url!)
        request.setValue("OAuth \(token ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        print("<<< MARK: 2.2 URL - \(String(describing: url))")

        perform(request: request, completion: parseDecodable(completion: completion))
    }
    
}

extension EditFileAPI {
    struct Response: Decodable {
        let href : String?
        let method : String?
        let templated : Bool?
    }
}

