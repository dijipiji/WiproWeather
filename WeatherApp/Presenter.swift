//
//  Presenter.swift
//  WeatherApp
//
//  Created by Jamie Lemon on 01/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class Presenter: NSObject {
    
    let model:Model = Model()
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

    /**
     *
     */
    func parseSearch(_ data:Data?, _ error:Error?) -> [DataItem]? {
        
        guard let data:Data = data else {
            return nil
        }
        
        if data.count == 0 || error != nil {
            
            DispatchQueue.main.async {
                self.searchComplete()
            }
            
            return nil
        }
        
        let items:[DataItem]? = model.parseJSONData(data)
        
        DispatchQueue.main.async {
            self.searchComplete(items)
        }
        
        return items
        
    }
    
    /**
     *
     */
    func searchComplete(_ items:[DataItem]? = nil) {
        
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
