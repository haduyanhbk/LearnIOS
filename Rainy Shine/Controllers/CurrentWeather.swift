//
//  CurrentWeather.swift
//  Rainy Shine
//
//  Created by macos on 5/21/18.
//  Copyright © 2018 macos. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
//    khai báo các biến trong stackView
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Double!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        //dinh dang chuyen doi giua cac ngay
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    var currentTemp: Double { //luu y kieu du lieu cua bien
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    func downloadWeatherDetails(completed: @escaping DownloadComplete) { //download du lieu chi tiet tu API duoc goi trong ham DownloadComplete
        //Alamofire download
        print(CURRENT_WEATHER_URL)
        print(self ._weatherType)
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)!
        Alamofire.request(currentWeatherURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String { //chap nhan nil
                    self._cityName = name.capitalized //bieu dien viet hoa
                    print(self._cityName)
                }

                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main.capitalized
                        print(self._weatherType)
                    }
                }

                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    if let currentTemperature = main["temp"] as? Double {
                        let kelvinToFarenheitPrevision = (currentTemperature * (9/5) - 459.67)
                        let kelvinToFarenheit = Double(round(10 * kelvinToFarenheitPrevision/(10)))
                        self._currentTemp = kelvinToFarenheit
                        print(self._currentTemp)
                    }
                }
            }
            completed()
        }
        
    }
    
}
