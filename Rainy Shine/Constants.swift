//
//  Constants.swift
//  Rainy Shine
//
//  Created by macos on 5/21/18.
//  Copyright © 2018 macos. All rights reserved.
//

import Foundation
let BASE_URL = "http://samples.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let APP_KEY = "b1b15e88fa797225412429c1c50c122a1"

typealias DownloadComplete = () -> ()
let CURRENT_WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=ded9d8c120162b1ea4bf5b6eae5c74c0"
let FORECAST_URL = "https://api.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&appid=ded9d8c120162b1ea4bf5b6eae5c74c0"
