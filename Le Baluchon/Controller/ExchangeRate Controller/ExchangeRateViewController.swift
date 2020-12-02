import UIKit


class ExchangeRateViewController: UIViewController, UITextFieldDelegate {

    
    // MARK: - INTERNAL
    
    // MARK: Internal - Methods
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getRateInformation()
        
    }
    
    
    
    
    // MARK: - PRIVATE
    
    // MARK: Private - Properties - Outlets
    
    @IBOutlet private weak var resultCalculExchangeLabel: UILabel!
    @IBOutlet private weak var valueToExchangeTextField: UITextField!
    @IBOutlet private weak var selectTargetCurrencySymbolButton: UIButton!
    @IBOutlet private weak var selectSourceCurrencyButton: UIButton!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    
    
    // MARK: Private - Properties - Models
    
    private let exchangeRate = ExchangeRateService()
    
    
    
    // MARK: Private - Properties - General

    
    private var usedRate: Double? {
        guard
            let rates = rates,
            let sourceRate = rates[selectedSourceCurrency.currencyCode],
            let targetRate = rates[selectedTargetCurrency.currencyCode]
            else { return nil  }
       
        return targetRate / sourceRate
    }
    
    private var rates: [String: Double]?
    
    private var selectedSourceCurrency: Currency = .euro
    private var selectedTargetCurrency: Currency = .usDollar
    
    private var valueToConvert: Double? {
        guard
            let textValue = valueToExchangeTextField.text,
            let doubleValue = Double(textValue)
            else { return nil }
        
        return doubleValue
    }
    
    
    
    
    
    // MARK: Private - Methods - IBActions
    
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        valueToExchangeTextField.resignFirstResponder()
    }
    

    @IBAction private func valuesChangedTextField() {
        convertValueWithRate()
    }
    
    
    // MARK: Private - Methods - General
    
    private func convertValueWithRate() {
        guard
            let usedRate = usedRate,
            let valueToConvert = valueToConvert
            else {
                return
        }
        
        let convertedValue = valueToConvert * usedRate
        
        
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .currency
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.currencySymbol = selectedTargetCurrency.symbol
        
        let formattedStringValue = numberFormatter.string(from: convertedValue as NSNumber)
        
        resultCalculExchangeLabel.text = formattedStringValue
    }

    
    private func getRateInformation() {
        spinner.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.exchangeRate.getRate {(result) in
                self.spinner.stopAnimating()
                
                switch result{
                case .failure(let error):
                    self.presentAlert(error: error)
                case .success(let response):
                    self.rates = response.rates

                    
                }
            }
        }
    }
    
    
    private func presentAlert(error: NetworkManagerError) {
        print("do not work translate")
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let currencySelectionViewController = segue.destination as? TableViewControllerSymbol else { return }
        
        currencySelectionViewController.delegate = self
    
        if segue.identifier == "SourceCurrencySegue" {
            currencySelectionViewController.currencySelectionType = .source
        } else {
            currencySelectionViewController.currencySelectionType = .target
        }
    
        
    }
}

extension ExchangeRateViewController: TableViewControllerSymbolDelegate {
    func didSelectSymbol(currency: Currency, currencySelectionType: CurrencySelectionType) {
        switch currencySelectionType {
        case .source:
            selectSourceCurrencyButton.setTitle(currency.currencyCode, for: .normal)
            selectedSourceCurrency = currency
        case .target:
            selectTargetCurrencySymbolButton.setTitle(currency.currencyCode, for: .normal)
            selectedTargetCurrency = currency
        }
       
    }
    
    
}

