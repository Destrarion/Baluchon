import UIKit


class ExchangeRateViewController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valueToExchangeTextField.attributedPlaceholder = NSAttributedString(
            string: "Insert your value here",
            attributes: [.foregroundColor: UIColor.systemOrange]
        )
    }
    
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
    private let alertManager = AlertManager()
    
    // MARK: Private - Methods - IBActions
    
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        valueToExchangeTextField.resignFirstResponder()
    }
    
    @IBAction private func valuesChangedTextField() {
        resultUpdate()
    }
    
    // MARK: Private - Properties - General
    
    
    private var valueToConvert: Double? {
        guard
            let textValue = valueToExchangeTextField.text,
            let doubleValue = Double(textValue)
        else { return nil }
        
        return doubleValue
    }
    
    // MARK: Private - Methods - General
    
    private func getRateInformation() {
        spinner.startAnimating()
        
        self.exchangeRate.getRate { [weak self] (result) in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
            }
            
            switch result{
            case .failure(let error):
                self?.alertManager.presentAlert(on: self, error: error)
            case .success(let response):
                self?.exchangeRate.rates = response.rates
                
            }
        }
    }
    
    private func resultUpdate () {
        if valueToExchangeTextField.text != "" {
            resultCalculExchangeLabel.text = exchangeRate.convertValueWithRate(valueToConvert: valueToConvert!)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let currencySelectionViewController = segue.destination as? CurrencySymbolPickerViewController else { return }
        
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
            exchangeRate.selectedSourceCurrency = currency
            resultUpdate()
        case .target:
            selectTargetCurrencySymbolButton.setTitle(currency.currencyCode, for: .normal)
            exchangeRate.selectedTargetCurrency = currency
            resultUpdate()
        }
        
    }
    
    
}

