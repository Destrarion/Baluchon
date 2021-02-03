import UIKit


class TranslateViewController: UIViewController {
    
    // MARK: - INTERNAL
    
    // MARK: Internal - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textToTranslateTextView.delegate = self
        textToTranslateTextView.insertText("Enter your text to translate here")
        textToTranslateTextView.textColor = .gray
        
        setupToolBar()

    }
    
    
    // MARK: - PRIVATE
    
    // NARK: Private - Properties - Services
    
    private let translateService = TranslateService()
    
    // MARK: Private - Properties - Outlets
    @IBOutlet private weak var sourceLanguageSelectedLabel: UILabel!
    @IBOutlet private weak var targetLanguageSelectedLabel: UILabel!
    
    @IBOutlet private var spinner: UIActivityIndicatorView!
    
    @IBOutlet private weak var textToTranslateTextView: UITextView!
    @IBOutlet private weak var translatedTextTextView: UITextView!
    
    

    // MARK: Private - Methods - IBActions
    @IBAction func ReverseLanguageButton(_ sender: UIButton) {
        swap(&sourceLanguageSelected, &targetLanguageSelected)
    }
    
    @IBAction func TranslateButton(_ sender: UIButton) {
        translateText()
        
    }
    
    // MARK: Private - Properties - General
    private let alertManager = AlertManager()
    
    
    private var sourceLanguageSelected: Language = .english {
        didSet {
            sourceLanguageSelectedLabel.text = sourceLanguageSelected.name
        }
    }
    
    private var targetLanguageSelected: Language = .french {
        didSet {
            targetLanguageSelectedLabel.text = targetLanguageSelected.name
        }
    }
    
    private func setupToolBar() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 35))

        toolBar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(translateText))
        ]
        
        textToTranslateTextView.inputAccessoryView = toolBar
        
        toolBar.sizeToFit()
        
        

    }
    
    @objc private func translateText() {
        textToTranslateTextView.resignFirstResponder()
        
        spinner.startAnimating()
        guard let textToTranslate = textToTranslateTextView.text else {
            spinner.stopAnimating()
            alertManager.presentAlert(on: self, error: .unknownError)
            return
        }
        
        translateService.getTranslation(
            textToTranslate: textToTranslate,
            targetLanguage: targetLanguageSelected.languageCode,
            sourceLanguage: sourceLanguageSelected.languageCode
        ) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.spinner.stopAnimating()
            }
            switch result {
            case .failure(let error):
                self?.alertManager.presentAlert(on: self, error: error)
            case .success(let response):
                guard let translatedText = response.data.translations.first?.translatedText else { return }
                DispatchQueue.main.async {
                    self?.translatedTextTextView.text = translatedText.htmlDecoded
                }
            }
        }
    }
    
}

extension TranslateViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = .white
    }
    
}



extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil).string

        return decoded ?? self
    }
}
