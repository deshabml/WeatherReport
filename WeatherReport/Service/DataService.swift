//
//  DataService.swift
//  WeatherReport
//
//  Created by Лаборатория on 19.05.2023.
//

import Foundation

class DataService {

    static let shared = DataService()
    private let userDefaults = UserDefaults.standard
    let cityKey = "Contacts"
    let firstTimeKey = "FirstTime"
    
    var city: String? {
        let city = userDefaults.string(forKey: cityKey)
        return city
    }

    var firstTime: Bool? {
        let first = userDefaults.bool(forKey: firstTimeKey)
        return first
    }

    private init() { }

    func firstTimeFalse(_ firstTime: Bool) {
        userDefaults.set(firstTime, forKey: firstTimeKey)
    }

    func saveCity(_ city: String) {
        userDefaults.set(city, forKey: cityKey)
    }

}
