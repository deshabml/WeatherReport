//
//  WeatherViewModel.swift
//  WeatherReport
//
//  Created by Лаборатория on 19.05.2023.
//

import Foundation

class WeatherViewModel: ObservableObject {

    @Published var weatherData: WeatherData?
    @Published var city: String = ""

//    init() {
//        Task {
//            let data = try await NetworkServiceAA.shared.getWeatherData(city: "volgograd")
//            DispatchQueue.main.async {
//                self.weatherData = data
//            }
//        }
//    }

    func loadScreen() {
        Task {
            let data = try await NetworkServiceAA.shared.getWeatherData(city: "volgograd")
            DispatchQueue.main.async {
                self.weatherData = data
                self.setupCityText()
            }
        }
    }

    func setupCityText() {
        self.city = weatherData?.name ?? "-"
    }

    func tempDescription(_ temp: Double?) -> String {
        guard let temp else {
            return "-"
        }
        let res = "\(Int(temp - 273))°С"
        return res
    }


    func pressureDescr(_ pressure: Int?) -> String {
        guard let pressure else { return "-" }
        return "\(Int(Double(pressure) * 0.76)) мм.рт.ст"
    }

    func getDirection() -> String {
        let deg = Double(self.weatherData?.wind.deg ?? 0)
        switch deg {
            case 22.5 ... 67.5: return "СВ"
            case 67.5 ... 112.5: return "В"
            case 112.5 ... 157.5: return "ЮВ"
            case 157.5 ... 202.5: return "Ю"
            case 202.5 ... 247.5: return "ЮЗ"
            case 247.5 ... 292.5: return "З"
            case 292.5 ... 337.5: return "СЗ"
            default: return "С"
        }
    }

    func getTime(utc: Int?) -> String {
        guard let utc else { return "" }
        let date = Date(timeIntervalSince1970: TimeInterval(integerLiteral: Int64(utc)))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let str = formatter.string(from: date)
        return str
    }
    
}
