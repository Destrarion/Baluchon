//
//  TableViewControllerSymbol.swift
//  Le Baluchon
//
//  Created by Fabien Dietrich on 16/08/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import UIKit

var symbolSelected: String = "Select a Symbol"


class TableViewControllerSymbol: UIViewController {

    @IBOutlet var tableViewSymbol : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSymbol.delegate = self
        tableViewSymbol.dataSource = self
    }
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RateToForm"{
            let formVC = segue.destination as! ExchangeRateViewController
            formVC.symbolSelected = symbolSelected
        }
    }
    */
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TableViewControllerSymbol : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        symbolSelected = "\(Array(resultLastRequestRate.keys)[indexPath.row])"
       // performSegue(withIdentifier: "RateToForm", sender: self)
        let sendRateToForm = Notification.Name(rawValue: "sendRateToForm")
        NotificationCenter.default.post(name: sendRateToForm, object: self)
        self.dismiss(animated: true, completion: nil)
        print("\(symbolSelected)")
    }
}
    
extension TableViewControllerSymbol : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Ratecell", for: indexPath)
        
        cell.textLabel?.text = "\(Array(resultLastRequestRate.keys)[indexPath.row])"

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultLastRequestRate.count
    }
 
}
