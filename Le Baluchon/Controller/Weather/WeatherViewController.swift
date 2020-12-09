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
    }

    @IBOutlet private weak var TopLabelTemperature: UILabel!
    
    @IBOutlet private weak var BottomLabelTemperature: UILabel!
    
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
    
//
//
//    weatherService.fetchImageData(url: "url") { (result) in
//        switch result {
//        case .success(let imageData):
//            UIIMage(data: imageData)
//        }
//    }
}
