//
//  ViewController.swift
//  Bit-Price
//
//  Created by Nayani Gaonkar on 06/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var bitcoinLable: UILabel!
    @IBOutlet weak var currencyLable: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var criptoPicker: UIPickerView!
        
    
    var coinManager = CoinManager()
    
    var selectedCurrency = ""
    var selectedCripto = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinManager.delegate = self
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        
        criptoPicker.dataSource = self
        criptoPicker.delegate = self
        
        currencyPicker.tag = 1
        criptoPicker.tag = 2
    }
}

//MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    
    func didUpdatePrice(price: String, currency: String) {
        
        print("price: \(price)")
        DispatchQueue.main.async {
            self.bitcoinLable.text = price
            self.currencyLable.text = currency
        }
    }
    
    func didFailWithError(error: Error) {
        print("error:", error)
    }
}

//MARK: - UIPickerView DataSource & Delegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
    }
      
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
          switch pickerView.tag {
          case 1:
              return coinManager.currencyArray.count
          case 2:
              return coinManager.criptoArray.count
          default:
              return 1
          }
          
      }
      
      func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
                    
          switch pickerView.tag {
          case 1:
              return coinManager.currencyArray[row]
          case 2:
              return coinManager.criptoArray[row]
          default:
              return coinManager.currencyArray[row]
          }
          
      }
      
      func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
                    
          switch pickerView.tag {
          case 1:
              selectedCurrency = coinManager.currencyArray[row]
          case 2:
              selectedCripto = coinManager.criptoArray[row]
          default:
              print("pickerView.tag: \(pickerView.tag)")
          }
          
          print("selectedCurrency: \(selectedCurrency)")
          print("selectedCurrency:  \(selectedCripto)")
          
      }
    
    @IBAction func getPricePressed(_ sender: UIButton) {
        coinManager.getCoinPrice(for: selectedCurrency, cripto: selectedCripto)
    }
    
}

