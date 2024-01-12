//
//  RebrickableAPIClient.swift
//  Bricks Collection Center
//
//  Created by Michał Gorzkowski on 09/01/2024.
//

import Foundation

class RebrickableAPIClient {
    private let apiKey = "key 2fa9d78c72103c031a69a07c90511560"
    let baseUrl = "https://rebrickable.com/api/v3/lego/"
    
    func searchLegoSetsByName(searchText: String, completion: @escaping (Result<LegoSetList, Error>) -> Void) {
        guard var components = URLComponents(string: "https://rebrickable.com/api/v3/lego/sets/") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        components.queryItems = [URLQueryItem(name: "search", value: searchText)]
        
        guard let url = components.url else {
                    completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                    return
                }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown error", code: 0, userInfo: nil)))
                return
            }

            do {
                let legoSetList = try JSONDecoder().decode(LegoSetList.self, from: data)
                completion(.success(legoSetList))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
    
    func searchLegoSetBySetNum(setNum: String, completion: @escaping (Result<LegoSet, Error>) -> Void) {
        let baseURL = "https://rebrickable.com/api/v3/lego/sets/"
        let setURL = baseURL + setNum + "/"

        guard let url = URL(string: setURL) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown error", code: 0, userInfo: nil)))
                return
            }

            do {
                let legoSet = try JSONDecoder().decode(LegoSet.self, from: data)
                completion(.success(legoSet))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
