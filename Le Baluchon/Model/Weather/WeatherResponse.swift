// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let recipeService = try? newJSONDecoder().decode(RecipeService.self, from: jsonData)

import Foundation

// MARK: - WeatherResponse
struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: Main
}

// MARK: - Main
struct Main: Decodable {
    let temp : Double

    enum CodingKeys: String, CodingKey {
        case temp
    }
}

// MARK: - Weather
struct Weather: Decodable {
    let weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case icon
    }
}
