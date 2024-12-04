//
//  WeatherViewModel.swift
//  TS_Weather
//
//  Created by siyeon park on 12/4/24.
//

import Foundation

final class WeatherViewModel {
    private var weatherData: WeatherResponse?
    var updateData: (() -> Void)?
    
    func fetchWeather(lat: Double, lon: Double) {
        NetworkingManager.shared.fetchWeatherData(for: lat, lon: lon) { [weak self] result in
            switch result {
            case .success(let response):
                self?.weatherData = response
                print("Weather data updated: \(String(describing: self?.weatherData))")
                DispatchQueue.main.async {
                    self?.updateData?()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getLocationName() -> String {
        return weatherData?.name ?? ""
    }
    
    func getTemperature() -> String {
        if let temp = weatherData?.main?.temp {
            return "\(temp)"
        } else {
            return "데이터가 없습니다."
        }
    }
    
    func getMinTemperature() -> String {
        if let minTemp = weatherData?.main?.tempMin {
            return "최저기온: \(minTemp)°C"
        } else {
            return "데이터가 없습니다."
        }
    }
    
    func getMaxTemperature() -> String {
        if let maxTemp = weatherData?.main?.tempMax {
            return "최고기온: \(maxTemp)°C"
        } else {
            return "데이터가 없습니다."
        }
    }
    
    func getWeatherIcon() -> String {
        if let weatherImg = weatherData?.weather![0].icon {
            print("weatherImg \(weatherImg)")
            let iconString = "https://openweathermap.org/img/wn/\(weatherImg)@2x.png"
            return iconString
        } else {
            return "데이터가 없습니다."
        }
    }
}