//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Jamie Lemon on 01/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherAppTests: XCTestCase {
    
    let presenter:Presenter = Presenter()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /**
     * test passes if your Service baseURL is valid and returns results
     */
    func testService() {
        
        let expectation:XCTestExpectation = XCTestExpectation()
        
        presenter.performSearch(callback:{ (data, error) -> Void in
            
            if error != nil {
                XCTAssert(false, "There is an error, but with a valid URL there should be no error!")
            }
            
            expectation.fulfill()
            
            print("data=\(data)")
            
        })
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    
    func testParser() {
        
        let expectation:XCTestExpectation = XCTestExpectation()
        
        presenter.performSearch(callback:{ (data, error) -> Void in
            
            if error != nil {
                XCTAssert(false, "There is an error, but with a valid URL there should be no error!")
            }
            
            let items:[DataItem]? = self.presenter.parseSearch(data,error)
            
            guard let unwrappedItems:[DataItem] = items else {
                return
            }
        
            for item:DataItem in unwrappedItems {
                print("item.date=\(String(describing: item.date))")
                print("item.kelvin=\(String(describing: item.kelvin))")
                print("item.weather=\(String(describing: item.weather))")
            }
        
        
            XCTAssert(items != nil, "This search returned no data!")
            expectation.fulfill()
            
        })
        
        wait(for: [expectation], timeout: 10.0)
        
    }
    
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
