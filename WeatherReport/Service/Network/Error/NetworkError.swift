//
//  NetworkError.swift
//  WeatherReport
//
//  Created by Лаборатория on 19.05.2023.
//

import Foundation

enum NetworkError: Error {

    case badUrl
    case badResponse
    case invalidDecoding

}
