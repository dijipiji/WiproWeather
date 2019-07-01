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
    
    let scrollView:UIScrollView = UIScrollView()

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
        
        guard var items:[DataItem] = dataItems else {
            renderNoResult()
            return
        }
        
        scrollView.frame = self.view.frame
        scrollView.backgroundColor = UIColor(hexString: "#222222")
        self.view.addSubview(scrollView)
        
        // render the first item large and the rest in a list
        let initialItem:DataItem = items.remove(at: 0)
        
        let titleLabel:UILabel = UILabel(frame: CGRect(x:0,y:30,
                                                       width:self.view.frame.size.width,
                                                       height:50))
        
        titleLabel.text = "EDINBURGH"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 30.0)
        scrollView.addSubview(titleLabel)
        
        let dateLabel:UILabel = UILabel(frame: CGRect(x:0,y:titleLabel.frame.origin.y + titleLabel.frame.size.height,
                                                      width:self.view.frame.size.width,
                                                      height:50))
        
        dateLabel.text = "\(initialItem.date!.weekday)"
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        dateLabel.font = .systemFont(ofSize: 30.0)
        scrollView.addSubview(dateLabel)
        
        let uimgv:UIImageView = UIImageView(frame:CGRect(x:(self.view.frame.size.width-80)/2,
                                                         y:dateLabel.frame.origin.y + dateLabel.frame.size.height,
                                                         width:80, height:80))
        uimgv.image = UIImage(named:initialItem.weather!.type.lowercased())
        scrollView.addSubview(uimgv)
        

        let temperatureLabel:UILabel = UILabel(frame: CGRect(x:0,
                                                             y:uimgv.frame.origin.y + uimgv.frame.size.height,
                                                             width:self.view.frame.size.width,
                                                             height:50))
        
        temperatureLabel.text = "\(initialItem.celsius!) °C"
        temperatureLabel.textColor = .white
        temperatureLabel.textAlignment = .center
        temperatureLabel.font = .systemFont(ofSize: 30.0)
        scrollView.addSubview(temperatureLabel)
        
        let descLabel:UILabel = UILabel(frame: CGRect(x:0,
                                                             y:temperatureLabel.frame.origin.y + temperatureLabel.frame.size.height,
                                                             width:self.view.frame.size.width,
                                                             height:50))
        
        descLabel.text = initialItem.weather!.description.uppercased()
        descLabel.textColor = .white
        descLabel.textAlignment = .center
        descLabel.font = .systemFont(ofSize: 24.0)
        scrollView.addSubview(descLabel)
        
        let splitter:UIView = UILabel(frame: CGRect(x:10,
                                                    y:descLabel.frame.origin.y + descLabel.frame.size.height,
                                                    width:self.view.frame.size.width-20,
                                                    height:1))
        
        splitter.backgroundColor = .white
        scrollView.addSubview(splitter)
        
        renderRemainingDays(xPos:splitter.frame.origin.x,
                            yPos:splitter.frame.origin.y + 10,
                            items:items)
        
        
    }
    
    /**
     *
     */
    func renderRemainingDays(xPos:CGFloat, yPos:CGFloat, items:[DataItem]) {
        
        let itemHeight:CGFloat = 70.0
        var yPos:CGFloat = yPos
        
        for item:DataItem in items {
            
            let dateLabel:UILabel = UILabel(frame: CGRect(x:xPos,y:yPos,
                                                          width:120,
                                                          height:itemHeight))
            
            dateLabel.text = "\(item.date!.weekday)"
            dateLabel.textColor = .white
            dateLabel.textAlignment = .left
            dateLabel.font = .systemFont(ofSize: 22.0)
            scrollView.addSubview(dateLabel)
            
            let temperatureLabel:UILabel = UILabel(frame: CGRect(x:self.view.frame.size.width-230,
                                                                 y:yPos,
                                                                 width:140,
                                                                 height:itemHeight))
            
            temperatureLabel.text = "\(item.celsius!) °C"
            temperatureLabel.textColor = .white
            temperatureLabel.textAlignment = .right
            temperatureLabel.font = .systemFont(ofSize: 22.0)
            scrollView.addSubview(temperatureLabel)
            
            
            let uimgv:UIImageView = UIImageView(frame:CGRect(x:(self.view.frame.size.width-itemHeight),
                                                             y:yPos+15,
                                                             width:itemHeight-30, height:itemHeight-30))
            uimgv.image = UIImage(named:item.weather!.type.lowercased())
            scrollView.addSubview(uimgv)

            yPos += itemHeight
            
        }
        
        scrollView.contentSize = CGSize(width:scrollView.frame.size.width, height:yPos+itemHeight)
        
    }
    
    /**
     *
     */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

