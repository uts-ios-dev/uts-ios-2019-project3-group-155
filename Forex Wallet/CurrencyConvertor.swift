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
   
    var today = Date()
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
                                                               
                                                               ("BND",UIImage(named: "brunei.png")),
                                                               ("BOB",UIImage(named: "bolivia.png")),
                                                               ("BRL",UIImage(named: "brazil.png")),
                                                               ("BSD",UIImage(named: "bahamas.png")),
                                                               ("BTC",UIImage(named: "bhutan.png")),
                                                               ("BTN",UIImage(named: "bhutan-1.png")),
                                                               ("BWP",UIImage(named: "botswana.png")),
                                                               ("BYN",UIImage(named: "belarus.png")),
                                                               ("BYR",UIImage(named: "belarus.png")),
                                                               ("BZD",UIImage(named: "belize.png")),
                                                               ("CAD",UIImage(named: "canada.png")),
                                                               ("CDF",UIImage(named: "democratic-republic-of-congo.png")),
                                                               ("CHF",UIImage(named: "switzerland.png")),
                                                               ("CLF",UIImage(named: "chile.png")),
                                                               ("CLP",UIImage(named: "chile.png")),
                                                               ("CNY",UIImage(named: "china.png")),
                                                               ("COP",UIImage(named: "colombia.png")),
                                                               ("CRC",UIImage(named: "costa-rica.png")),
                                                               ("CUC",UIImage(named: "cuba.png")),
                                                               ("CUP",UIImage(named: "cuba.png")),
                                                               ("CVE",UIImage(named: "cape-verde.png")),
                                                               ("CZK",UIImage(named: "czech-republic.png")),
                                                               ("DJF",UIImage(named: "djibouti.png")),
                                                               ("DKK",UIImage(named: "denmark.png")),
                                                               ("DOP",UIImage(named: "dominican-republic.png")),
                                                               ("DZD",UIImage(named: "algeria.png")),
                                                               ("EGP",UIImage(named: "egypt.png")),
                                                               ("ERN",UIImage(named: "eritrea.png")),
                                                               ("ETB",UIImage(named: "ethiopia.png")),
                                                               ("EUR",UIImage(named: "European-union.png")),
                                                               ("FJD",UIImage(named: "fiji.png")),
                                                               ("FKP",UIImage(named: "falkland-islands.png")),
                                                               ("GBP",UIImage(named: "united-kingdom.png")),
                                                               ("GEL",UIImage(named: "georgia.png")),
                                                               ("GGP",UIImage(named: "guernsey.png")),
                                                               ("GHS",UIImage(named: "ghana.png")),
                                                               ("GIP",UIImage(named: "gibraltar.png")),
                                                               ("GMD",UIImage(named: "gambia.png")),
                                                               ("GNF",UIImage(named: "guinea.png")),
                                                               ("GTQ",UIImage(named: "guatemala.png")),
                                                               ("GYD",UIImage(named: "guyana.png")),
                                                               ("HKD",UIImage(named: "hong-kong.png")),
                                                               ("HNL",UIImage(named: "honduras.png")),
                                                               ("HRK",UIImage(named: "croatia.png")),
                                                               ("HTG",UIImage(named: "haiti.png")),
                                                               ("HUF",UIImage(named: "hungary.png")),
                                                               ("IDR",UIImage(named: "indonesia.png")),
                                                               ("ILS",UIImage(named: "israel.png")),
                                                               ("IMP",UIImage(named: "isle-of-man.png")),
                                                               
                                                               ("IQD",UIImage(named: "iraq.png")),
                                                               ("IRR",UIImage(named: "iran.png")),
                                                               ("ISK",UIImage(named: "iceland.png")),
                                                               ("JEP",UIImage(named: "jersey.png")),
                                                               ("JMD",UIImage(named: "jamaica.png")),
                                                               ("JOD",UIImage(named: "jordan.png")),
                                                               ("JPY",UIImage(named: "japan.png")),
                                                               ("KES",UIImage(named: "kenya.png")),
                                                               ("KGS",UIImage(named: "kyrgyzstan.png")),
                                                               ("KHR",UIImage(named: "cambodia.png")),
                                                               ("KMF",UIImage(named: "comoros.png")),
                                                               ("KPW",UIImage(named: "north-korea.png")),
                                                               ("KRW",UIImage(named: "south-korea.png")),
                                                               ("KWD",UIImage(named: "kuwait.png")),
                                                               ("KYD",UIImage(named: "cayman-islands.png")),
                                                               ("KZT",UIImage(named: "kazakhstan.png")),
                                                               ("LAK",UIImage(named: "laos.png")),
                                                               ("LBP",UIImage(named: "lebanon.png")),
                                                               ("LKR",UIImage(named: "sri-lanka.png")),
                                                               ("LRD",UIImage(named: "liberia.png")),
                                                               ("LSL",UIImage(named: "lesotho.png")),
                                                               ("LTL",UIImage(named: "lithuania.png")),
                                                               ("LVL",UIImage(named: "latvia.png")),
                                                               ("LYD",UIImage(named: "libya.png")),
                                                               ("MAD",UIImage(named: "morocco.png")),
                                                               ("MDL",UIImage(named: "moldova.png")),
                                                               ("MGA",UIImage(named: "madagascar.png")),
                                                               ("MKD",UIImage(named: "republic-of-macedonia.png")),
                                                               ("MMK",UIImage(named: "myanmar.png")),
                                                               ("MNT",UIImage(named: "mongolia.png")),
                                                               ("MOP",UIImage(named: "macao.png")),
                                                               ("MRO",UIImage(named: "mauritania.png")),
                                                               ("MUR",UIImage(named: "mauritius.png")),
                                                               ("MVR",UIImage(named: "maldives.png")),
                                                               ("MWK",UIImage(named: "malawi.png")),
                                                               ("MXN",UIImage(named: "mexico.png")),
                                                               ("MYR",UIImage(named: "malaysia.png")),
                                                               ("MZN",UIImage(named: "mozambique.png")),
                                                               ("NAD",UIImage(named: "namibia.png")),
                                                               ("NGN",UIImage(named: "nigeria.png")),
                                                               ("NIO",UIImage(named: "nicaragua.png")),
                                                               ("NOK",UIImage(named: "norway.png")),
                                                               ("NPR",UIImage(named: "nepal.png")),
                                                               ("NZD",UIImage(named: "new-zealand.png")),
                                                               ("OMR",UIImage(named: "oman.png")),
                                                               ("PAB",UIImage(named: "panama.png")),
                                                               ("PEN",UIImage(named: "peru.png")),
                                                               ("PGK",UIImage(named: "papua-new-guinea.png")),
                                                               ("PHP",UIImage(named: "philippines.png")),
                                                               ("PKR",UIImage(named: "pakistan.png")),
                                                               ("PLN",UIImage(named: "republic-of-poland.png")),
                                                               ("PYG",UIImage(named: "paraguay.png")),
                                                               ("QAR",UIImage(named: "qatar.png")),
                                                               ("RON",UIImage(named: "romania.png")),
                                                               ("RSD",UIImage(named: "serbia.png")),
                                                               ("RUB",UIImage(named: "russia.png")),
                                                               ("RWF",UIImage(named: "rwanda.png")),
                                                               ("SAR",UIImage(named: "saudi-arabia.png")),
                                                               ("SBD",UIImage(named: "solomon-islands.png")),
                                                               ("SCR",UIImage(named: "seychelles.png")),
                                                               ("SDG",UIImage(named: "sudan.png")),
                                                               ("SEK",UIImage(named: "sweden.png")),
                                                               ("SGD",UIImage(named: "singapore.png")),
                                                               ("SLL",UIImage(named: "sierra-leone.png")),
                                                               ("SOS",UIImage(named: "somalia.png")),
                                                               ("SRD",UIImage(named: "suriname.png")),
                                                               ("STD",UIImage(named: "sao-tome-and-principe.png")),
                                                               ("SVC",UIImage(named: "salvador.png")),
                                                               ("SYP",UIImage(named: "syria.png")),
                                                               ("SZL",UIImage(named: "swaziland.png")),
                                                               ("THB",UIImage(named: "thailand.png")),
                                                               ("TJS",UIImage(named: "tajikistan.png")),
                                                               ("TMT",UIImage(named: "turkmenistan.png")),
                                                               ("TND",UIImage(named: "tunisia.png")),
                                                               ("TOP",UIImage(named: "tonga.png")),
                                                               ("TRY",UIImage(named: "turkey.png")),
                                                               ("TTD",UIImage(named: "trinidad-and-tobago.png")),
                                                               ("TWD",UIImage(named: "taiwan.png")),
                                                               ("TZS",UIImage(named: "tanzania.png")),
                                                               ("UAH",UIImage(named: "ukraine.png")),
                                                               ("UGX",UIImage(named: "uganda.png")),
                                                               ("UYU",UIImage(named: "uruguay.png")),
                                                               ("UZS",UIImage(named: "uzbekistn.png")),
                                                               ("VEF",UIImage(named: "venezuela.png")),
                                                               ("VND",UIImage(named: "vietnam.png")),
                                                               ("VUV",UIImage(named: "vanuatu.png")),
                                                               ("WST",UIImage(named: "samoa.png")),
                                                               ("XPF",UIImage(named: "france.png")),
                                                               ("YER",UIImage(named: "yemen.png")),
                                                               ("ZAR",UIImage(named: "south-africa.png")),
                                                               ("ZMW",UIImage(named: "zambia.png")),
                                                               ("ZWL",UIImage(named: "zimbabwe.png")),
    ]
    
    
    
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
        
       // let day = Calendar.current.date(byAdding: .day, value: 0, to:Date)
        let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd"
        let Date = dateFormatter.string(from: today)

            let load1 = LoadCurrencyValues(base: self.currencyLabel1.text!, currencyLabel: self.currencyLabel2.text!, prevDate: Date )
            (self.currentCurrencyValue,self.previousCurrencyValue,self.percent) = load1.fetchLiveData()
           
        
        sleep(1)
         print("Here:  \(self.currentCurrencyValue)\n")
        self.currencyField2.text = String(Float(currencyField1!.text!)! * self.currentCurrencyValue)
        
    }

}
