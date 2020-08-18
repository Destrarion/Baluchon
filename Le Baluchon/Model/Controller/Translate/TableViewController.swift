//
//  TableViewController.swift
//  Le Baluchon
//
//  Created by Fabien Dietrich on 11/08/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet var tableView : UITableView!
    
    let langague = [
        "French (FR)",
        "English (EN)",
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TableViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you tapped me")
    }
}
    
extension TableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFrench", for: indexPath)
        
        cell.textLabel?.text = langague[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return langague.count
    }
 
}

