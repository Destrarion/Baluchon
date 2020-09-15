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
    @IBOutlet weak var valueToExchangeTextFieldLabel: UITextField!
    @IBOutlet weak var selectSymbolButton: UIButton!
    

    
    /*@IBAction func GetRateEchangeButton(_ sender: UIButton) {
        ExchangeRate.shared.getExchangeRate { (success, fixerResponse) in
            if success, let _ = fixerResponse{
                print("that work")
            } else {
                print("don't work")
            }
        }
        
    }*/
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        valueToExchangeTextFieldLabel.resignFirstResponder()
    }
    
    @IBAction func EditingChanged(_ sender: UITextField) {
        if selectSymbolButton.titleLabel?.text != "Select your local Symbol" {
            ExchangeRate.shared.calculExchangeRateWithValue(symbolSelected, valueToExchangeTextFieldLabel.text!)
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receivingNotification(name: "updateValueToExchange")
        NotificationCenter.default.addObserver(self, selector: #selector(sendRateToForm(notification:)), name: NSNotification.Name(rawValue: "sendRateToForm"), object: nil)
       // receivingNotification(name: "updatePickerView")
        ExchangeRate.shared.getExchangeRate { (success, fixerResponse) in
            if success, let _ = fixerResponse{
                print("that work")
            } else {
                print("don't work")
            }
        }
        selectSymbolButton.titleLabel?.text = symbolSelected
    }
    
    @objc func updateValueToExchange () {
        resultCalculExchangeLabel.text = "\(ExchangeRate.shared.resultCalculationRate)"
    }
    
    @objc func sendRateToForm(notification : Notification) {
        //let formVC = notification.object as! TableViewController
        selectSymbolButton.titleLabel?.text = symbolSelected
        if valueToExchangeTextFieldLabel.text != nil || valueToExchangeTextFieldLabel.text != "" {
            ExchangeRate.shared.calculExchangeRateWithValue(symbolSelected, valueToExchangeTextFieldLabel.text!)
        }
        print("bien recu sir !")
        
    }
    
    // function for receiving notification
    private func receivingNotification(name: String) {
        let notificationName = Notification.Name(rawValue: name)
        let selector = Selector((name))
        NotificationCenter.default.addObserver(self, selector: selector, name: notificationName, object: nil)
    }
    
    func setcurrency(currency: String) {
        let symbolSelected = currency
        selectSymbolButton.titleLabel?.text = symbolSelected
        print("set currency called")
    }
}

