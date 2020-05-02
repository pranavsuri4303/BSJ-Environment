//
//  AirVisualModel.swift
//  BSJ Environment
//
//  Created by Pranav  Suri on 1/5/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//
import Foundation
struct AirVisualModel {
    let cityName: String
	let stateName: String
	let countryName: String
    let temperature: Int
    let aqi: Int
    let mainaqi:String
	let weatherImage: String
	var airQualityImage: String {
        switch aqi {
		case 0...50:
            return "greenFace"
        case 51...100:
            return "yellowFace"
        case 101...150:
            return "orangeFace"
        case 151...200:
            return "redFace"
        case 201...300:
            return "purpleFace"
		case 300...1000:
            return "purpleFace"
        default:
            return "purpleFace"
        }
    }
	var airQualityDescription: String {
        switch aqi {
		case 0...50:
            return "Good"
        case 51...100:
            return "Moderate"
        case 101...150:
            return "Unhealthy for Sensitive Groups"
        case 151...200:
            return "Unhealthy"
        case 201...300:
            return "Very Unhealthy"
		case 300...1000:
            return "Hazardous"
        default:
            return "Moderate"
        }
    }
	var textColor: String {
        switch aqi {
		case 0...50:
            return "greenAQIText"
        case 51...100:
            return "yellowAQIText"
        case 101...150:
            return "orangeAQIText"
        case 151...200:
            return "redAQIText"
        case 201...300:
            return "purpleAQIText"
		case 300...1000:
            return "purpleAQIText"
        default:
            return "orangeAQIText"
        }
    }

}

