//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager: CoinManager)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC/"
    let apiKey = "6ABE8EF0-240D-4ED6-871E-58ECFDE21643"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task
            // when session completes networking and its task is complete, the session calls the completionHandler function
            let task = session.dataTask(with: url, completionHandler: handle(data: response: error: ))
            
            //4. start the task
            task.resume()
            
        }
        
        
    }
    
    func handle(data: Data?, response: URLResponse?, error: Error?) {
        
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
    
//    func performRequest(with urlString: String) {
//        //1. Create a URL
//        if let url = URL(string: urlString) {
//            //2. Creat a URLSession
//            let session = URLSession(configuration: .default)
//
//            //3. Give the Session a task
//            let task = session.dataTask(with: url) { (data, response, error) in
//                if error != nil {
//                    self.delegate?.didFailWithError(error: error!)
//                }
//                if let safeData = data {
//                    if let currency = self.parseJSON(safeData) {
//                        self.delegate?.didUpdateCurrency(self, currency: currency)
//                    }
//                }
//            }
//
//            //4. Start the task
//            task.resume()
//        }
//    }
//
//    func parseJSON(_ weatherData: Data) -> WeatherModel? {
//
//        let decoder = JSONDecoder()
//        do {
//            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            let id = decodedData.weather[0].id
//            let temp = decodedData.main.temp
//            let name = decodedData.name
//
//            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
//
//            return weather
//
//            //print(weather.temperatureString)
//
//        } catch {
//            delegate?.didFailWithError(error: error)
//            return nil
//        }
//    }
}
