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
            
                let json = JSON(data:data)
               // println(json)
                let output:JSON = json["result"]["data"]["weather"][3]["info"]["day"][1]
                let temp:String = output.stringValue
                var weather = Weather(city:"Beijing",weather:"Windy",temperature:"\(temp)")
                
                self.weatherData = weather
                println(weather.temperature!)
//                let json:AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
//                var jdata:AnyObject? = json?.objectForKey("result")
               // var jrealtime:AnyObject? = jdata?.objectForKey("isForeign")
               // var jrealtime:AnyObject? = jdata?.objectForKey("realtime")
              //  var jcityname:AnyObject? = json?.objectForKey("city_name")
      //          let weather:Weather?
                //weather?.city =
//                weather?.temperature = "abc"
//                weather?.weather = "efg"
//                self.weatherData = weather
               // println(jdata)
  //              println(jrealtime)
//                println(json)
//                println("test")
                
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

