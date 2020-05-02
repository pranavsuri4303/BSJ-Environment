//
//  AirVisualResponse.swift
//  BSJ Environment
//
//  Created by Pranav  Suri on 1/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import Foundation

/// The Decodable-conformant representation of AirVisual API's nearest_city endpoint response.
struct AirVisualResponse: Decodable {
    let data: data
}

/// The Decodable-conformant representation of the data property of AirVisualNearestCityResponse.
struct data: Decodable {
    let city: String
	let state: String
	let country: String
	let current: current
}

/// The Decodable-conformant representation of the currentConditions property of AirVisualNearestCityData.
struct current: Decodable {
    let weather: weather
    let pollution: pollution
}

/// The Decodable-conformant representation of the weather property of AirVisualCurrentConditions.
struct weather: Decodable {
    let image: String // weather icon code: ex. "10n"
    let temperature: Int // temperature: ex. 6 (Celsius)
}

/// The Decodable-conformant representation of the pollution property of AirVisualCurrentConditions.
struct pollution: Decodable {
    let aqiUS: Int // AQI value based on US EPA standard: ex. 4
    let mainPollutantUS: String // main pollutant for US AQI: ex. "o3"
}

// MARK: - CodingKeys
extension AirVisualResponse{
	enum CodingKeys: String, CodingKey{
		case data = "data"
	}
}
extension data {
    enum CodingKeys: String, CodingKey {
        case city = "city"
		case state = "state"
		case country = "country"
        case current = "current"
    }
}
extension current {
	enum CodingKeys: String, CodingKey {
		case weather = "weather"
		case pollution = "pollution"
	}
}


extension weather {
    enum CodingKeys: String, CodingKey {
        case image = "ic"
        case temperature = "tp"
    }
}

extension pollution {
    enum CodingKeys: String, CodingKey {
        case aqiUS = "aqius"
        case mainPollutantUS = "mainus"
    }
}

