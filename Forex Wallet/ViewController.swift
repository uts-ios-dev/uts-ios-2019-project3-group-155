//
//  ViewController.swift
//  Money Matter
//
//  Created by Aruna Sairam Manjunatha on 19/5/19.
//  Copyright © 2019 Aruna Sairam Manjunatha. All rights reserved.
//


import UIKit
import QuartzCore
struct Currency: Codable{
    var source: String = ""
    var quotes: [String:Float] = ["":0.0]
}

struct userCurrencyData: Codable {
    var uCurr: String
    var uBase: String
}
enum error: Error{
    case nilError
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var baseAmount: UITextField!
    @IBAction func dropDownArrow(_ sender: Any) {
        baseCurrencyPicker.isHidden=false
    }
    
    
    
    let networkStatus = CheckNetwork()
    
    let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())
    let dateFormatter = DateFormatter()
    var prevDate = ""
    
    
    @IBOutlet weak var stack1Gap: NSLayoutConstraint!
    
    @IBOutlet weak var stack2Gap: NSLayoutConstraint!
    
    
    @IBOutlet weak var stack3Gap: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var baseCurrencyHeading: UILabel!
    @IBOutlet weak var changeHeading: UILabel!
    
    @IBOutlet weak var currentValue1: UILabel!
    
    @IBOutlet weak var currentValue2: UILabel!
    
    @IBOutlet weak var currentValue3: UILabel!
 
    @IBOutlet weak var changeBaseButton: UITextField!
    
    
    @IBOutlet weak var refresh: UIButton!
    
    @IBAction func refreshButton(_ sender: Any) {
        refreshNow()
    }
    
    
    @IBOutlet weak var stack1PrevDateConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stack1CurrentDateConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stack2PrevDateConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stack2CurrentDateConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var stack3PrevDateConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stack3CurrentDateConstraint: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var convertedAmount1: UILabel!
    
    @IBOutlet weak var convertedAmount2: UILabel!
    
    @IBOutlet weak var convertedAmount3: UILabel!
    @IBOutlet weak var sampleBox: UILabel!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
    
    var myText = UITextField()
    var percent: Float = 0.0
    var baseCurrencyPicker = UIPickerView()
    var toolBar = UIToolbar()
    var doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
    var cancelButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(cancelClicked))
    
    var doneButton_Currency = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked_Currency))
    
    var cancelButton_Currency = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(cancelClicked_Currency))
    
   
     let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
     var toolBar_Currency = UIToolbar()
    
    var base: String = ""
    var selected: Bool = false
    var selected1: Bool = false
    var selected2: Bool = false
    var selected3: Bool = false
  
    var picker1Operatored = false
    var picker2Operatored = false
    var picker3Operatored = false
    var baseValue1: String = ""
    var baseValue2: String = ""
    var baseValue3: String = ""
    var date1: String = ""
    var date2: String = ""
    var date3: String = ""
    var textFieldTag = 0
    
    let myDatePicker1 = UIDatePicker()
    let myDatePicker2 = UIDatePicker()
    let myDatePicker3 = UIDatePicker()
   
    @IBOutlet weak var headerStack: UIStackView!
    
    @IBAction func i1Button(_ sender: Any) {
        if i1.alpha == 1{
            UIView.animate(withDuration: 0.25, animations: {
                self.i1.alpha=0;
            })
        }
        else if i1.alpha == 0{
            UIView.animate(withDuration: 0.25, animations: {
                
                self.i1.alpha=1;
                self.i2.alpha=0;
            })
        }
    }
    
    @IBOutlet weak var i1: UITextView!
    
    @IBOutlet weak var i2: UITextView!
    
    @IBAction func i2Button(_ sender: Any) {
        if i2.alpha == 1{
            UIView.animate(withDuration: 0.25, animations: {
                self.i2.alpha=0;
            })
        }
        else if i2.alpha == 0{
            UIView.animate(withDuration: 0.25, animations: {
                self.i2.alpha=1;
                self.i1.alpha=0
            })
        }
    }
    
    @IBOutlet weak var baseCurrency: UITextField!
    //@IBOutlet weak var mainActivityIndicator: UIActivityIndicatorView!
    
  
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.i1.alpha=0;
        })
        UIView.animate(withDuration: 0.25, animations: {
            self.i2.alpha=0;
        })
        super.touchesBegan(touches, with: event)
    }
    
 
    @IBOutlet weak var changeDate1: UITextField!
    
    @IBOutlet weak var changeDate2: UITextField!
    
    @IBOutlet weak var changeDate3: UITextField!
    
    @IBOutlet weak var timeStampC11: UILabel!
    
  
    @IBOutlet weak var previousDate1: UILabel!

    @IBOutlet weak var activityIndicator11: UIActivityIndicatorView!
    
    @IBOutlet weak var activityIndicator12: UIActivityIndicatorView!
    
    @IBOutlet weak var activityIndicator21: UIActivityIndicatorView!
    
    @IBOutlet weak var activityIndicator22: UIActivityIndicatorView!
    
    @IBOutlet weak var activityIndicator31: UIActivityIndicatorView!
    
    @IBOutlet weak var activityIndicator32: UIActivityIndicatorView!
    
    @IBOutlet weak var currencyButton1: UIButton!
    @IBOutlet weak var currencyPicker1: UIPickerView!
    @IBOutlet weak var done1: UIButton!
    @IBOutlet weak var currencyLabel1: UILabel!
    @IBOutlet weak var stackView1: UIStackView!
    
    
    @IBOutlet weak var previousValue1: UILabel!
    @IBOutlet weak var changePercent1: UIButton!
   
    
    @IBAction func button1Pressed(_ sender: Any) {
        dateFormatter.dateFormat = "MMM dd, yyyy"
        previousDate1.text = dateFormatter.string(from: previousDay!)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        date1 = dateFormatter.string(from: previousDay!)
        highlightCurrencyButtons(currencyButton1)
        timeStampC11.isHidden=true
        currencyPicker1.isHidden=false
        currencyLabel1.isHidden = true
        done1.isHidden=false
        stackView1.isHidden=true
        currentValue1.isHidden=true
        changePercent1.isHidden=true
    }
 
    @IBAction func done1Pressed(_ sender: Any) {
        done1Pressed()
    }
    
    
    
    
    @IBAction func changeDate2(_ sender: Any) {
    }
   
    @IBOutlet weak var previousDate2: UILabel!
    @IBOutlet weak var previousValue2: UILabel!
    @IBOutlet weak var timeStampC21: UILabel!
    @IBOutlet weak var currencyButton2: UIButton!
    @IBOutlet weak var currencyPicker2: UIPickerView!
    @IBOutlet weak var done2: UIButton!
    @IBOutlet weak var currencyLabel2: UILabel!
    @IBOutlet weak var stackView2: UIStackView!
   
    @IBOutlet weak var changePercent2: UIButton!
    
    @IBAction func button2Pressed(_ sender: Any) {
        dateFormatter.dateFormat = "MMM dd, yyyy"
        previousDate2.text = dateFormatter.string(from: previousDay!)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        date2 = dateFormatter.string(from: previousDay!)
        highlightCurrencyButtons(currencyButton2)
        timeStampC21.isHidden=true
        currencyPicker2.isHidden=false
        currencyLabel2.isHidden = true
        done2.isHidden=false
        stackView2.isHidden=true
        currentValue2.isHidden=true
        changePercent2.isHidden=true
    }
    
    @IBAction func done2Pressed(_ sender: Any) {
        done2Pressed()
        
    }
    
   
    
    @IBOutlet weak var timeStampC31: UILabel!
    @IBOutlet weak var changePercent3: UIButton!
    @IBAction func changeDate3(_ sender: Any) {
    }
    @IBOutlet weak var previousDate3: UILabel!
    @IBOutlet weak var previousValue3: UILabel!
    
    @IBOutlet weak var stackView3: UIStackView!
    @IBOutlet weak var currencyButton3: UIButton!
    @IBOutlet weak var currencyPicker3: UIPickerView!
    @IBOutlet weak var done3: UIButton!
    @IBOutlet weak var currencyLabel3: UILabel!
    
    
    @IBAction func button3Pressed(_ sender: Any) {
        dateFormatter.dateFormat = "MMM dd, yyyy"
        previousDate3.text = dateFormatter.string(from: previousDay!)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        date3 = dateFormatter.string(from: previousDay!)
        
        highlightCurrencyButtons(currencyButton3)
        timeStampC31.isHidden=true
        currencyPicker3.isHidden=false
        currencyLabel3.isHidden = true
        done3.isHidden=false
        stackView3.isHidden=true
        currentValue3.isHidden=true
        changePercent3.isHidden=true
    }
    @IBAction func done3Pressed(_ sender: Any) {
        done3Pressed()
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
                                                               ("INR",UIImage(named: "india.png")),
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
                                                               ("MNT",UIImage(named: "mongolia.png"))]
                                                               
                                                               

    

  
    
    // View Didload
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewsInitialiser()
        baseAmount.layer.cornerRadius = baseAmount.frame.size.height/2
        convertedAmount1.layer.masksToBounds=true
        convertedAmount1.layer.cornerRadius = convertedAmount1.frame.size.height/2
        convertedAmount2.layer.masksToBounds=true
        convertedAmount2.layer.cornerRadius = convertedAmount2.frame.size.height/2
        convertedAmount3.layer.masksToBounds=true
        convertedAmount3.layer.cornerRadius = convertedAmount3.frame.size.height/2
       
        baseAmount.addTarget(self, action: #selector(currencyConversion), for: .editingChanged)
        baseAmount.addTarget(self, action: #selector(initialiseConversion), for: .editingDidBegin)
        
        changeDate1.addTarget(self, action: #selector(showDatePicker1), for: .editingDidBegin)
        changeDate2.addTarget(self, action: #selector(showDatePicker2), for: .editingDidBegin)
        changeDate3.addTarget(self, action: #selector(showDatePicker3), for: .editingDidBegin)
        changeBaseButton.addTarget(self, action: #selector(showBaseCurrencyPicker), for: .editingDidBegin)
        baseCurrency.addTarget(self, action: #selector(showBaseCurrencyPicker), for: .editingDidBegin)
        
        self.loadUserData(){
                (success9) in
                if (success9){
                   self.LoadValues()
                }
        }

        if currencyLabel1.text != ""{
            currencyPicker1.selectRow(currencyData.firstIndex(where: {$0.currency == currencyLabel1.text})!, inComponent: 0, animated: true)
        }else{
            currencyPicker1.selectRow(0, inComponent: 0, animated: true)
        }
        
        if currencyLabel2.text != ""{
            currencyPicker2.selectRow(currencyData.firstIndex(where: {$0.currency == currencyLabel2.text})!, inComponent: 0, animated: true)
        }else{
            currencyPicker2.selectRow(0, inComponent: 0, animated: true)
        }
        
        if currencyLabel3.text != ""{
            currencyPicker3.selectRow(currencyData.firstIndex(where: {$0.currency == currencyLabel3.text})!, inComponent: 0, animated: true)
        }else{
            currencyPicker3.selectRow(0, inComponent: 0, animated: true)
        }
   
        if baseCurrency.text != ""{
            baseCurrencyPicker.selectRow(currencyData.firstIndex(where: {$0.currency == baseCurrency.text})!, inComponent: 0, animated: true)
        }else{
             baseCurrencyPicker.selectRow(0, inComponent: 0, animated: true)
        }
        enableCurrencyButtons()
        baseCurrencyPicker.delegate=self
        baseCurrencyPicker.dataSource=self
        baseCurrencyPicker.tag = 4
        baseCurrency.inputView = baseCurrencyPicker
    }
    
    
    
    
    
     func refreshNow() {
      
        refresh.isHidden = true
        refresh.isEnabled = false
        refreshActivityIndicator.startAnimating()
          doneClicked()
    }
    
    @objc func showBaseCurrencyPicker(){
        currencyButton1.isEnabled = false
        currencyButton2.isEnabled = false
        currencyButton3.isEnabled = false
        changeDate1.isEnabled = false
        changeDate2.isEnabled = false
        changeDate3.isEnabled = false
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        refresh.isEnabled=false
        
        toolBar.setItems([cancelButton,spaceButton,doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
        toolBar.barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        baseCurrency.inputAccessoryView = toolBar
        changeBaseButton.inputAccessoryView = toolBar
        baseCurrency.inputView = baseCurrencyPicker
        changeBaseButton.inputView = baseCurrencyPicker
    }
    
    
    @objc func doneClicked(){
        currencyButton1.isEnabled = true
        currencyButton2.isEnabled = true
        currencyButton3.isEnabled = true
        changeDate1.isEnabled = true
        changeDate2.isEnabled = true
        changeDate3.isEnabled = true
        refresh.isEnabled=true
        baseCurrency.endEditing(true)
        changeBaseButton.endEditing(true)
        enableCurrencyButtons()
        baseValue1=baseCurrency.text!
        baseValue2=baseCurrency.text!
        baseValue3=baseCurrency.text!
        let userData4: [userCurrencyData] = [
            userCurrencyData(uCurr: currencyLabel1.text!, uBase: baseCurrency.text!),
            userCurrencyData(uCurr: currencyLabel2.text!, uBase: baseCurrency.text!),
            userCurrencyData(uCurr: currencyLabel3.text!, uBase: baseCurrency.text!)
        ]
        UserDefaults.standard.set(try? PropertyListEncoder().encode(userData4), forKey:"userCurrencyData")
        if (networkStatus.connectedToNetwork()){
            LoadValues()
        }
        else{
            let alert = UIAlertController(title: "Network Error", message: "Please check your network and try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                }}))
            refreshActivityIndicator.stopAnimating()
            refresh.isHidden=false
            refresh.isEnabled = true
            self.present(alert, animated: true, completion: nil)
        }
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        
    }
    
    @objc func cancelClicked(){
        currencyButton1.isEnabled = true
        currencyButton2.isEnabled = true
        currencyButton3.isEnabled = true
        changeDate1.isEnabled = true
        changeDate2.isEnabled = true
        changeDate3.isEnabled = true
        baseCurrency.endEditing(true)
        changeBaseButton.endEditing(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        refresh.isEnabled=true
        
    }
    
    
    @objc func currencyConversion(){
       
        do{
            try assignValue()
        }catch let error{
        print("\(error)")
            convertedAmount1.text = "0.0" + "  " + currencyLabel1.text!
            convertedAmount2.text = "0.0" + "  " + currencyLabel2.text!
            convertedAmount3.text = "0.0" + "  " + currencyLabel3.text!
        }
    }
    
    @objc func initialiseConversion(){
        changeDate1.isEnabled=false
        changeDate2.isEnabled=false
        changeDate3.isEnabled=false
        currencyButton1.isEnabled=false
        currencyButton2.isEnabled=false
        currencyButton3.isEnabled=false
    }
    
    func assignValue() throws{
        if baseAmount.text != ""  {
            convertedAmount1.text =  String(format: "%0.3f", Float(baseAmount!.text!)! * Float(currentValue1!.text!)!) + "  " + currencyLabel1.text!
            print(convertedAmount1.text!)
            convertedAmount2.text =  String(format: "%0.3f", Float(baseAmount!.text!)! * Float(currentValue2!.text!)!) + "  " + currencyLabel2.text!
            convertedAmount3.text =  String(format: "%0.3f", Float(baseAmount!.text!)! * Float(currentValue3!.text!)!) + "  " + currencyLabel3.text!
            
        }
        else{
            throw error.nilError
        }
    }
    
    @objc func doneClicked_Currency(){
        currencyButton1.isEnabled = true
        currencyButton2.isEnabled = true
        currencyButton3.isEnabled = true
        changeDate1.isEnabled = true
        changeDate2.isEnabled = true
        changeDate3.isEnabled = true
        baseCurrency.endEditing(true)
       baseAmount.endEditing(true)
       // self.navigationController?.hidesBarsWhenKeyboardAppears=false
     //   self.navigationController?.isNavigationBarHidden=false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        refresh.isEnabled=true
        
    }
    
    @objc func cancelClicked_Currency(){
        currencyButton1.isEnabled = true
        currencyButton2.isEnabled = true
        currencyButton3.isEnabled = true
        changeDate1.isEnabled = true
        changeDate2.isEnabled = true
        changeDate3.isEnabled = true
        baseCurrency.endEditing(true)
        baseAmount.endEditing(true)
         self.navigationController?.setNavigationBarHidden(false, animated: true)
        refresh.isEnabled=true
        
    }
    
    
    func LoadValues(){
        if (networkStatus.connectedToNetwork()){
        if (currencyLabel1.text!) == ""{
            currencyLabel1.isHidden = true
            previousDate1.isHidden = true
            changeDate1.isHidden = true
            stack1PrevDateConstraint.constant=0
            stack1CurrentDateConstraint.constant=0
           
        }
        else{
            selected1=true
            done1Pressed()
        }
        
        if (currencyLabel2.text!) == ""{
            currencyLabel2.isHidden = true
            previousDate2.isHidden = true
            changeDate2.isHidden = true
            stack2PrevDateConstraint.constant=0
            stack2CurrentDateConstraint.constant=0
        }
        else{
            selected2=true
            done2Pressed()
        }
        
        if (currencyLabel3.text!) == ""{
            currencyLabel3.isHidden = true
            previousDate3.isHidden = true
            changeDate3.isHidden = true
            stack3PrevDateConstraint.constant=0
            stack3CurrentDateConstraint.constant=0
        }
        else{
            selected3=true
            done3Pressed()
        }
        }
        else{
            let alert = UIAlertController(title: "Network Error", message: "Please check your network and try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
             refreshActivityIndicator.stopAnimating()
            refresh.isHidden=false
              refresh.isEnabled = true
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
  
    
    func loadUserData(completion: @escaping (Bool) -> Void){
        var success9: Bool  = false
        if let fetchedData = UserDefaults.standard.value(forKey:"userCurrencyData") as? Data {
            let decodedData = try? PropertyListDecoder().decode(Array<userCurrencyData>.self, from: fetchedData)
                     if let uCurr1 = decodedData?[0].uCurr {
                        baseCurrency.text = decodedData?[0].uBase
                        baseValue1 = baseCurrency.text!
                      
                        currencyLabel1.text = uCurr1
                        if uCurr1 != ""{
                            for i in 0..<currencyData.count{
                                if uCurr1 == currencyData[i].currency{
                                    currencyButton1.setImage(currencyData[i].image, for: .normal)
                                }
                            }
                            
                        }
                        currencyButton1.isEnabled = true
                    }
                    if let uCurr2 = decodedData?[1].uCurr {
                        baseCurrency.text = decodedData?[1].uBase
                        baseValue2 = baseCurrency.text!
                     
                        currencyLabel2.text = uCurr2

                        if uCurr2 != ""{
                            for i in 0..<currencyData.count{
                                if uCurr2 == currencyData[i].currency{
                                    currencyButton2.setImage(currencyData[i].image, for: .normal)
                                }
                            }
                        }
                        currencyButton2.isEnabled = true
                    }
               
                    if let uCurr3 = decodedData?[2].uCurr {
                
                        baseCurrency.text = decodedData?[2].uBase
                        baseValue3 = baseCurrency.text!
                      
                        currencyLabel3.text = uCurr3

                        if uCurr3 != ""{
                            for i in 0..<currencyData.count{
                                if uCurr3 == currencyData[i].currency{
                                    currencyButton3.setImage(currencyData[i].image, for: .normal)
                                }
                            }
                        }
                        currencyButton3.isEnabled = true
                       success9 = true
                       completion(success9)
                    }
            
            }
    }
    
    
    func setTime(_ timeStamp: UILabel){
        timeStamp.isHidden = false
        timeStamp.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
    }
    

    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return currencyData.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = currencyData[row].currency
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Helvetica", size: 17.0)!,NSAttributedString.Key.foregroundColor:UIColor.white])
        return myTitle
    }
    
  
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1{
            currencyLabel1.text=currencyData[row].currency
            picker1Operatored=true
            if currencyLabel1.text == "Select"{
                currencyLabel1.text=""
                selected1 = false
            }
            else{
                selected1 = true
            }
            currencyButton1.setImage(currencyData[row].image!,for: .normal)
            currencyButton1.isHighlighted=false
         
        }
        else if pickerView.tag == 2{
            currencyLabel2.text=currencyData[row].currency
            picker2Operatored=true
            if currencyLabel2.text == "Select"{
                currencyLabel2.text=""
                selected2 = false
            }
            else{
                selected2 = true
            }
            currencyButton2.setImage(currencyData[row].image!,for: .normal)
            currencyButton2.isHighlighted=false
          
          
        }
        else if pickerView.tag == 3 {
            currencyLabel3.text=currencyData[row].currency
            picker3Operatored=true
            if currencyLabel3.text == "Select"{
                currencyLabel3.text=""
                selected3 = false
            }
            else{
                selected3 = true
            }
            currencyButton3.setImage(currencyData[row].image!,for: .normal)
            currencyButton3.isHighlighted=false
            
           
        }
        else if pickerView.tag == 4{
            
            baseCurrency.text = currencyData[row].currency
            if baseCurrency.text == "Select"{
                doneButton.isEnabled=false
                cancelButton.isEnabled=false
                currencyButton1.isEnabled = false
                currencyButton2.isEnabled = false
                currencyButton3.isEnabled = false
                
            }
            else{
                doneButton.isEnabled=true
                cancelButton.isEnabled=true
                currencyButton1.isEnabled = true
                currencyButton2.isEnabled = true
                currencyButton3.isEnabled = true
            }
            
            
        }
        else{
            print("Error: Unable to invoke Picker")
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return currencyData[row].currency
    }
    
    
    
    
   
    
    func displayActivityIndicator(_ state: Bool){
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center.y = self.view.center.y+40
        activityIndicator.center.x = self.view.center.x
        activityIndicator.style = .gray
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        if (state){
            activityIndicator.startAnimating()
        }else{
            activityIndicator.stopAnimating()
        }
    }
    
    func viewsInitialiser(){
        currencyButton1.isEnabled = false
        currencyButton2.isEnabled = false
        currencyButton3.isEnabled = false
        done1.isHidden=true
        done2.isHidden=true
        done3.isHidden=true
        currencyPicker1.isHidden=true
        currencyPicker2.isHidden=true
        currencyPicker3.isHidden=true
        previousDate1.isHidden=true
        previousDate2.isHidden=true
        previousDate3.isHidden=true
        changeDate1.isHidden=true
        changeDate2.isHidden=true
        changeDate3.isHidden=true
        
        myDatePicker1.maximumDate = Date()
        myDatePicker2.maximumDate = Date()
        myDatePicker3.maximumDate = Date()
        i1.alpha = 0
        i2.alpha = 0
        
        i1.layer.cornerRadius = 5
        i2.layer.cornerRadius = 5
//        doneButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        cancelButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        toolBar.barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        baseCurrencyPicker.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        myDatePicker1.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        myDatePicker2.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        myDatePicker3.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
      
        baseCurrency.text = currencyData[1].currency
        currentValue1.text = "0.0"
        currentValue2.text = "0.0"
        currentValue3.text = "0.0"
        previousValue1.text = "0.0"
        previousValue2.text = "0.0"
        previousValue3.text = "0.0"
        convertedAmount1.text = "0.0" + "  " + currencyLabel1.text!
        convertedAmount2.text = "0.0" + "  " + currencyLabel2.text!
        convertedAmount3.text = "0.0" + "  " + currencyLabel3.text!
        baseCurrency.borderStyle = .none
        
        changePercent1.layer.cornerRadius = 5
        changePercent1.setTitle(" 0.00% ", for: .normal)
        changePercent1.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        changePercent2.layer.cornerRadius = 5
        changePercent2.setTitle(" 0.00% ", for: .normal)
        changePercent2.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
     
        changePercent3.layer.cornerRadius = 5
        changePercent3.setTitle(" 0.00% ", for: .normal)
       changePercent3.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        prevDate = dateFormatter.string(from: previousDay!)
        usleep(10000)
        previousDate1.text = dateFormatter.string(from: previousDay!)
        previousDate2.text = dateFormatter.string(from: previousDay!)
        previousDate3.text = dateFormatter.string(from: previousDay!)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        date1 = dateFormatter.string(from: previousDay!)
        date2 = dateFormatter.string(from: previousDay!)
        date3 = dateFormatter.string(from: previousDay!)
        if baseCurrency.text == "Select"{
            doneButton.isEnabled=false
            cancelButton.isEnabled=false
            currencyButton1.isEnabled = false
            currencyButton2.isEnabled = false
            currencyButton3.isEnabled = false
            
        }
        
        toolBar_Currency.setItems([cancelButton_Currency,spaceButton,doneButton_Currency], animated: true)
        toolBar_Currency.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        toolBar_Currency.sizeToFit()
        toolBar_Currency.isUserInteractionEnabled = true
        baseAmount.inputAccessoryView=toolBar_Currency
        
        
        
  
    }
    
    func enableCurrencyButtons(){
        if baseCurrency.text != "Select"{
            currencyButton1.isEnabled = true
            currencyButton2.isEnabled = true
            currencyButton3.isEnabled = true
        }
        else{
            currencyButton1.isEnabled = false
            currencyButton2.isEnabled = false
            currencyButton3.isEnabled = false
        }
    }

    
   
  
    
    func formatButton(_ button: UIButton?, _ percentage: Float, _ timeStamp: UILabel?){
        button?.layer.cornerRadius = 5
        
        if percentage < 0 {
            button?.setTitle(" "+String(format: "%.2f", percentage)+"% "+" ", for: .normal)
            button?.layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            button?.layer.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
          
            button?.isHidden=false
        }
        else if percentage >= 0.005{
            button?.setTitle(" +"+String(format: "%.2f", percentage)+"% "+" ", for: .normal)
            button?.layer.borderColor = #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1)
            button?.layer.backgroundColor = #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1)
        
            button?.isHidden=false
        }
        else{
            button?.setTitle(" "+String(format: "%.2f", percentage)+"% "+" ", for: .normal)
            button?.layer.borderColor = #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1)
            button?.layer.backgroundColor = #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1)
           
            button?.isHidden=false
        }
    }
    
    func highlightCurrencyButtons(_ currencyButton: UIButton?){
        DispatchQueue.main.async {
            currencyButton!.isHighlighted = true
        }
    }
    func deHighlightCurrencyButtons(_ currencyButton: UIButton?){
        DispatchQueue.main.async {
            currencyButton!.isHighlighted = false
        }
    }
    
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
        
            self.view.frame.origin.y -= keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if (self.view.frame.origin.y != 0) {
             self.view.frame.origin.y = 0
        }
    }
    
    
    
    @objc func showDatePicker1(){
        changeDate2.isEnabled = false
        changeDate3.isEnabled = false
        currencyButton1.isEnabled = false
        currencyButton2.isEnabled = false
        currencyButton3.isEnabled = false
       
        myDatePicker1.datePickerMode = .date
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
       
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("doneDatePicker1")))

        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("cancelDatePicker1")))
        
        toolBar.setItems([cancel,spaceButton,doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
//        doneButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        cancel.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        toolBar.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        let datePickerColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        myDatePicker1.setValue(datePickerColor, forKey: "textColor")
        changeDate1.inputAccessoryView = toolBar
        changeDate1.inputView = myDatePicker1
       
       
    }
     @objc func doneDatePicker1(){
        changeDate2.isEnabled = true
        changeDate3.isEnabled = true
        currencyButton1.isEnabled = true
        currencyButton2.isEnabled = true
        currencyButton3.isEnabled = true
            let myDateFormatter = DateFormatter()
            myDateFormatter.dateFormat = "yyyy-MM-dd"
            date1 = myDateFormatter.string(from: myDatePicker1.date)
            myDateFormatter.dateFormat = "MMM dd, yyyy"
            previousDate1.text = myDateFormatter.string(from: myDatePicker1.date)
            changeDate1.resignFirstResponder()
            done1Pressed()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    @objc func cancelDatePicker1(){
        changeDate2.isEnabled = true
        changeDate3.isEnabled = true
        currencyButton1.isEnabled = true
        currencyButton2.isEnabled = true
        currencyButton3.isEnabled = true
            changeDate1.resignFirstResponder()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    @objc func showDatePicker2(){
        changeDate1.isEnabled = false
        changeDate3.isEnabled = false
        currencyButton1.isEnabled = false
        currencyButton2.isEnabled = false
        currencyButton3.isEnabled = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        myDatePicker2.datePickerMode = .date
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("doneDatePicker2")))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("cancelDatePicker2")))
        
        toolBar.setItems([cancel,spaceButton,doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
//        doneButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        cancel.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        toolBar.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        let datePickerColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        myDatePicker2.setValue(datePickerColor, forKey: "textColor")
        changeDate2.inputAccessoryView = toolBar
        changeDate2.inputView = myDatePicker2
        
        
    }
    @objc func doneDatePicker2(){
        changeDate1.isEnabled = true
        changeDate3.isEnabled = true
        currencyButton1.isEnabled = true
        currencyButton2.isEnabled = true
        currencyButton3.isEnabled = true
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy-MM-dd"
        date2 = myDateFormatter.string(from: myDatePicker2.date)
        myDateFormatter.dateFormat = "MMM dd, yyyy"
        previousDate2.text = myDateFormatter.string(from: myDatePicker2.date)
        done2Pressed()
        changeDate2.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func cancelDatePicker2(){
        changeDate1.isEnabled = true
        changeDate3.isEnabled = true
        currencyButton1.isEnabled = true
        currencyButton2.isEnabled = true
        currencyButton3.isEnabled = true
        changeDate2.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc func showDatePicker3(){
        changeDate1.isEnabled = false
        changeDate2.isEnabled = false
        currencyButton1.isEnabled = false
        currencyButton2.isEnabled = false
        currencyButton3.isEnabled = false
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        myDatePicker3.datePickerMode = .date
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("doneDatePicker3")))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let cancel = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: Selector(("cancelDatePicker3")))
        
        toolBar.setItems([cancel,spaceButton,doneButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        
//        doneButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        cancel.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        toolBar.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        let datePickerColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        myDatePicker3.setValue(datePickerColor, forKey: "textColor")
        
        changeDate3.inputAccessoryView = toolBar
        changeDate3.inputView = myDatePicker3
        
    }
    @objc func doneDatePicker3(){
        changeDate1.isEnabled = true
        changeDate2.isEnabled = true
        currencyButton1.isEnabled = true
        currencyButton2.isEnabled = true
        currencyButton3.isEnabled = true
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "yyyy-MM-dd"
        date3 = myDateFormatter.string(from: myDatePicker3.date)
        myDateFormatter.dateFormat = "MMM dd, yyyy"
        previousDate3.text = myDateFormatter.string(from: myDatePicker3.date)
        done3Pressed()
        changeDate3.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
       
    }
    
    @objc func cancelDatePicker3(){
        changeDate1.isEnabled = true
        changeDate2.isEnabled = true
        currencyButton1.isEnabled = true
        currencyButton2.isEnabled = true
        currencyButton3.isEnabled = true
        changeDate3.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func done1Pressed(){

            if (selected1){
                
               
                activityIndicator11.startAnimating()
                activityIndicator12.startAnimating()
                
                currencyPicker1.isHidden = true
                deHighlightCurrencyButtons(currencyButton1)
                let userData1: [userCurrencyData] = [
                    userCurrencyData(uCurr: currencyLabel1.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel2.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel3.text!, uBase: baseCurrency.text!)
                ]
                UserDefaults.standard.set(try? PropertyListEncoder().encode(userData1), forKey:"userCurrencyData")
                currencyPicker1.isHidden = true
                done1.isHidden=true
                currencyLabel1.isHidden = false
                self.stackView1.isHidden=false
                self.timeStampC11.isHidden=true
                self.previousDate1.isHidden=true
                self.changeDate1.isHidden = true
               // self.changePercent1.setTitle("---  ", for: .normal)
                self.convertedAmount1.text = "0.0"
                changePercent1.isHidden=false
                self.currentValue1.isHidden=true
                previousValue1.isHidden = true
                stack1PrevDateConstraint.constant=0
                stack1CurrentDateConstraint.constant=0
                usleep(100000)
                if (networkStatus.connectedToNetwork()){
                DispatchQueue.main.async {
                    var cValue1: Float = 0.0
                    var pValue1: Float = 0.0
                    var cPercent1: Float = 0.0
                    let loadCurrencyValue1 = LoadCurrencyValues(base: self.baseCurrency.text!, currencyLabel: self.currencyLabel1.text!, prevDate: self.date1)
                   
                   
                    while (cValue1 == 0 || pValue1 == 0){
                        (cValue1,pValue1,cPercent1) = loadCurrencyValue1.fetchLiveData()
                    }
                    self.currentValue1.text = String(format: "%.4f",cValue1)
                    self.previousValue1.text = String(format: "%.4f",pValue1)
                    usleep(500000)
                    self.currencyConversion()
                  
                    
                    self.formatButton(self.changePercent1, cPercent1, self.timeStampC11)
                    self.setTime(self.timeStampC11)
                    self.previousDate1.isHidden=false
                    self.changeDate1.isHidden=false
                    self.currentValue1.isHidden=false
                    self.previousValue1.isHidden=false
                    self.stack1PrevDateConstraint.constant=17
                    self.stack1CurrentDateConstraint.constant=17
                    self.activityIndicator11.stopAnimating()
                    self.activityIndicator12.stopAnimating()
                    self.refreshActivityIndicator.stopAnimating()
                    self.refresh.isHidden=false
                    self.refresh.isEnabled = true
                    
                }
                }
                else{
                    let alert = UIAlertController(title: "Network Error", message: "Please check your network and try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                    self.activityIndicator11.stopAnimating()
                    self.activityIndicator12.stopAnimating()
                    self.refreshActivityIndicator.stopAnimating()
                    self.refresh.isHidden=false
                    self.present(alert, animated: true, completion: nil)
                     self.refresh.isEnabled = true
                }
                
            }
            else{
                currentValue1.text = "0.0"
                previousValue1.text = "0.0"
                currencyLabel1.isHidden = true
                currentValue1.isHidden = false
                changePercent1.isHidden = true
                currencyPicker1.isHidden = true
                timeStampC11.isHidden=true
                previousDate1.isHidden = true
                changeDate1.isHidden = true
                stack1PrevDateConstraint.constant=0
                stack1CurrentDateConstraint.constant=0
                changePercent1.isHidden = false
                changePercent1.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                changePercent1.setTitle("0.0%", for: .normal)
                previousValue1.isHidden = false
                done1.isHidden=true
                currencyLabel1.text=""
                stackView1.isHidden=false
                deHighlightCurrencyButtons(currencyButton1)
                let userData1: [userCurrencyData] = [
                    userCurrencyData(uCurr: currencyLabel1.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel2.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel3.text!, uBase: baseCurrency.text!)
                ]
                UserDefaults.standard.set(try? PropertyListEncoder().encode(userData1), forKey:"userCurrencyData")
                self.activityIndicator11.stopAnimating()
                self.activityIndicator12.stopAnimating()
                self.refreshActivityIndicator.stopAnimating()
                self.refresh.isHidden=false
                 self.refresh.isEnabled = true
                usleep(500000)
                self.currencyConversion()
            }
 
        
    }
    
    
    func done2Pressed(){

            if (selected2){
             
                activityIndicator21.startAnimating()
                activityIndicator22.startAnimating()
                
                currencyPicker2.isHidden = true
                deHighlightCurrencyButtons(currencyButton2)
                let userData2: [userCurrencyData] = [
                    userCurrencyData(uCurr: currencyLabel1.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel2.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel3.text!, uBase: baseCurrency.text!)
                ]
                UserDefaults.standard.set(try? PropertyListEncoder().encode(userData2), forKey:"userCurrencyData")
                currencyPicker2.isHidden = true
                done2.isHidden=true
                currencyLabel2.isHidden = false
                self.stackView2.isHidden=false
                self.timeStampC21.isHidden=true
                self.previousDate2.isHidden=true
                stack2PrevDateConstraint.constant=0
                stack2CurrentDateConstraint.constant=0
                self.changeDate2.isHidden = true
               //self.changePercent2.setTitle("---  ", for: .normal)
                 self.convertedAmount2.text = "0.0"
                changePercent2.isHidden=false
                self.currentValue2.isHidden=true
                previousValue2.isHidden=true
                usleep(100000)
                if (networkStatus.connectedToNetwork()){
                DispatchQueue.main.async {
                    var cValue2: Float = 0.0
                    var pValue2: Float = 0.0
                    var cPercent2: Float = 0.0
                    let loadCurrencyValue2 = LoadCurrencyValues(base: self.baseCurrency.text!, currencyLabel: self.currencyLabel2.text!, prevDate: self.date2)
                   
                    while (cValue2 == 0 || pValue2 == 0){
                        (cValue2,pValue2,cPercent2) = loadCurrencyValue2.fetchLiveData()
                    }
                    self.currentValue2.text = String(format: "%.4f",cValue2)
                    self.previousValue2.text = String(format: "%.4f",pValue2)
                    usleep(500000)
                    self.currencyConversion()
                    self.formatButton(self.changePercent2, cPercent2, self.timeStampC21)
                    self.setTime(self.timeStampC21)
                    self.previousDate2.isHidden=false
                    self.changeDate2.isHidden=false
                    self.currentValue2.isHidden=false
                    self.previousValue2.isHidden=false
                    self.stack2PrevDateConstraint.constant=17
                    self.stack2CurrentDateConstraint.constant=17
                    
         
                    self.activityIndicator21.stopAnimating()
                    self.activityIndicator22.stopAnimating()
                    self.refreshActivityIndicator.stopAnimating()
                    self.refresh.isHidden=false
                     self.refresh.isEnabled = true
                }
                }
                else{
                    let alert = UIAlertController(title: "Network Error", message: "Please check your network and try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                    self.activityIndicator21.stopAnimating()
                    self.activityIndicator22.stopAnimating()
                    self.refreshActivityIndicator.stopAnimating()
                    self.refresh.isHidden=false
                    self.present(alert, animated: true, completion: nil)
                     self.refresh.isEnabled = true
                }
                
            }
                
            else{
                currentValue2.text = "0.0"
                previousValue2.text = "0.0"
                currencyLabel2.isHidden = true
                currentValue2.isHidden = false
                changePercent2.isHidden = true
                currencyPicker2.isHidden = true
                done2.isHidden=true
                currencyLabel2.text=""
                previousDate2.isHidden = true
                changeDate2.isHidden = true
                stack2PrevDateConstraint.constant=0
                stack2CurrentDateConstraint.constant=0
                changePercent2.isHidden = false
                changePercent2.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                changePercent2.setTitle("0.0%", for: .normal)
                previousValue2.isHidden = false
                stackView2.isHidden=false
                deHighlightCurrencyButtons(currencyButton2)
                let userData2: [userCurrencyData] = [
                    userCurrencyData(uCurr: currencyLabel1.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel2.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel3.text!, uBase: baseCurrency.text!)
                ]
                UserDefaults.standard.set(try? PropertyListEncoder().encode(userData2), forKey:"userCurrencyData")
                self.activityIndicator11.stopAnimating()
                self.activityIndicator12.stopAnimating()
                self.refreshActivityIndicator.stopAnimating()
                self.refresh.isHidden=false
                 self.refresh.isEnabled = true
                usleep(500000)
                self.currencyConversion()
            }

    }
    
    func done3Pressed(){

            if (selected3){
                activityIndicator31.startAnimating()
                activityIndicator32.startAnimating()
                
                currencyPicker3.isHidden = true
                deHighlightCurrencyButtons(currencyButton3)
                let userData3: [userCurrencyData] = [
                    userCurrencyData(uCurr: currencyLabel1.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel2.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel3.text!, uBase: baseCurrency.text!)
                ]
                UserDefaults.standard.set(try? PropertyListEncoder().encode(userData3), forKey:"userCurrencyData")
                currencyPicker3.isHidden = true
                done3.isHidden=true
                currencyLabel3.isHidden = false
                self.stackView3.isHidden=false
                self.timeStampC31.isHidden=true
                self.previousDate3.isHidden=true
                stack3PrevDateConstraint.constant=0
                stack3CurrentDateConstraint.constant=0
                self.changeDate3.isHidden=true
               //self.changePercent3.setTitle("---  ", for: .normal)
                 self.convertedAmount3.text = "0.0"
                changePercent3.isHidden=false
                self.currentValue3.isHidden=true
                previousValue3.isHidden=true
                usleep(100000)
                if (networkStatus.connectedToNetwork()){
                DispatchQueue.main.async {
                    var cValue3: Float = 0.0
                    var pValue3: Float = 0.0
                    var cPercent3: Float = 0.0
                    let loadCurrencyValue3 = LoadCurrencyValues(base: self.baseCurrency.text!, currencyLabel: self.currencyLabel3.text!, prevDate: self.date3)
                  
                    while (cValue3 == 0 || pValue3 == 0){
                        (cValue3,pValue3,cPercent3) = loadCurrencyValue3.fetchLiveData()
                    }
                    self.currentValue3.text = String(format: "%.4f",cValue3)
                    self.previousValue3.text = String(format: "%.4f",pValue3)
                    usleep(500000)
                    self.currencyConversion()
                    self.formatButton(self.changePercent3, cPercent3, self.timeStampC31)
                    self.setTime(self.timeStampC31)
                    self.previousDate3.isHidden=false
                    self.changeDate3.isHidden=false
                    self.currentValue3.isHidden=false
                    self.previousValue3.isHidden=false
                    self.stack3PrevDateConstraint.constant=17
                    self.stack3CurrentDateConstraint.constant=17
                    self.activityIndicator31.stopAnimating()
                    self.activityIndicator32.stopAnimating()
                    self.refreshActivityIndicator.stopAnimating()
                    self.refresh.isHidden=false
                     self.refresh.isEnabled = true
                    
                }
                }
                else{
                    let alert = UIAlertController(title: "Network Error", message: "Please check your network and try again", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        switch action.style{
                        case .default:
                            print("default")
                            
                        case .cancel:
                            print("cancel")
                            
                        case .destructive:
                            print("destructive")
                            
                            
                        }}))
                    self.activityIndicator31.stopAnimating()
                    self.activityIndicator32.stopAnimating()
                    self.refreshActivityIndicator.stopAnimating()
                    self.refresh.isHidden=false
                     self.refresh.isEnabled = true
                    self.present(alert, animated: true, completion: nil)
                }
               
            }
            else{
                currentValue3.text = "0.0"
                previousValue3.text = "0.0"
                currencyLabel3.isHidden = true
                currentValue3.isHidden = false
                changePercent3.isHidden = true
                currencyPicker3.isHidden = true
                done3.isHidden=true
                currencyLabel3.text=""
                previousDate3.isHidden = true
                changeDate3.isHidden = true
                previousValue3.isHidden = false
                stack3PrevDateConstraint.constant=0
                stack3CurrentDateConstraint.constant=0
                changePercent3.isHidden = false
                changePercent3.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                changePercent3.setTitle("0.0%", for: .normal)
                stackView3.isHidden=false
                deHighlightCurrencyButtons(currencyButton3)
                let userData3: [userCurrencyData] = [
                    userCurrencyData(uCurr: currencyLabel1.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel2.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel3.text!, uBase: baseCurrency.text!)
                ]
                UserDefaults.standard.set(try? PropertyListEncoder().encode(userData3), forKey:"userCurrencyData")
                self.activityIndicator11.stopAnimating()
                self.activityIndicator12.stopAnimating()
                self.refreshActivityIndicator.stopAnimating()
                self.refresh.isHidden=false
                 self.refresh.isEnabled = true
                usleep(500000)
                self.currencyConversion()
            }

    }
}



