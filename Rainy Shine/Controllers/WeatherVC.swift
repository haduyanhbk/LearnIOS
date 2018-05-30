//
//  WeatherVC.swift
//  Rainy Shine
//
//  Created by anhhd on 5/21/18.
//  Copyright © 2018 anhhd. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager() //bat dau va ket thuc phan phoi cac su kien
    var currentLocation: CLLocation! //thong tin vi do, kinh do duoc khai bao
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //do chinh xac cua vi tri
        locationManager.requestWhenInUseAuthorization() //yeu cau quyen su dung dich vu dinh vi
        locationManager.startMonitoringSignificantLocationChanges() //tao ra cac ban cap nhat khi co su thay doi ve vi tri
        
        tableView.dataSource = self
        tableView.delegate = self
        
        currentWeather = CurrentWeather()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse { //tra ve gia tri cho biet ung dung co duoc phep ghi du lieu cam bien ko
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude //kinh do
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude //vi do
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI() //sau khi co du lieu cua cac ngay tiep theo thi cap nhat UI
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization() //yeu cau quyen su dung
            locationAuthStatus()
        }
    }
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //downloading forecast weather data for tableview
        Alamofire.request(FORECAST_URL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj) //khai bao bien du bao
                        self.forecasts.append(forecast) //them vao list
                    }
                    self.tableView.reloadData() //goi doi tuong reload
                }
            }
            completed ()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? TableViewCell {
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return TableViewCell()
            }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func updateMainUI () {
        //label cac truong gan vao du lieu da down o trong lop currentWeather
        dateLabel.text = currentWeather.date
        currentTempLabel.text = "\(currentWeather.currentTemp)"
        currentWeatherTypeLabel.text = currentWeather.weatherType
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }
}
