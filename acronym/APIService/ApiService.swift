//
//  ApiService.swift
//  acronym
//
//  Created by Choonghun Lee on 1/27/23.
//

import Foundation

protocol ApiServiceProtocol {
    func fetchAcronym(with target:String, completionHandler: @escaping (Result<[SFData], Error>) -> Void)
}

public struct ApiService: ApiServiceProtocol {

    static let acronymApi = "http://www.nactem.ac.uk/software/acromine/dictionary.py"
    func fetchAcronym(with target:String, completionHandler: @escaping (Result<[SFData], Error>) -> Void) {
        let url = URL(string: ApiService.acronymApi)!
        
        var components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        )!
        
        components.queryItems = [
            URLQueryItem(name: "sf", value: target),
        ]
        
        guard let pUrl = components.url else { print("component error"); return }
        
        let task = URLSession.shared.dataTask(with: pUrl, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching acronym: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
              print("Error with the response, unexpected status code: \(String(describing: response))")
            return
          }
        
            guard let data = data else { print("data error"); return }
            do {
               let results = try JSONDecoder().decode([SFData].self, from: data)
                completionHandler(.success(results))
            }
            catch {
                print(error)
                completionHandler(.failure(error))
                    }
        })
        task.resume()
      }

}
