//
//  GetWeatherByLocation.swift
//  testtaskoctober
//
//  Created by shady on 10/2/18.
//  Copyright © 2018 XYZ. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class GetWeatherByLocation: UIViewController,CLLocationManagerDelegate {
    
    let  AppID : String = "f9f89e3f8df9497aef7f3556f912f872"
    
    let weatherURL:String = "https://api.openweathermap.org/data/2.5/weather"
   
    
    let weatherDataMode = WeatherDataModel()
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var getDegree: UILabel!
    
    @IBOutlet weak var cityName: UILabel!
  
    @IBOutlet weak var condition: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
   
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : AppID]
            
            getWeatherData(url: weatherURL, parameters: params)
        }
    }
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityName.text = "Location Unavailable"
    }
    
    
    
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                let weatherJSON : JSON = JSON(response.result.value!)
                
                print ("Success Connection")
                //print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
                
            }
            else {
                
                self.cityLabel.text = "Connection Issues"
                print ("Error:\(response.result.error)")
            }
        }
        
    }
    
    
    func updateWeatherData (json: JSON)
    {
        
        if  let tempResult = json["main"]["temp"].double {
            
            weatherDataMode.temprature = Int(tempResult - 273.15)
            
            weatherDataMode.city = json["name"].stringValue
            
            weatherDataMode.conition = json["weather"][0]["id"].intValue
            
            weatherDataMode.status = weatherDataMode.updateWeatherIcon(condition: weatherDataMode.conition)
            
            
            updateUIWeatherData()
            
            
        }
        
    }
    
    
    func updateUIWeatherData ()
    {
        
        cityName.text = weatherDataMode.city
        
        getDegree.text = String (weatherDataMode.temprature)
        
        condition.text = weatherDataMode.status
        
        
        
    }

    


}
