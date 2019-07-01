//
//  ViewController.swift
//  WeatherApp
//
//  Created by Jamie Lemon on 01/07/2019.
//  Copyright © 2019 dijipiji. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activitySpinner:UIActivityIndicatorView?
    let presenter:Presenter = Presenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachVC(self)
        
        presenter.performSearch(callback:{ (data, error) -> Void in
            _ = self.presenter.parseSearch(data,error)
        })
    }


}


/**
 *
 */
extension ViewController: ResultsView {
    
    // MARK: - Protocol methods
    /**
     *
     */
    func startLoading() {
        activitySpinner?.startAnimating()
    }
    
    /**
     *
     */
    func finishLoading() {
        activitySpinner?.stopAnimating()
        activitySpinner?.removeFromSuperview()
    }
    
    /**
     *
     */
    func renderNoResult() {
        let lbl:UILabel = UILabel(frame: CGRect(x:0,y:0,
                                                width:self.view.frame.size.width,
                                                height:self.view.frame.size.height))
        
        lbl.textColor = .white
        lbl.text = "There are no results available"
        lbl.textAlignment = .center
        self.view.addSubview(lbl)
    }
    
    /**
     *
     */
    func renderResult(_ dataItems:[DataItem]?) {
        
        guard let items:[DataItem] = dataItems else {
            renderNoResult()
            return
        }
        
        for item:DataItem in items {
            
            let date:Date = presenter.model.fetchDateFromString(YYYY_MM_DD: item.date!)
            let prettifiedDate:PrettifiedDate = presenter.model.getPrettifiedDate(date)
            
            
            print("--->prettifiedDate=\(prettifiedDate)")
        }
        
    }
    
}

