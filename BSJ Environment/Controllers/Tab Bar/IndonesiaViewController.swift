//
//  IndonesiaViewController.swift
//  BSJ Environment
//
//  Created by Pranav  Suri on 16/4/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import Foundation
import UIKit

class IndonesiaViewController: UIViewController, AirVisualManagerDelegate {

	var airVisualManager = AirVisualManager()

	// Jakarta Outlets
	@IBOutlet weak var jakartaContainer: UIView!
	@IBOutlet weak var jakartaName: UILabel!
	@IBOutlet weak var jakartaTemp: UILabel!
	@IBOutlet weak var jakartaWeatherImage: UIImageView!
	@IBOutlet weak var jakartaSeperator: UIView!
	@IBOutlet weak var jakartaAQI: UILabel!
	@IBOutlet weak var jakartaUSAQI: UILabel!
	@IBOutlet weak var jakartaImage: UIImageView!
	@IBOutlet weak var jakartaDescription: UILabel!
	// South Tangerang outlets
	@IBOutlet weak var tangerangContainer: UIView!
	@IBOutlet weak var tangerangName: UILabel!
	@IBOutlet weak var tangerangTemp: UILabel!
	@IBOutlet weak var tangerangWeatherImage: UIImageView!
	@IBOutlet weak var tangerangSeperator: UIView!
	@IBOutlet weak var tangerangAQI: UILabel!
	@IBOutlet weak var tangerangUSAQI: UILabel!
	@IBOutlet weak var tangerangImage: UIImageView!
	@IBOutlet weak var tangerangDescription: UILabel!
	// Kuta Outlets
	@IBOutlet weak var kutaContainer: UIView!
	@IBOutlet weak var kutaName: UILabel!
	@IBOutlet weak var kutaTemp: UILabel!
	@IBOutlet weak var kutaWeatherImage: UIImageView!
	@IBOutlet weak var kutaSeperator: UIView!
	@IBOutlet weak var kutaAQI: UILabel!
	@IBOutlet weak var kutaUSAQI: UILabel!
	@IBOutlet weak var kutaImage: UIImageView!
	@IBOutlet weak var kutaDescription: UILabel!
	// Ubud Outlets
	@IBOutlet weak var ubudContainer: UIView!
	@IBOutlet weak var ubudName: UILabel!
	@IBOutlet weak var ubudTemp: UILabel!
	@IBOutlet weak var ubudWeatherImage: UIImageView!
	@IBOutlet weak var ubudSeperator: UIView!
	@IBOutlet weak var ubudAQI: UILabel!
	@IBOutlet weak var ubudUSAQI: UILabel!
	@IBOutlet weak var ubudImage: UIImageView!
	@IBOutlet weak var ubudDescription: UILabel!


	override func viewDidLoad() {
		super.viewDidLoad()
		airVisualManager.delegate = self


		// Making containers rounded
		jakartaContainer.layer.cornerRadius = 10
		tangerangContainer.layer.cornerRadius = 10
		kutaContainer.layer.cornerRadius = 10
		ubudContainer.layer.cornerRadius = 10

		// Hiding the containers
		jakartaContainer.isHidden = true
		tangerangContainer.isHidden = true
		ubudContainer.isHidden = true
		kutaContainer.isHidden = true

	}




	override func viewDidAppear(_ animated: Bool) {
		DispatchQueue.main.async { // Correct
			self.airVisualManager.fetchWeather(cityName: "Jakarta", stateName: "Jakarta")
			self.airVisualManager.fetchWeather(cityName: "Kuta", stateName: "Bali")
			self.airVisualManager.fetchWeather(cityName: "Ubud", stateName: "Bali")
			self.airVisualManager.fetchWeather(cityName: "South%20Tangerang", stateName: "Banten")
		}

		
	}

	func didUpdatePollution(pollution: AirVisualModel) {
		DispatchQueue.main.async { // Correct
			switch pollution.cityName{
			case "Jakarta":
				self.displayFinal(pollution: pollution, cityName: self.jakartaName, container: self.jakartaContainer, temperature: self.jakartaTemp, aqi: self.jakartaAQI, aqiImage: self.jakartaImage, weatherImage: self.jakartaWeatherImage, description: self.jakartaDescription, seperator: self.jakartaSeperator, mainAQI: self.jakartaUSAQI)
			case "Kuta":
				self.displayFinal(pollution: pollution, cityName: self.kutaName, container: self.kutaContainer, temperature: self.kutaTemp, aqi: self.kutaAQI, aqiImage: self.kutaImage, weatherImage: self.kutaWeatherImage, description: self.kutaDescription, seperator: self.kutaSeperator, mainAQI: self.kutaUSAQI)
			case "South Tangerang":
				print("Hello")
				self.displayFinal(pollution: pollution, cityName: self.tangerangName, container: self.tangerangContainer, temperature: self.tangerangTemp, aqi: self.tangerangAQI, aqiImage: self.tangerangImage, weatherImage: self.tangerangWeatherImage, description: self.tangerangDescription, seperator: self.tangerangSeperator, mainAQI: self.tangerangUSAQI)
			case "Ubud":
				self.displayFinal(pollution: pollution, cityName: self.ubudName, container: self.ubudContainer, temperature: self.ubudTemp, aqi: self.ubudAQI, aqiImage: self.ubudImage, weatherImage: self.ubudWeatherImage, description: self.ubudDescription, seperator: self.ubudSeperator, mainAQI: self.ubudUSAQI)
			default:
				return
			}
		}
	}

	func didFailWithError(error: Error) {
		print(error)
	}


	func displayFinal(pollution: AirVisualModel, cityName: UILabel, container: UIView, temperature: UILabel, aqi: UILabel, aqiImage: UIImageView, weatherImage: UIImageView, description: UILabel, seperator: UIView, mainAQI: UILabel ){
		setCityName(of: cityName, to: pollution.cityName)
		setTemperature(of: temperature, to: pollution.temperature)
		setAQI(of: aqi, to: pollution.aqi, color: pollution.textColor)
		setAQIImage(of: aqiImage, to: pollution.airQualityImage)
		setWeatherImage(of: weatherImage, to: pollution.weatherImage)
		setDescriptions(of: description, to: pollution.airQualityDescription, color: pollution.textColor)
		setRest(container: container, seperator: seperator, main: mainAQI)
		UIView.animate(withDuration: 1) {
			container.isHidden = false
		}

	}
	

	// Display Values
	func setCityName(of: UILabel, to: String){
		of.text = "\(to)"
	}
	func setTemperature(of: UILabel, to: Int){
		of.text = "\(to)°C"
	}
	func setAQI(of: UILabel, to: Int, color: String){
		of.text = "\(to)"
		of.textColor = UIColor(named: color)
	}
	func setAQIImage(of: UIImageView, to: String){
		of.image = UIImage.init(named: to)
	}
	func setWeatherImage(of: UIImageView, to: String){
		of.image = UIImage.init(named: to)
	}
	func setDescriptions(of: UILabel, to: String, color: String){
		of.text = to
		of.textColor = UIColor(named: color)
	}
	func setRest(container: UIView, seperator: UIView, main: UILabel){
		container.backgroundColor=UIColor(named: "containerBlue")?.withAlphaComponent(0.7)
	}

	
}






