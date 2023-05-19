//
//  NetworkServiceAA.swift
//  WeatherReport
//
//  Created by Лаборатория on 19.05.2023.
//

import Foundation

class NetworkServiceAA {

    static let shared = NetworkServiceAA()

    private init() { }

    func getWeatherData(city: String) async throws -> WeatherData {
        guard let url = URLManager.shared.createURL(city: city,
                                                    endpoint: .currentWeather) else { throw NetworkError.badUrl }
        print(url)
        let response = try await URLSession.shared.data(from: url)
        let data = response.0

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            return weatherData
        } catch {
            throw NetworkError.invalidDecoding
        }
    }

}




