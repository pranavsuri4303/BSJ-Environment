import Foundation

protocol AirVisualManagerDelegate {
    func didUpdatePollution(pollution: AirVisualModel)
    func didFailWithError(error: Error)
}
struct AirVisualManager{
    //API key : 6157dbfb-03c9-4b8f-988c-4df2e85ab1f6
    
    var delegate: AirVisualManagerDelegate?

	func fetchWeather(cityName: String, stateName:String){
        let pollutionURL = "https://api.airvisual.com/v2/city?city=\(cityName)&state=\(stateName)&country=Indonesia&key=6157dbfb-03c9-4b8f-988c-4df2e85ab1f6"
		performRequest(with: pollutionURL)
    }
	func fetchWeather(latitude: Int, longitude: Int){
		let pollutionURL = "https://api.airvisual.com/v2/nearest_city?lat=\(latitude)&lon=\(longitude)&key=6157dbfb-03c9-4b8f-988c-4df2e85ab1f6"
		performRequest(with: pollutionURL)
	}
    
	func performRequest(with urlString: String){
        // 1: Create a URL
        if let url = URL(string: urlString){
            // 2: Create a URL session
            let session = URLSession(configuration: .default)
            // 3: Give the session a task
            let task = session.dataTask(with: url ) { (content, respone, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = content {
                    if let pollution = self.parseJSON(safeData){
                        self.delegate?.didUpdatePollution(pollution: pollution)

                    }
                }
            }
            // 4: Start task
            task.resume()
        }
    }
    func parseJSON(_ pollutionData: Data)->AirVisualModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(AirVisualResponse.self, from: pollutionData)
            let city = decodedData.data.city
			let state = decodedData.data.state
			let country = decodedData.data.country
            let temp = decodedData.data.currentConditions.weather.temperature
            let aqi = decodedData.data.currentConditions.pollution.aqiUS
            let mainaqi = decodedData.data.currentConditions.pollution.mainPollutantUS
			let image = decodedData.data.currentConditions.weather.image
			let pollution = AirVisualModel(cityName: city,stateName: state, countryName: country ,temperature: temp, aqi: aqi, mainaqi: mainaqi, weatherImage: image)
            return pollution
        } catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
    }
 
}
