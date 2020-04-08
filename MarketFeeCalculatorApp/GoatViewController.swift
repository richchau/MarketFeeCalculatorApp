//
//  GoatViewController.swift
//  MarketFeeCalculatorApp
//
//  Created by Rich Chau on 4/3/20.
//  Copyright © 2020 Rich Chau. All rights reserved.
//

import UIKit

class GoatViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    

    @IBOutlet weak var locationTextField: UITextField!

    @IBOutlet weak var soldPriceTextField: CurrencyField!
    @IBOutlet weak var itemCostTextField: CurrencyField!
    @IBOutlet weak var taxTextField: UITextField!
    
    @IBOutlet weak var cashOutFeeLabel: UILabel!
    @IBOutlet weak var goatFeeLabel: UILabel!
    @IBOutlet weak var taxFeeLabel: UILabel!
    @IBOutlet weak var profitLabel: UILabel!
    @IBOutlet weak var cashoutToggle: UISwitch!
    @IBOutlet weak var returnLabel: UILabel!
    
    @IBOutlet weak var profitsView: UIView!
    @IBOutlet weak var feesView: UIView!
    @IBOutlet weak var inputsView: UIView!
    
    let cardCornerRadius = 7
    
    var locationDict: [String:Double] = ["United States" : 5.00, "Canada" : 20.00, "Other" : 30.00, "United Kingdom" : 12.00, "Ireland" : 12.00, "Luxembourg" : 12.00, "Netherlands" : 12.00, "Belgium" : 12.00, "France" : 12.00, "Germany" : 12.00, "Hong Kong" : 15.00, "Austria" : 20.00, "Sweden" : 20.00, "Italy" : 20.00, "Finland" : 20.00, "Portugal" : 20.00, "Spain" : 20.00, "Denmark" : 20.00, "Guam" : 25.00]
    var locationPickerData = [String]()
    var locationCost : Double = 0
    var soldPrice : Double = 0
    var itemCost : Double = 0
    var tax : Double = 0
    var cashOut = false
    
    let payPalPercentFee = 2.9
    let commissionPercentFee = 9.5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardViewConfigure(view: profitsView)
        cardViewConfigure(view: feesView)
        cardViewConfigure(view: inputsView)
        
        locationPickerData = Array(locationDict.keys).sorted()

        let locationPicker = UIPickerView()
        locationTextField.inputView = locationPicker
        locationTextField.text = locationPickerData[0]
        locationPicker.delegate = self
        
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        locationTextField.addTarget(self, action: #selector(onTextFieldChange), for: .allEditingEvents)
        
        soldPriceTextField.locale = Locale(identifier: "en_US")
        soldPriceTextField.keyboardType = UIKeyboardType.numberPad
        soldPriceTextField.addTarget(self, action: #selector(onTextFieldChange), for: .editingChanged)
        soldPriceTextField.placeholder = "0"
        
        itemCostTextField.locale = Locale(identifier: "en_US")
        itemCostTextField.keyboardType = UIKeyboardType.numberPad
        itemCostTextField.addTarget(self, action: #selector(onTextFieldChange), for: .editingChanged)
        itemCostTextField.placeholder = "0"
        
        taxTextField.keyboardType = UIKeyboardType.numberPad
        taxTextField.addTarget(self, action: #selector(onTextFieldChange), for: .editingChanged)
        taxTextField.placeholder = "0"
        
        cashoutToggle.setOn(cashOut, animated: true)
        cashoutToggle.addTarget(self, action: #selector(onTextFieldChange), for: .valueChanged)
        
    }
    
    func cardViewConfigure(view: UIView){
        view.layer.cornerRadius = CGFloat(cardCornerRadius)
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4
    }
    
    @objc func onTextFieldChange(){
    
        self.locationCost = locationDict[locationTextField.text!] ?? 5.0
        self.soldPrice = Double(truncating: soldPriceTextField.decimal as NSNumber)
        self.itemCost = Double(truncating: itemCostTextField.decimal as NSNumber)
        self.tax = Double(taxTextField.text!) ?? 0
        self.cashOut = cashoutToggle.isOn
        
        let commissionFee = soldPrice * (commissionPercentFee / 100)
        let goatFee = self.locationCost + commissionFee
        
        var cashOutFee = 0.0
        if (cashoutToggle.isOn){
            cashOutFee = (payPalPercentFee / 100) * (soldPrice - goatFee)
        }
        
        var taxFee = (self.tax / 100) * (self.soldPrice - self.itemCost - goatFee - cashOutFee)
        if(taxFee == -0){
            taxFee = 0
        }
        var totalProfits = (self.soldPrice - self.itemCost - goatFee - cashOutFee - taxFee)
        
        var returnOnInvestment = (totalProfits / (self.itemCost + goatFee + cashOutFee + taxFee)) * 100
        
        if(soldPrice == 0){
            totalProfits = 0
            returnOnInvestment = 0
        }
        
        self.goatFeeLabel.text = "$" + String(format: "%.2f", goatFee)
        self.cashOutFeeLabel.text = "$" + String(format: "%.2f", cashOutFee)
        self.taxFeeLabel.text = "$" + String(format: "%.2f", taxFee)
        self.profitLabel.text = "$" + String(format: "%.2f", totalProfits)
        self.returnLabel.text = String(format: "%.2f", returnOnInvestment) + "%"
    
    }

    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return locationPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return locationPickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        locationTextField.text = locationPickerData[row]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
