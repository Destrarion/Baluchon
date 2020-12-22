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
    private let weatherService = WeatherService()
    
    private func getAllWeather() {
        getWeather(town: "New York", temperatureLabel: TopLabelTemperature, WeatherImage: TopImageContainer, spinner: TopActivityIndicator)
        getWeather(town: "Paris", temperatureLabel: BottomLabelTemperature, WeatherImage: BottomImageContainer, spinner: BottomActivityIndicator)
    }
    
    private func getWeather(town: String, temperatureLabel: UILabel, WeatherImage: UIImageView, spinner: UIActivityIndicatorView) {
        
        spinner.startAnimating()
        weatherService.getWeather(
            town: town
        ) { [weak self] (result) in
            
            switch result {
            case .failure(let error):
                spinner.stopAnimating()
                self?.presentAlert(error: error)
            case .success(let response):
                let cityTemperature = response.main.temp
                temperatureLabel.text = "\(cityTemperature)°C"
                guard let imageCode = response.weather.first?.icon.description else { return }
                
                self?.weatherService.getWeatherImageData(
                    imageCode: imageCode
                ) { [weak self] (result) in
                    spinner.stopAnimating()
                    switch result {
                    case .failure(let error):
                        self?.presentAlert(error: error)
                    case .success(let response):
                        let loadedImage = UIImage(data: response)
                        WeatherImage.image = loadedImage
                    }
                }
                
            }
        }
    }
    
    private func presentAlert(error: NetworkManagerError) {
        let alertController = UIAlertController(
            title: "Error",
            message: error.errorDescription,
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(title: "OK", style: .default, handler: nil)
        )
        
        present(alertController, animated: true, completion: nil)
    }
    
}
