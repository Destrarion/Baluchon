//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Fabien Dietrich on 09/12/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getAllWeather()
        
        let weatherUrlProvider = WeatherUrlProvider()
        
        let imageURL = weatherUrlProvider.createWeatherImageRequestUrl(imageCode: "10d")
        
        let task = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
            if error == nil {
                let loadedImage = UIImage(data: data!)
                
                self.TopImageContainer.image = loadedImage
            }
        }
        task.resume()
    }

    @IBOutlet private weak var TopLabelTemperature: UILabel!
    
    @IBOutlet private weak var BottomLabelTemperature: UILabel!
    
    @IBOutlet weak var TopImageContainer: UIImageView!
    private let weatherService = WeatherService()
    
    private func getAllWeather() {
        getWeather(town: "New York", temperatureLabel: TopLabelTemperature)
        getWeather(town: "Paris", temperatureLabel: BottomLabelTemperature)
    }
    
    private func getWeather(town: String, temperatureLabel: UILabel) {
        weatherService.getWeather(
            town: town
        ) { [weak self] (result) in
            
            switch result {
            case .failure(let error):
                print("error !")
                //self.presentAlert(error: error)
            print("failure on weather service on result")
            case .success(let response):
                let cityTemperature = response.main.temp
                temperatureLabel.text = "\(cityTemperature)"
            }
        }
    }
  
    
    //private func getWeatherImage(town: String, temperatureLabel: UILabel) {
    //    let urlTestImage = "http://openweathermap.org/img/wn/10d@2x.png"
    //    weatherService.getWeather(
    //        town: town
    //    ) { [weak self] (result) in
    //
    //        switch result {
    //        case .failure(let error):
    //            print("error !")
    //            //self.presentAlert(error: error)
    //        print("failure on weather service on result")
    //        case .success(let response):
    //            UIImage(data: response.weather.)
    //        }
    //    }
    //}
//
//
//    weatherService.fetchImageData(url: "url") { (result) in
//        switch result {
//        case .success(let imageData):
//            UIIMage(data: imageData)
//        }
//    }
}
