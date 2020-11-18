//
//  ViewController.swift
//  taux de change API
//
//  Created by Fabien Dietrich on 23/05/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var resultCalculExchangeLabel: UILabel!
    @IBOutlet weak var valueToExchangeTextField: UITextField!
    @IBOutlet weak var selectSymbolButton: UIButton!
    
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        valueToExchangeTextField.resignFirstResponder()
    }
    
    //IBAction func EditingChanged(_ sender: UITextField) {
    //ExchangeRate.shared.calculExchangeRateWithValue(symbolSelected, valueToExchangeTextFieldLabel.text!)
    //}
    
    @IBAction func didTapConvertButton() {
        convertValueWithRate()
    }
    @IBAction func valuesChangedTextField() {
        convertValueWithRate()
    }
    
    
    private let exchangeRate = ExchangeRate()
    
    private func convertValueWithRate() {
        guard
            let usedRate = usedRate,
            let valueToConvert = valueToConvert
            else {
                return
        }
        
        let convertedValue = valueToConvert * usedRate
        
        resultCalculExchangeLabel.text = convertedValue.description
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //receivingNotification(name: "updateValueToExchange")
        //NotificationCenter.default.addObserver(self, selector: #selector(sendRateToForm(notification:)), name: NSNotification.Name(rawValue: "sendRateToForm"), object: nil)
       // receivingNotification(name: "updatePickerView")
        exchangeRate.getRate {(result) in
            
            switch result{
            case .failure(let error):
                self.presentAlert(error: error)
            case .success(let response):
                self.rates = response.rates

                
            }
        }
        
 
    }
    
    private var usedRate: Double? {
        guard let rates = rates else { return nil  }
        return rates[selectedCurrencySymbol]
    }
    
    
    private var rates: [String: Double]?
    
    private var selectedCurrencySymbol = "USD"
    
    private var valueToConvert: Double? {
        guard
            let textValue = valueToExchangeTextField.text,
            let doubleValue = Double(textValue)
            else { return nil }
        
        return doubleValue
    }
    
    
    
//    @objc func updateValueToExchange () {
//        resultCalculExchangeLabel.text = "\(ExchangeRate.shared.resultCalculationRate)"
//    }
//
//    @objc func sendRateToForm(notification : Notification) {
//        //let formVC = notification.object as! TableViewController
//        selectSymbolButton.titleLabel?.text = symbolSelected
//        /*if valueToExchangeTextFieldLabel.text != nil || valueToExchangeTextFieldLabel.text != "" {
//            ExchangeRate.shared.calculExchangeRateWithValue(symbolSelected, valueToExchangeTextFieldLabel.text!)
//        }*/
//        print("bien recu sir !")
//
//    }
//
    // function for receiving notification
//    private func receivingNotification(name: String) {
//        let notificationName = Notification.Name(rawValue: name)
//        let selector = Selector((name))
//        NotificationCenter.default.addObserver(self, selector: selector, name: notificationName, object: nil)
//    }
//
//    func setcurrency(currency: String) {
//        let symbolSelected = currency
//        selectSymbolButton.titleLabel?.text = symbolSelected
//        print("set currency called")
//    }
    
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
        
    }
}

extension ExchangeRateViewController: TableViewControllerSymbolDelegate {
    func didSelectSymbol(synbol: String) {
        selectSymbolButton.setTitle(synbol, for: .normal)
        selectedCurrencySymbol = synbol
    }
    
    
}
