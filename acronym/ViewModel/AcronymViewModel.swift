//
//  AcronymViewModel.swift
//  acronym
//
//  Created by Choonghun Lee on 1/26/23.
//

import Foundation
import Combine

protocol AcronymViewModelProtocol {
    var apiService: ApiServiceProtocol? { get set }
}

public class AcronymViewModel: AcronymViewModelProtocol {
    var apiService: ApiServiceProtocol?
    let cellId = "DisplayCell"
    static let tableEstimatedRowHeight: CGFloat = 82
    
    
    @Published var acronymResult: [LFSData] = []
    
    init(apiService: ApiService?) {
        self.apiService = apiService
    }
   
    func fetchData(target: String) {
        guard let apiService = self.apiService else { print("no service error"); return }
        
        apiService.fetchAcronym(with: target) { [weak self] result in
            print(result)
            switch result {
               case .success(let res):
                    guard let sfData = res.first else { print("returned data error"); return }
                    self?.acronymResult = sfData.lfs
               case .failure(let error):
                   print(error.localizedDescription)
               }
            
         
            
        }
    }
}
