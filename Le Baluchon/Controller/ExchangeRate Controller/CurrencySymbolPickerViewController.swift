import UIKit

// MARK: - PUBLIC
protocol TableViewControllerSymbolDelegate: AnyObject {
    func didSelectSymbol(currency: Currency, currencySelectionType: CurrencySelectionType)
}


class CurrencySymbolPickerViewController: UIViewController {

//MARK: - Internal - Methods
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewSymbol.delegate = self
        tableViewSymbol.dataSource = self
    }
    
// MARK: Private - Properties - Outlets

    @IBOutlet weak var tableViewSymbol: UITableView!
    
    
// MARK: Private - Methods - IBActions
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Private - Properties - General
    weak var delegate: TableViewControllerSymbolDelegate?
    
    var currencySelectionType: CurrencySelectionType?
    
    private let selectableCurrencies: [Currency] = [.usDollar, .euro]
}

extension CurrencySymbolPickerViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrency = selectableCurrencies[indexPath.row]
        
        guard let currencySelectionType = currencySelectionType else { return }
        delegate?.didSelectSymbol(currency: selectedCurrency, currencySelectionType: currencySelectionType)
        self.dismiss(animated: true, completion: nil)
    }
}

extension CurrencySymbolPickerViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Ratecell", for: indexPath)
        
        cell.textLabel?.text = selectableCurrencies[indexPath.row].currencyCode
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectableCurrencies.count
    }
    
}
