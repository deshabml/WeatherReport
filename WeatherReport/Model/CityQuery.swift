//
//  CityQuery.swift
//  WeatherReport
//
//  Created by Лаборатория on 20.05.2023.
//

import Foundation

struct CityQuery: Encodable {

    let query: String
    let count: Int
    let language: String = "en"
    
}
