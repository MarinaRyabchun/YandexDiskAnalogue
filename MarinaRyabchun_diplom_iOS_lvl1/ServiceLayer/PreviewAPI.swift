//
//  PreviewAPI.swift
//  MarinaRyabchun_diplom_iOS_lvl1
//
//  Created by Марина Рябчун on 14.04.2023.
//

import UIKit

class PreviewAPI: ServiceProtocol {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchPresenter(_ path: String?, completion: @escaping (Result<ResponsePresenter, APIError>) -> Void ) {
        let token = UserDefaults.standard.string(forKey: "token")
        var components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk/resources")
        components?.queryItems = [
            URLQueryItem(name: "path", value: path)
        ]
        let url = components?.url
        var request = URLRequest(url: url!)
        request.setValue("OAuth \(token ?? "")", forHTTPHeaderField: "Authorization")
        print("<<< MARK: 2.1.0 URL - \(String(describing: url))")

        perform(request: request, completion: parseDecodable(completion: completion))
    }
    
    func fetchURLFile(_ path: String, completion: @escaping (Result<Response, APIError>) -> Void ) {
        let token = UserDefaults.standard.string(forKey: "token")
        var components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk/resources/download")
        components?.queryItems = [
            URLQueryItem(name: "path", value: path)
        ]
        let url = components?.url
        var request = URLRequest(url: url!)
        request.setValue("OAuth \(token ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        print("<<< MARK: 2.1.1 URL - \(String(describing: url))")

        perform(request: request, completion: parseDecodable(completion: completion))
    }
    
    func fetchLine(_ path: String, completion: @escaping (Result<Response, APIError>) -> Void ) {
        let token = UserDefaults.standard.string(forKey: "token")
        var components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk/resources/publish")
        components?.queryItems = [
            URLQueryItem(name: "path", value: path)
        ]
        let url = components?.url
        var request = URLRequest(url: url!)
        request.setValue("OAuth \(token ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        print("<<< MARK: 2.1.2 URL - \(String(describing: url))")

        perform(request: request, completion: parseDecodable(completion: completion))
    }
    
    func fetchDelite(_ path: String, completion: @escaping (Result<Response, APIError>) -> Void ) {
        let token = UserDefaults.standard.string(forKey: "token")
        var components = URLComponents(string: "https://cloud-api.yandex.net/v1/disk/resources")
        components?.queryItems = [
            URLQueryItem(name: "path", value: path),
            URLQueryItem(name: "permanently", value: "false")
        ]
        let url = components?.url
        var request = URLRequest(url: url!)
        request.setValue("OAuth \(token ?? "")", forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"
        print("<<< MARK: 2.1.3 URL - \(String(describing: url))")

        perform(request: request, completion: parseDecodable(completion: completion))
    }
}

extension PreviewAPI {
    struct Response: Decodable {
        let href : String?
        let method : String?
        let templated : Bool?
    }
}

