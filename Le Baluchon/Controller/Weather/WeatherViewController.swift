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
    
    @IBOutlet weak var TopImageContainer: UIImageView!
    
    @IBOutlet weak var BottomImageContainer: UIImageView!
    
    private let weatherService = WeatherService()
    
    private func getAllWeather() {
        getWeather(town: "New York", temperatureLabel: TopLabelTemperature, WeatherImage: TopImageContainer)
        getWeather(town: "Paris", temperatureLabel: BottomLabelTemperature, WeatherImage: BottomImageContainer)
    }
    
    private func getWeather(town: String, temperatureLabel: UILabel, WeatherImage: UIImageView) {
        
        var codeImage : String = ""
        
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
                guard let imageCode = response.weather.first?.icon.description else { return }
                codeImage = imageCode
                print("codeimage:\(codeImage)")
                
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.weatherService.getWeatherImage(
                imageCode: codeImage
            ) { [weak self] (result) in
                
                switch result {
                case .failure(let error):
                    print("error !")
                    print(error)
                    //self.presentAlert(error: error)
                    print("failure on weather service on result for getting Image")
                case .success(let response):
                    print(response)
                    let loadedImage = UIImage(data: response)
                    WeatherImage.image = loadedImage
                }
            }
        }
    }
    
    private func showIconWeather(){
        
    }
    
    //private func getWeatherImage1stVersion(imageCode : String) {
    //    let weatherUrlProvider = WeatherUrlProvider()
    //
    //    let imageURL = weatherUrlProvider.createWeatherImageRequestUrl(imageCode: imageCode)
    //
    //    let task = URLSession.shared.dataTask(with: imageURL!) { (data, response, error) in
    //        if error == nil {
    //        let loadedImage = UIImage(data: data!)
    //
    //        self.TopImageContainer.image = loadedImage
    //      }
    //    }
    //task.resume()
    //}
    ////
    //
    //    weatherService.fetchImageData(url: "url") { (result) in
    //        switch result {
    //        case .success(let imageData):
    //            UIIMage(data: imageData)
    //        }
    //    }
}
