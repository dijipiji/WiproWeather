//
//  Service.swift
//  WeatherApp
//
//  Created by Jamie Lemon on 01/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//
import Foundation

class Service: NSObject {
    
    // note: 2650225 is the code for Edinburgh, UK
    static let baseURL:String = "https://samples.openweathermap.org/data/2.5/forecast?id=2650225&appid=d19263c4f36e6188c118bc0cc877fbed"
    
    /**
     *
     */
    static func getJSONData(query:String, callback: @escaping (Data?, Error?) -> Void) -> Bool {
        
        guard let myURL:URL = URL(string: query) else {
            return false
        }
        
        let config:URLSessionConfiguration = URLSessionConfiguration.default
        let session:URLSession = URLSession(configuration: config)
        
        session.dataTask(with: myURL) {
            (data, response, error) in
            callback(data, error)
            }.resume()
        
        return true
    }
    
}
