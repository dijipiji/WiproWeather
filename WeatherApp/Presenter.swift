//
//  Presenter.swift
//  WeatherApp
//
//  Created by Jamie Lemon on 01/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class Presenter: NSObject {
    
    var ownerVC:ResultsView?
    
    /**
     *
     */
    func performSearch(query:String = Service.baseURL,
                       callback:@escaping (Data?, Error?) -> Void) {
                
        ownerVC?.startLoading()
        
        _ = Service.getJSONData(query:query, callback: { (data, error) -> Void in
            callback(data, error)
        })
    }

}

/**
 *
 */
protocol ResultsView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func renderNoResult()
    func renderResult()
}
