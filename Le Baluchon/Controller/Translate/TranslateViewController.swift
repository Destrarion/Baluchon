//
//  TranslateViewController.swift
//  Le Baluchon
//
//  Created by Fabien Dietrich on 01/10/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var LabelLanguageSelected1: UILabel!
    @IBOutlet weak var LabelLanguageSelected2: UILabel!
    
    @IBOutlet weak var UITextViewUpper: UITextView!
    @IBOutlet weak var UITextViewLower: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func ReverseLanguageButton(_ sender: UIButton) {
    }
    
    @IBAction func TranslateButton(_ sender: UIButton) {
        
        guard let textToTranslate = UITextViewUpper.text else {
            print("Could not get text from textview")
            presentAlert(error: .unknownError)
            return
        }
        
        Translate.shared.getTranslation(
            textToTranslate: textToTranslate,
            targetLanguage: "EN",
            sourceLanguage: "FR"
        ) { (result) in
            
            switch result {
            case .failure(let error):
                self.presentAlert(error: error)
            case .success(let response):
                guard let translatedText = response.data.translations.first?.translatedText else { return }
                print("that work translate \(translatedText)")
                self.UITextViewLower.text = translatedText
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
    
    

}
