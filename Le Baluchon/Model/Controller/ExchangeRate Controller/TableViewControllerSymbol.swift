//
//  TableViewControllerSymbol.swift
//  Le Baluchon
//
//  Created by Fabien Dietrich on 16/08/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import UIKit

class TableViewControllerSymbol: UIViewController {

    @IBOutlet var tableViewSymbol : UITableView!
    
    var symbolSelectedToSend: String = "Select a Symbol"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSymbol.delegate = self
        tableViewSymbol.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let info = segue.destination as! ExchangeRateViewController
        info.symbolSelected = symbolSelectedToSend 
    }
}

extension TableViewControllerSymbol : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        symbolSelectedToSend = "\(Array(resultLastRequestRate.keys)[indexPath.row])"
        
        self.performSegue(withIdentifier: "RateToForm", sender: nil)
        print("\(symbolSelectedToSend)")
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
