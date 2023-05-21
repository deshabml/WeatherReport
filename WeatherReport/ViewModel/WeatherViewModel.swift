//
//  WeatherViewModel.swift
//  WeatherReport
//
//  Created by Лаборатория on 19.05.2023.
//

import Foundation

class WeatherViewModel: ObservableObject {

    @Published var weatherData: WeatherData?
    @Published var city: String = "" {
        didSet {
            checkCity(text: city)
        }
    }
    @Published var isChoosingCity = false
    @Published var citys: [String] = []
    var isCityExists: Bool {
        citys.count > 0
    }

    func loadScreen() {
        loadFirstSity()
        setupCityText()
        getData()
    }

    func getData() {
        Task {
            let data = try await NetworkServiceAA.shared.getWeatherData(city: city)
            DispatchQueue.main.async {
                self.weatherData = data
            }
        }
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

extension WeatherViewModel {

    func setupCityText() {
        city = DataService.shared.city ?? "-"
    }

    func checkCity(text: String) {
        DataService.shared.saveCity(city)
        Task {
            do {
                let data = try await NetworkServiceAA.shared.checkCity(city: CityQuery(query: text, count: 5))
                DispatchQueue.main.async {
                    self.citys = data
                }
                print(data)
            } catch {
                print(error)
            }
        }
    }

    func saveCity(city: String) {
        self.city = city
        DataService.shared.saveCity(city)
        getData()
    }

    func loadFirstSity() {
        if let first = DataService.shared.firstTime, !first {
            city = "moscow"
            saveCity(city: city)
            DataService.shared.firstTimeFalse(true)
        }
    }

}
