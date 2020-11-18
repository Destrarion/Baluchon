//
//  TranslateViewController.swift
//  Le Baluchon
//
//  Created by Fabien Dietrich on 01/10/2020.
//  Copyright © 2020 Fabien Dietrich. All rights reserved.
//

import UIKit


enum Language {
    case english, french
    
    
    var languageCode: String {
        switch self {
        case .english: return "EN"
        case .french: return "FR"
        }
    }
    
    
    var name: String {
        switch self {
        case .english: return "English"
        case .french: return "French"
        }
    }
}

class TranslateViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var LabelLanguageSelected1: UILabel!
    @IBOutlet weak var LabelLanguageSelected2: UILabel!
    
    @IBOutlet weak var UITextViewUpper: UITextView!
    @IBOutlet weak var UITextViewLower: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITextViewUpper.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    private var sourceLanguageSelected: Language = .english {
        didSet {
            LabelLanguageSelected1.text = sourceLanguageSelected.name
        }
    }
    
    private var targetLanguageSelected: Language = .french {
        didSet {
            LabelLanguageSelected2.text = targetLanguageSelected.name
        }
    }
    
    @IBAction func ReverseLanguageButton(_ sender: UIButton) {
        swap(&sourceLanguageSelected, &targetLanguageSelected)
    }
    
    @IBAction func TranslateButton(_ sender: UIButton) {
        translateText()
      
    }
    
    private func translateText() {
        guard let textToTranslate = UITextViewUpper.text else {
            print("Could not get text from textview")
            presentAlert(error: .unknownError)
            return
        }
        
        Translate.shared.getTranslation(
            textToTranslate: textToTranslate,
            targetLanguage: targetLanguageSelected.languageCode,
            sourceLanguage: sourceLanguageSelected.languageCode
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
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            translateText()
            textView.resignFirstResponder()
        }
        return true
    }
    

}
