//
//  AlertManager.swift
//  Le Baluchon
//
//  Created by Fabien Dietrich on 23/12/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import UIKit


class AlertManager {
    func presentAlert(on viewController: UIViewController?, error: NetworkManagerError) {
        guard let viewController = viewController else { return }
        
        let alertController = UIAlertController(
            title: "Error",
            message: error.errorDescription,
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(title: "OK", style: .default, handler: nil)
        )
        
        viewController.present(alertController, animated: true, completion: nil)
    }

}





