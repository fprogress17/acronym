//
//  acronymTests.swift
//  acronymTests
//
//  Created by Choonghun Lee on 1/27/23.
//

import XCTest
@testable import acronym

final class acronymTests: XCTestCase {
    
    let acronymViewModel = AcronymViewModel(apiService: ApiService())
    var acronymResult: [LFSData] = []
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let apiService = ApiService()
        let exp = expectation(description: "Loading")
        
       
        apiService.fetchAcronym(with: "tt") { [weak self] result in
            exp.fulfill()
            
            switch result {
               case .success(let res):
                    guard let sfData = res.first else { return }
                    self?.acronymResult = sfData.lfs
               case .failure(let error):
                   print(error.localizedDescription)
               }
           
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertNotEqual(acronymResult.count, 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
