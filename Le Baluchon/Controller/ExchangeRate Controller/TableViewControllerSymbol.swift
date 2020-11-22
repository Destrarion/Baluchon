//
//  TableViewControllerSymbol.swift
//  Le Baluchon
//
//  Created by Fabien Dietrich on 16/08/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import UIKit


protocol TableViewControllerSymbolDelegate: class {
    func didSelectSymbol(synbol: String, currencySelectionType: CurrencySelectionType)
}


class TableViewControllerSymbol: UIViewController {
    
    weak var delegate: TableViewControllerSymbolDelegate?
    
    let resultLastRequestRate = ["USD", "EUR", "CHF"]
    
    var currencySelectionType: CurrencySelectionType?

    @IBOutlet var tableViewSymbol: UITableView!
    
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
        let symbol = "\(resultLastRequestRate[indexPath.row])"
        
        guard let currencySelectionType = currencySelectionType else { return }
        delegate?.didSelectSymbol(synbol: symbol, currencySelectionType: currencySelectionType)
        self.dismiss(animated: true, completion: nil)
    }
}
    
extension TableViewControllerSymbol : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Ratecell", for: indexPath)
        
        cell.textLabel?.text = "\(resultLastRequestRate[indexPath.row])"

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultLastRequestRate.count
    }
 
}
