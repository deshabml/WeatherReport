//
//  URLManager.swift
//  WeatherReport
//
//  Created by Лаборатория on 19.05.2023.
//

import Foundation

enum Endpoint: String {
    case currentWeather = "/data/2.5/weather"
}

class URLManager {

    static let shared = URLManager()

    private init() {}

    private let apiKey = "b9c81050cef9855eeaca27cf97ae5d26"
    private let gateway = "https://"
    private let server = "api.openweathermap.org"

    func createURL(city: String, endpoint: Endpoint) -> URL? {
        var str = gateway + server + endpoint.rawValue
        str += "?appid=\(apiKey)&q=\(city)"
        let url = URL(string: str)
        return url
    }

}
