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
        if UITextViewUpper.text != nil {
        textToTranslate = "q&=\(UITextViewUpper.text!)"
        } else {return}
        
        languageSelectedFrom = "&target=\(LabelLanguageSelected1.text!)"
        Translate.shared.getTranslation { (success , translateResponse) in
            if success, let _ = translateResponse{
                print("that work translate")
            }else {
                print("do not work translate")
            }
        }
        UITextViewLower.text = resultTranslate
    }
    
    

}
