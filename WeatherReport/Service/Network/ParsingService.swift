//
//  ParsingService.swift
//  WeatherReport
//
//  Created by Лаборатория on 21.05.2023.
//

import Foundation
import SwiftyJSON

class ParsingService {

    static let shared = ParsingService()

    private init() { }

    func users(from data: Data) -> [String]? {
        guard let json = try? JSON(data: data) else { return nil }
        var citys: [String] = []
        let jsons = json["suggestions"]
        for index in 0 ..< jsons.count {
            let city = jsons[index]["data"]["city"].stringValue
            if city.count > 0 {
                citys.append(city)
            }
        }
        return Array(Set(citys))
    }

}
