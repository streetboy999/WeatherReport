//
//  ViewController.swift
//  WeatherReport
//
//  Created by Justin Wu on 6/30/15.
//  Copyright (c) 2015 Justin Wu. All rights reserved.
//

import UIKit
//import SwiftyJSON

struct Weather{
    var city:String?
    var weather:String?
    var temperature:String?
}

class ViewController: UIViewController {

    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelWeather: UILabel!
    @IBOutlet weak var labelTemperature: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getWeather()
    }
    
    var weatherData:Weather?{
        didSet {
            configureView()
        }
    }
    
    func configureView(){
        labelCity.text = self.weatherData?.city
        labelWeather.text = self.weatherData?.weather
        labelTemperature.text = self.weatherData?.temperature
        
    }
    
    func getWeather() {
        let realurl:String = "http://op.juhe.cn/onebox/weather/query?cityname=温州&key=08bdd27d98004584027382fba03b9147"
        let url = NSURL(string: realurl.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        config.timeoutIntervalForRequest = 10
        let session = NSURLSession(configuration: config)
        println(url!)
        
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, _, error) -> Void in
            
            println("Start")
            if error == nil {
                //Initialize JSON
                let json = JSON(data:data)
                
                //Extract JSON Data. All value getting from JSON is a JSON object
                let output:JSON = json["result"]["data"]["weather"][3]["info"]["day"][1]
                
                //Convert JSON object to String
                let temp:String = output.stringValue
                
                //Initilize struct
                var weather = Weather(city:"Beijing",weather:"Windy",temperature:"\(temp)")
                
                self.weatherData = weather
                println(weather.temperature!)

                
            } else{
                println("Error")
            }
        })
        
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

