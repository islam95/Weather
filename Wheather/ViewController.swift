//
//  ViewController.swift
//  Wheather
//
//  Created by Islam on 27/07/2016.
//  Copyright © 2016 Islam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    @IBAction func findWeather(_ sender: AnyObject) {
        
        var isSuccessful = false
        
        let attemptedUrl = URL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest")
        
        if let url = attemptedUrl {
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)
                
                let websiteArray = webContent!.components(separatedBy: "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                
                if websiteArray.count > 1 {
                    
                    let weatherArray = websiteArray[1].components(separatedBy: "</span>")
                    
                    if weatherArray.count > 1 {
                        
                        isSuccessful = true
                        
                        let weatherSummary = weatherArray[0].replacingOccurrences(of: "&deg;", with: "º")
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.resultLabel.text = weatherSummary
                        })
                        
                    }
                }
                
                
            }
            
            if isSuccessful == false {
                
                self.resultLabel.text = "Please try again!"
            }
        }) 
        
        task.resume()
            
        } else {
            
            self.resultLabel.text = "Please try again!"

        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

