//
//  CurrencyConvertor.swift
//  Forex Wallet
//
//  Created by Aruna Sairam Manjunatha on 29/5/19.
//  Copyright © 2019 Aruna Sairam Manjunatha. All rights reserved.
//

import UIKit

enum error: Error{
    case nilError
}
extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}

class CurrencyConvertor: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
   
    
var currentCurrencyValue = Float(1)
var previousCurrencyValue = Float(1)
var percent = Float(0)
var convertedValue = Float(0)
    
    @IBOutlet weak var currencyButton1: UIButton!
    
    @IBOutlet weak var done1: UIButton!
    @IBOutlet weak var currencyLabel1: UILabel!
    
    @IBOutlet weak var currencyField1: UITextField!{
        didSet {
            currencyField1?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTapped1)))
        }
    }
    
    @IBOutlet weak var currencyPicker1: UIPickerView!
    @IBAction func currencyButton1Pressed(_ sender: Any) {
        currencyPicker1.isHidden = false
        currencyLabel1.isHidden = true
        done1.isHidden = false
        currencyField1.isHidden = true
    }
    
    @IBAction func done1Pressed(_ sender: Any) {
        currencyPicker1.isHidden=true
        currencyLabel1.isHidden=false
        currencyField1.isHidden=false
        done1.isHidden=true
        if (currencyLabel1.text == currencyLabel2.text){
         currencyField2.text = currencyField1.text
        }
        else{
        fetchValue()
        }
    }
    
   
    
    @IBOutlet weak var currencyButton2: UIButton!
    @IBOutlet weak var done2: UIButton!
    @IBOutlet weak var currencyLabel2: UILabel!
    
    @IBOutlet weak var currencyField2: UITextField!{
        didSet {
            currencyField2?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTapped1)))
        }
    }
    
    @IBOutlet weak var currencyPicker2: UIPickerView!
    
    @IBAction func currencyButton2Pressed(_ sender: Any) {
        currencyPicker2.isHidden = false
        currencyLabel2.isHidden = true
        done2.isHidden = false
        currencyField2.isHidden = true
    }
    
    @IBAction func done2Pressed(_ sender: Any) {
        currencyPicker2.isHidden=true
        currencyLabel2.isHidden=false
        currencyField2.isHidden=false
        done2.isHidden=true
        sleep(2)
        if (currencyLabel1.text == currencyLabel2.text){
            currencyField2.text = currencyField1.text
        }
        else{
            fetchValue()
        }
    }
    
    @objc func doneButtonTapped1() {
        if (currencyLabel1.text == currencyLabel2.text){
            currencyField2.text = currencyField1.text
        }
        else{
            fetchValue()
        }
        currencyField1.resignFirstResponder()
        currencyField2.resignFirstResponder()
    }
    
    var currencyData: [(currency: String, image: UIImage?)] = [("Select",UIImage(named: "add.png")),
                                                               ("AUD",UIImage(named: "aus.png")),
                                                               ("INR",UIImage(named: "india.png")),
                                                               ("USD",UIImage(named:"usa.png")),
                                                               
                                                               ("AED",UIImage(named: "abkhazia.png")),
                                                               ("AFN",UIImage(named: "afghanistan.png")),
                                                               ("ALL",UIImage(named: "aland-islands.png")),
                                                               ("AMD",UIImage(named: "albania.png")),
                                                               ("ANG",UIImage(named: "algeria.png")),
                                                               ("AOA",UIImage(named: "american-samoa.png")),
                                                               ("ARS",UIImage(named: "andorra.png")),
                                                               ("AWG",UIImage(named: "angola.png")),
                                                               ("AZN",UIImage(named: "antigua-and-barbuda.png")),
                                                               ("BAM",UIImage(named: "bahamas.png")),
                                                               ("BBD",UIImage(named: "bahrain.png")),
                                                               ("BDT",UIImage(named: "balearic-islands.png")),
                                                               ("BGN",UIImage(named: "bangladesh.png")),
                                                               ("BHD",UIImage(named: "bhd.png")),
                                                               ("BIF",UIImage(named: "bif.png"))]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInitialiser()
        self.currencyField1.delegate=self
        self.currencyField2.delegate=self
        currencyField2.text = String(Float(currencyField1!.text!)! * self.currentCurrencyValue)
        self.currencyField1.becomeFirstResponder()
        currencyField1.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            // scrollView.frame.size.height = self.view.frame.size.height
            //  self.scrollView.frame.origin.y -= keyboardSize.height + 40
            //self.view.frame.size.height = self.view.frame.size.height
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if (self.view.frame.origin.y != 0) {
            self.view.frame.origin.y = 0
        }
    }
    
    
    @objc func textFieldChanged(){
        do{
            try assignValue()
        }catch let error{
            print("\(error)")
         currencyField2.text = " "
        }
    }
    
    func assignValue() throws{
        if currencyField1.text != ""  {
            currencyField2.text =  String(Float(currencyField1!.text!)! * self.currentCurrencyValue)
        }
        else{
            throw error.nilError
        }
    }
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            currencyLabel1.text = currencyData[row].currency
            currencyButton1.setImage(currencyData[row].image, for: .normal)
        }
        if pickerView.tag == 2{
            currencyLabel2.text = currencyData[row].currency
            currencyButton2.setImage(currencyData[row].image, for: .normal)
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyData[row].currency
    }

    func viewInitialiser(){
        done1.isHidden = true
        done2.isHidden = true
        currencyPicker1.isHidden = true
        currencyPicker2.isHidden=true
        currencyLabel1.text = currencyData[1].currency
        currencyLabel2.text = currencyData[1].currency
        currencyButton1.setImage(currencyData[1].image, for: .normal)
        currencyButton2.setImage(currencyData[1].image, for: .normal)
        currencyField1.text = "1"
        currencyField2.text = String(self.currentCurrencyValue)
    }
    
    func fetchValue()
    {
        let day = Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
        let Date = dateFormatter.string(from: day!)

            let load1 = LoadCurrencyValues(base: self.currencyLabel1.text!, currencyLabel: self.currencyLabel2.text!, prevDate: Date )
            (self.currentCurrencyValue,self.previousCurrencyValue,self.percent) = load1.fetchLiveData()
           
        
        sleep(1)
         print("Here:  \(self.currentCurrencyValue)\n")
        self.currencyField2.text = String(Float(currencyField1!.text!)! * self.currentCurrencyValue)
        
    }

}
