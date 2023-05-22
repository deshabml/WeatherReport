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
    @Published var statistics: [(min: Double, max: Double)] = []
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
            let statisticData = try await NetworkServiceAA.shared.getStatistics(weatherData: data)
            DispatchQueue.main.async {
                self.weatherData = data
                self.statistics = statisticData
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
        if city == "Saint-Petersburg" {
            self.city = "Petersburg"
        } else {
            self.city = city
        }
        DataService.shared.saveCity(self.city)
        getData()
    }

    func loadFirstSity() {
        if let first = DataService.shared.firstTime, !first {
            city = "moscow"
            saveCity(city: city)
            DataService.shared.firstTimeFalse(true)
        }
    }

    func minStatistic() -> Double {
        var min = statistics[0].min
        for index in 0 ..< statistics.count {
            if statistics[index].min < min {
                min = statistics[index].min
            }
        }
        return min
    }

    func maxStatistic() -> Double {
        var max = statistics[0].max
        for index in 0 ..< statistics.count {
            if statistics[index].max > max {
                max = statistics[index].max
            }
        }
        return max
    }

    func widthDeyTemp(index: Int) -> Double {
        let ratio = (maxStatistic() - minStatistic()) / (statistics[index].max - statistics[index].min)
        return 200 / ratio
    }

    func paddingTemp(index: Int) -> Double {
        let oneDegree = 200 / (maxStatistic() - minStatistic())
        return (statistics[index].min - minStatistic()) * oneDegree
    }

}
