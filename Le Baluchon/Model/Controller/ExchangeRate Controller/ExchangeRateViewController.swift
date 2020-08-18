//
//  ViewController.swift
//  taux de change API
//
//  Created by Fabien Dietrich on 23/05/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    

    
    @IBAction func GetRateEchangeButton(_ sender: UIButton) {
        ExchangeRate.shared.getExchangeRate { (success, fixerResponse) in
            if success, let _ = fixerResponse{
                print("that work")
            } else {
                print("don't work")
            }
        }
        
    }
    var symbolSelected : String = "Select a Symbol"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // receivingNotification(name: "updatePickerView")
        ExchangeRate.shared.getExchangeRate { (success, fixerResponse) in
            if success, let _ = fixerResponse{
                print("that work")
            } else {
                print("don't work")
            }
        }
        label.text = symbolSelected
        // Do any additional setup after loading the view.
    }
    // function for receiving notification
    private func receivingNotification(name: String) {
        let notificationName = Notification.Name(rawValue: name)
        let selector = Selector((name))
        NotificationCenter.default.addObserver(self, selector: selector, name: notificationName, object: nil)
    }
}

