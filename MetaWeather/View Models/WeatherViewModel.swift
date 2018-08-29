//
//  WeatherViewModel.swift
//  MetaWeather
//
//  Created by Admin on 8/27/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

final class WeatherCellViewModel: NSObject{
    
    var weatherResult: Weather
    var consolidatedWeather: ConsolidatedWeather
    
    init(weatherResult weather: Weather){
        self.weatherResult = weather
        self.consolidatedWeather = weather.consolidatedWeather[1]
    }
    
    func weatherLabelText() -> String{
        return consolidatedWeather.weatherStateName
    }
    
    func lowLabelText() -> String{
        return "Low:  " + String(Int(consolidatedWeather.minTemp)) + " ºC"
    }
    
    func highLabelText() -> String{
        return "High: " + String(Int(consolidatedWeather.maxTemp)) + " ºC"
    }
    
    func locationLabelText() -> String{
        return weatherResult.title
    }
    
    func dateLabelText() -> String{
        return dateToString(dateString: consolidatedWeather.applicableDate)
    }
    
    func humidityLabelText() -> String{
        return "Humidity: " + String(consolidatedWeather.humidity)
    }
    
    func weatherImageURL() -> String?{
        return "https://www.metaweather.com/static/img/weather/png/64/\(consolidatedWeather.weatherStateAbbr).png"
    }
    
    private func dateToString(dateString: String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = dateFormatter.date(from: dateString) else {
            return dateString
        }
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
    }
    
}

protocol WeatherDelegate: class{
    func updateTable()
}

final class WeatherViewModel: NSObject{
    
    var weatherModels = [WeatherCellViewModel]()
    
    weak var delegate: WeatherDelegate?
    
    private let gothenburgId = "890869"
    
    private let stockholmId = "906057"
    
    private let londonId = "44418"
    
    private let newYorkId = "2459115"
    
    private let berlinId = "638242"
    
    private let mountainViewId = "2455920"
    
    private let idArray = ["2455920", "638242","2459115", "44418","906057","890869"]
    
    override init(){
        super.init()
    }
    
    func setWeather(){
        self.weatherModels.removeAll()
        for places in idArray{
            NetworkService.shared.getWeather(locationId: places) { weather, error in
                if let weatherResponse = weather {
                    let cellViewModel = WeatherCellViewModel(weatherResult: weatherResponse)
                    self.weatherModels.append(cellViewModel)
                    self.delegate?.updateTable()
                }
                /*
                 else if let responseError = error {
                 // Handle error
                 }
                 */
            }
        }
    }
    
}


