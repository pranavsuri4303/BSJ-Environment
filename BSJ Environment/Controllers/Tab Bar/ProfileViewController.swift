//
//  ProfileViewController.swift
//  BSJ Environment
//
//  Created by Pranav  Suri on 16/4/20.
//  Copyright © 2020 Pranav  Suri. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn
import CoreLocation


class ProfileViewController: UIViewController, AirVisualManagerDelegate {
	
	// User Details Outlets
	@IBOutlet weak var userPhoto: UIImageView!
	@IBOutlet weak var userName: UILabel!
	@IBOutlet weak var userEmail: UILabel!
	
	// Creating objects
	let locationManager = CLLocationManager()
	var airVisualManager = AirVisualManager()
	
	// Data display outlets
	@IBOutlet weak var container: UIView!
	@IBOutlet weak var cityNameLabel: UILabel!
	@IBOutlet weak var stateCountryNameLabel: UILabel!
	@IBOutlet weak var weatherImage: UIImageView!
	@IBOutlet weak var temperatureLabel: UILabel!
	@IBOutlet weak var seperator: UIView!
	@IBOutlet weak var aqiLabel: UILabel!
	@IBOutlet weak var mainAQIUS: UILabel!
	@IBOutlet weak var aqiDescription: UILabel!
	@IBOutlet weak var aqiImage: UIImageView!
	
	@IBOutlet weak var spinner: UIActivityIndicatorView!
	@IBOutlet weak var loadingMessage: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		displayUserDetails()
		// Delegation
		airVisualManager.delegate = self
		// Location
		locationManager.delegate = self
		locationManager.requestLocation()
		// Making container rounded
		container.layer.cornerRadius = 10
		container.isHidden = true
		spinner.startAnimating()
		
	}
	override func viewDidAppear(_ animated: Bool) {
		locationManager.requestLocation()
		
	}
	
	
	
	func displayUserDetails(){
		let user = Auth.auth().currentUser
		if let user = user {
			userPhoto.layer.cornerRadius = 10
			if let url = user.photoURL{
				userPhoto.image = UIImage(url: url)
			}
			//			userPhoto.image = UIImage(url: user.photoURL)
			if let name = user.displayName{
				self.userName.text = name
			}else{
				self.userName.text = nil
			}
			userName.text = user.displayName
			userEmail.text = user.email
		}
	}
	func displayData(pollution: AirVisualModel){
		setContainer(container: container)
		setCityName(of: cityNameLabel, to: pollution.cityName)
		setStateCountryName(of: stateCountryNameLabel, to: pollution.stateName, and: pollution.countryName)
		setTemperature(of: temperatureLabel, to: pollution.temperature)
		setWeatherImage(of: weatherImage, to: pollution.weatherImage)
		setAQI(of: aqiLabel, to: pollution.aqi, color: pollution.textColor)
		setDescriptions(of: aqiDescription, to: pollution.airQualityDescription, color: pollution.textColor)
		setAQIImage(of: aqiImage, to: pollution.airQualityImage)
		setMainAQI(of: mainAQIUS, to: pollution.mainaqi)
		setContainer(container: container)
		UIView.animate(withDuration: 1) {
			self.container.isHidden = false
		}
	}
	
	
	func didUpdatePollution(pollution: AirVisualModel) {
		DispatchQueue.main.async {
			self.spinner.stopAnimating()
			self.spinner.alpha = 0
			self.loadingMessage.alpha = 0
			self.displayData(pollution: pollution)
		}
	}
	
	func didFailWithError(error: Error) {
		print(error)
	}
	
	// Display Values
	func setCityName(of: UILabel, to: String){
		of.text = "\(to)"
	}
	func setStateCountryName(of: UILabel, to: String, and : String){
		of.text = "\(to), \(and)"
	}
	func setTemperature(of: UILabel, to: Int){
		of.text = "\(to)°C"
	}
	func setAQI(of: UILabel, to: Int, color: String){
		of.text = "\(to)"
		of.textColor = UIColor(named: color)
	}
	func setMainAQI(of: UILabel, to: String){
		of.text = "Main Pollutant: \(to)"
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
	func setContainer(container: UIView){
		container.backgroundColor=UIColor(named: "containerBlue")?.withAlphaComponent(0.7)
	}
	
	
	
	
}

extension UIImage {
	convenience init?(url: URL?) {
		guard let url = url else { return nil }
		
		do {
			let data = try Data(contentsOf: url)
			self.init(data: data)
		} catch {
			print("Cannot load image from url: \(url) with error: \(error)")
			return nil
		}
	}
}



extension ProfileViewController: CLLocationManagerDelegate{
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last{
			let lat = Int(location.coordinate.latitude)
			let lon = Int(location.coordinate.longitude)
			print(lat)
			print(lon)
			DispatchQueue.main.async {
				print("fetched")
				self.airVisualManager.fetchWeather(latitude: lat, longitude: lon)
			}
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Error Occured")
	}
}



