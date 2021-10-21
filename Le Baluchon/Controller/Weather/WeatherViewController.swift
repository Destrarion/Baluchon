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
    
    @IBOutlet weak var TopActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var BottomActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var TopWeatherDescription: UILabel!
    @IBOutlet weak var BottomWeatherDescription: UILabel!
    
    
    
    private let weatherService = WeatherService()
    private let alertManager = AlertManager()
    
    private func getAllWeather() {
        getWeather(town: "New York", temperatureLabel: TopLabelTemperature, weatherImage: TopImageContainer, weatherDescription: TopWeatherDescription, spinner: TopActivityIndicator)
        getWeather(town: "Paris", temperatureLabel: BottomLabelTemperature, weatherImage: BottomImageContainer, weatherDescription: BottomWeatherDescription, spinner: BottomActivityIndicator)
    }
    
    /// we use a weak self in that function to avoid memory retention.
    /// due to a strong reference used to WeatherService, we want to avoid an another strong reference that can cause memory retention. Thank to the weak self we are able to free memory space.
    private func getWeather(town: String, temperatureLabel: UILabel, weatherImage: UIImageView, weatherDescription: UILabel, spinner: UIActivityIndicatorView) {
        spinner.startAnimating()
        weatherService.getWeather(
            town: town
        ) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    spinner.stopAnimating()
                    self?.alertManager.presentAlert(on: self, error: error)
                case .success(let response):
                    let cityTemperature = response.main.temp
                    guard let cityWeatherDescription = response.weather.first?.weatherDescription else { return }
                    
                    temperatureLabel.text = "\(cityTemperature)°C"
                    weatherDescription.text = "\(cityWeatherDescription)"
                    
                    guard let imageCode = response.weather.first?.icon.description else { return }
                    
                    self?.weatherService.getWeatherImageData(
                        imageCode: imageCode
                    ) { [weak self] (result) in
                        DispatchQueue.main.async {
                            spinner.stopAnimating()
                            
                            switch result {
                            case .failure(let error):
                                self?.alertManager.presentAlert(on: self, error: error)
                            case .success(let response):
                                let loadedImage = UIImage(data: response)
                                weatherImage.image = loadedImage
                                
                                
                            }
                        }
                    }
                }
            }
        }
        
    }
}




