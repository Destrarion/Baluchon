import UIKit


class TranslateViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITextViewUpper.delegate = self
    }
    
    
    // MARK: - PRIVATE
    
    // MARK: Private - Properties - Outlets
    @IBOutlet private weak var LabelLanguageSelected1: UILabel!
    @IBOutlet private weak var LabelLanguageSelected2: UILabel!
    @IBOutlet private var spinner : UIActivityIndicatorView!
    @IBOutlet private weak var UITextViewUpper: UITextView!
    @IBOutlet private weak var UITextViewLower: UITextView!
    
    
    // MARK: Private - Methods - IBActions
    @IBAction func ReverseLanguageButton(_ sender: UIButton) {
        swap(&sourceLanguageSelected, &targetLanguageSelected)
    }
    
    @IBAction func TranslateButton(_ sender: UIButton) {
        translateText()
        
    }
    
    // MARK: Private - Properties - Models
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
    
    private func translateText() {
        spinner.startAnimating()
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
        spinner.stopAnimating()
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
