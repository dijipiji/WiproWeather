//
//  Model.swift
//  WeatherApp
//
//  Created by Jamie Lemon on 01/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit
import CoreData

typealias DataItem = (date:String?, kelvin:CGFloat?, weather:(type:String, description:String)?)

class Model: NSObject {
    
    /**
     *
     */
    func parseJSONData(_ data:Data) -> [DataItem]? {
        do {
            let json:Any? = try JSONSerialization.jsonObject(with: data, options:[]) as Any?
            
            if json != nil {
                let resultData:[String:Any] = json! as! [String:Any]
                
                let list:[Any?] = resultData["list"] as! [Any?]

                let items:[DataItem]? = list.map { (item) -> DataItem in
                    
                    let itemUnwrapped:[String:Any] = item! as! [String:Any]
                    let timeStamp:String? = itemUnwrapped["dt_txt"] as! String?
                    let mainData:[String:Any] = itemUnwrapped["main"] as! [String:Any]
                    let weatherArr:[Any?] = itemUnwrapped["weather"] as! [Any?]
                    
                    let weatherData:[String:Any] = weatherArr[0] as! [String:Any]
                    /*
                    print("timeStamp=\(timeStamp)")
                    print("mainData=\(mainData)")
                    print("weatherData=\(weatherData)")
                    */
                    let kelvin:CGFloat? = mainData["temp"] as? CGFloat

                    return DataItem(date:timeStamp,
                                    kelvin:kelvin,
                                    weather:(type:weatherData["main"], weatherData["description"]) as! (type: String, description: String))
                }
                
                return items
                
            }
        }
        catch let error {
            print("Model.parseJSONData error: \(error.localizedDescription)")
            return nil
        }
        
        return nil
    }

    
    /**
     *
     */
    func fetchDateFromString(YYYY_MM_DD:String?) -> Date {
        
        guard let dateStr:String = YYYY_MM_DD else {
            return Date()
        }
        
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //dateFormatter.timeZone = TimeZone(identifier:"GMT")
        
        return dateFormatter.date(from: dateStr) ?? Date()
    }
    
    


 
}
