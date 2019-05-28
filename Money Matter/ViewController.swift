//
//  ViewController.swift
//  Money Matter
//
//  Created by Aruna Sairam Manjunatha on 19/5/19.
//  Copyright © 2019 Aruna Sairam Manjunatha. All rights reserved.
//


import UIKit

struct Currency: Codable{
    var source: String = ""
    var quotes: [String:Float] = ["":0.0]
}

struct userCurrencyData: Codable {
    var uCurr: String
    var uBase: String
}


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var currentCurrencyName = ""
    var currentCurrencyValue: Float = 0.000
    var prevCurrencyName = ""
    var prevCurrencyValue: Float = 0.000
    var percent: Float = 0.0
    var baseCurrencyPicker = UIPickerView()
    var toolBar = UIToolbar()
    var doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneClicked))
    var base: String = ""
    var selected: Bool = false
    var removed1: Bool = false
    var removed2: Bool = false
    var removed3: Bool = false
    
    var baseValue1: String = ""
    var baseValue2: String = ""
    var baseValue3: String = ""
    
    @IBOutlet weak var baseCurrency: UITextField!
    @IBOutlet weak var mainActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var currencyButton1: UIButton!
    @IBOutlet weak var currencyPicker1: UIPickerView!
    @IBOutlet weak var done1: UIButton!
    @IBOutlet weak var currencyLabel1: UILabel!
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var currentValue1: UILabel!
    @IBOutlet weak var changePercent1: UIButton!
    var activityIndicator1: UIActivityIndicatorView = UIActivityIndicatorView()
    var activityIndicator2: UIActivityIndicatorView = UIActivityIndicatorView()
    var activityIndicator3: UIActivityIndicatorView = UIActivityIndicatorView()
    
    @IBAction func button1Pressed(_ sender: Any) {
        highlightCurrencyButtons(currencyButton1)
        currencyPicker1.isHidden=false
        currencyLabel1.isHidden = true
        done1.isHidden=false
        stackView1.isHidden=true
        currentValue1.isHidden=true
        changePercent1.isHidden=true
    }
 
    @IBAction func done1Pressed(_ sender: Any) {
        if (!removed1){
            currencyPicker1.isHidden = true
            deHighlightCurrencyButtons(currencyButton1)
            if (selected){
                deHighlightCurrencyButtons(currencyButton1)
                let userData1: [userCurrencyData] = [
                    userCurrencyData(uCurr: currencyLabel1.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel2.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel3.text!, uBase: baseCurrency.text!)
                ]
                
                UserDefaults.standard.set(try? PropertyListEncoder().encode(userData1), forKey:"userCurrencyData")
                
                currencyPicker1.isHidden = true
                done1.isHidden=true
                if (removed1){
                    currencyLabel1.isHidden = true
                }else{
                    currencyLabel1.isHidden = false
                    removed1 = false
                }
                stackView1.isHidden=false
                base = baseCurrency.text!
                currentValue1.text = "00.000"
                self.fetchLiveData(self.base,self.currencyLabel1,self.currentValue1,self.changePercent1,self.activityIndicator1, self.stackView1)
                
            }else{
                done1.isHidden = true
                self.loadUserData(){
                    (success9) in
                    if (success9){
                        self.loadInitialValues()
                    }
                }
                
            }
        }else{
             currencyLabel1.isHidden = true
            currencyPicker1.isHidden = true
            done1.isHidden=true
            let userData1: [userCurrencyData] = [
                userCurrencyData(uCurr: currencyLabel1.text!, uBase: baseCurrency.text!),
                userCurrencyData(uCurr: currencyLabel2.text!, uBase: baseCurrency.text!),
                userCurrencyData(uCurr: currencyLabel3.text!, uBase: baseCurrency.text!)
            ]
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(userData1), forKey:"userCurrencyData")
        }
        
    }
    
    @IBOutlet weak var currencyButton2: UIButton!
    @IBOutlet weak var currencyPicker2: UIPickerView!
    @IBOutlet weak var done2: UIButton!
    @IBOutlet weak var currencyLabel2: UILabel!
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var currentValue2: UILabel!
    @IBOutlet weak var changePercent2: UIButton!
    
    @IBAction func button2Pressed(_ sender: Any) {
        highlightCurrencyButtons(currencyButton2)
        currencyPicker2.isHidden=false
        currencyLabel2.isHidden = true
        done2.isHidden=false
        stackView2.isHidden=true
        currentValue2.isHidden=true
        changePercent2.isHidden=true
    }
    @IBAction func done2Pressed(_ sender: Any) {
        if (!removed2){
            currencyPicker2.isHidden = true
            deHighlightCurrencyButtons(currencyButton2)
            if (selected){
                deHighlightCurrencyButtons(currencyButton2)
                let userData2: [userCurrencyData] = [
                    userCurrencyData(uCurr: currencyLabel1.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel2.text!, uBase: baseCurrency.text!),
                    userCurrencyData(uCurr: currencyLabel3.text!, uBase: baseCurrency.text!)
                ]
                
                UserDefaults.standard.set(try? PropertyListEncoder().encode(userData2), forKey:"userCurrencyData")
                currencyPicker2.isHidden = true
                done2.isHidden=true
                if (removed2){
                    currencyLabel2.isHidden = true
                }else{
                    currencyLabel2.isHidden = false
                    removed2 = false
                }
                stackView2.isHidden=false
                base = baseCurrency.text!
                currentValue2.text = "00.000"
                self.fetchLiveData(self.base,self.currencyLabel2,self.currentValue2,self.changePercent2,self.activityIndicator2, self.stackView2)
            }else{
                done2.isHidden = true
                self.loadUserData(){
                    (success9) in
                    if (success9){
                        self.loadInitialValues()
                    }
                }
            }
        }else{
            currencyLabel2.isHidden = true
            currencyPicker2.isHidden = true
            done2.isHidden=true
            let userData2: [userCurrencyData] = [
                userCurrencyData(uCurr: currencyLabel1.text!, uBase: baseCurrency.text!),
                userCurrencyData(uCurr: currencyLabel2.text!, uBase: baseCurrency.text!),
                userCurrencyData(uCurr: currencyLabel3.text!, uBase: baseCurrency.text!)
            ]
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(userData2), forKey:"userCurrencyData")
        }
    }
    
    @IBOutlet weak var currencyButton3: UIButton!
    @IBOutlet weak var currencyPicker3: UIPickerView!
    @IBOutlet weak var done3: UIButton!
    @IBOutlet weak var currencyLabel3: UILabel!
    
    @IBOutlet weak var stackView3: UIStackView!
    
    @IBOutlet weak var changePercent3: UIButton!
    @IBOutlet weak var currentValue3: UILabel!
    @IBAction func button3Pressed(_ sender: Any) {
        highlightCurrencyButtons(currencyButton3)
        currencyPicker3.isHidden=false
        currencyLabel3.isHidden = true
        done3.isHidden=false
        stackView3.isHidden=true
        currentValue3.isHidden=true
        changePercent3.isHidden=true
    }
    @IBAction func done3Pressed(_ sender: Any) {
        
        if (!removed3){
            currencyPicker3.isHidden = true
            deHighlightCurrencyButtons(currencyButton3)
            if (selected){
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
                stackView3.isHidden=false
                base = baseCurrency.text!
                currentValue3.text = "00.000"
                self.fetchLiveData(self.base,self.currencyLabel3,self.currentValue3,self.changePercent3,self.activityIndicator3, self.stackView3)
            }
            else{
                done3.isHidden = true
                self.loadUserData(){
                    (success9) in
                    if (success9){
                        self.loadInitialValues()
                    }
                }
            }
        }else{
            currencyLabel3.isHidden = true
            currencyPicker3.isHidden = true
            done3.isHidden=true
            let userData3: [userCurrencyData] = [
                userCurrencyData(uCurr: currencyLabel1.text!, uBase: baseCurrency.text!),
                userCurrencyData(uCurr: currencyLabel2.text!, uBase: baseCurrency.text!),
                userCurrencyData(uCurr: currencyLabel3.text!, uBase: baseCurrency.text!)
            ]
            
            UserDefaults.standard.set(try? PropertyListEncoder().encode(userData3), forKey:"userCurrencyData")
        }
        
    }
    
    var baseCurrencyData: [(currency: String, image: UIImage?)] = [("Select Base Currency",UIImage(named: "add.png")),("INR",UIImage(named: "india.png")),("AUD",UIImage(named: "aus.png")),("USD",UIImage(named:"usa.png")),("---",UIImage(named: "add.png")),]
    
   var currencyData: [(currency: String, image: UIImage?)] = [("Remove",UIImage(named: "add.png")),("Select",UIImage(named: "add.png")),("INR",UIImage(named: "india.png")),("AUD",UIImage(named: "aus.png")),("USD",UIImage(named:"usa.png"))]
    
    var currencyDataForUserDefaults: [String:UIImage?] = ["Remove": UIImage(named: "add.png"),"Select":UIImage(named: "add.png"),"INR":UIImage(named: "india.png"),"AUD":UIImage(named: "aus.png"),"USD":UIImage(named:"usa.png")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker1.selectRow(1, inComponent: 0, animated: true)
        currencyPicker2.selectRow(1, inComponent: 0, animated: true)
        currencyPicker3.selectRow(1, inComponent: 0, animated: true)
        view.backgroundColor = #colorLiteral(red: 0.9489398599, green: 0.949072659, blue: 0.948897779, alpha: 1)
        toolBar.setItems([doneButton], animated: false)
        toolBar.sizeToFit()
        baseCurrency.inputAccessoryView = toolBar
        viewsInitialiser()
        self.loadUserData(){
                (success9) in
                if (success9){
                    self.loadInitialValues()
                }
        }
//        currencyLabel1.isHidden=false
//        currencyLabel2.isHidden=false
//        currencyLabel3.isHidden=false
        enableCurrencyButtons()
        baseCurrencyPicker.delegate=self
        baseCurrencyPicker.dataSource=self
        baseCurrencyPicker.tag = 4
        baseCurrency.inputView = baseCurrencyPicker
    }
    
    func loadInitialValues(){

        mainActivityIndicator.isHidden = false
        mainActivityIndicator.hidesWhenStopped = true
        mainActivityIndicator.style = UIActivityIndicatorView.Style.gray
       // mainActivityIndicator.startAnimating()
        mainActivityIndicator.transform = CGAffineTransform(scaleX: 3, y: 3)
        view.addSubview(mainActivityIndicator)
       
        if (currencyLabel1.text!) == "Remove"{
            currencyLabel1.isHidden = true
        }
        else{
             let load1 = LoadInitialValues(base: self.baseValue1, currencyLabel: self.currencyLabel1.text!)
             let (value1,percent1) = load1.fetchLiveData()
             currentValue1.text = String(format:"%.3f",value1)
             currencyLabel1.isHidden = false
             self.formatButton(changePercent1, percent1)
             print("Loaded: \(value1) and \(percent1)")
        }
        
        if (currencyLabel2.text!) == "Remove"{
            currencyLabel2.isHidden = true
        }
        else{
              print("This one: \(currencyLabel2.text!)")
            let load2 = LoadInitialValues(base: self.baseValue2, currencyLabel: self.currencyLabel2.text!)
            let (value2,percent2) = load2.fetchLiveData()
            currentValue2.text = String(format:"%.3f",value2)
            currencyLabel2.isHidden = false
            self.formatButton(changePercent2, percent2)
            print("Loaded: \(value2) and \(percent2)")
        }
        
        if (currencyLabel3.text!) == "Remove"{
            currencyLabel3.isHidden = true
        }
        else{
            print("This one: \(currencyLabel3.text!)")
            let load3 = LoadInitialValues(base: self.baseValue3, currencyLabel: self.currencyLabel3.text!)
            let (value3,percent3) = load3.fetchLiveData()
            currentValue3.text = String(format:"%.3f",value3)
            currencyLabel3.isHidden = false
            self.formatButton(changePercent3, percent3)
            print("Loaded: \(value3) and \(percent3)")
        }
      
        // mainActivityIndicator.stopAnimating()
        
    }
    
  
    
    func loadUserData(completion: @escaping (Bool) -> Void){
        var success9: Bool  = false
        if let fetchedData = UserDefaults.standard.value(forKey:"userCurrencyData") as? Data {
            let decodedData = try? PropertyListDecoder().decode(Array<userCurrencyData>.self, from: fetchedData)
                     if let uCurr1 = decodedData?[0].uCurr {
                        baseCurrency.text = decodedData?[0].uBase
                        baseValue1 = baseCurrency.text!
                        baseCurrency.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        currencyLabel1.text = uCurr1
                        if currencyLabel1.text == "Remove"{
                            currencyLabel1.isHidden = true
                        }else{
                            currencyLabel1.isHidden = false
                        }
                        if uCurr1 != ""{
                            currencyButton1.setImage(currencyDataForUserDefaults[uCurr1]!, for: .normal)
                        }
                        currencyButton1.isEnabled = true
                    }
                    if let uCurr2 = decodedData?[1].uCurr {
                        baseCurrency.text = decodedData?[1].uBase
                        baseValue2 = baseCurrency.text!
                        baseCurrency.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        currencyLabel2.text = uCurr2
                        if currencyLabel2.text == "Remove"{
                            currencyLabel2.isHidden = true
                        }else{
                            currencyLabel2.isHidden = false
                        }
                        if uCurr2 != ""{
                            currencyButton2.setImage(currencyDataForUserDefaults[uCurr2]!, for: .normal)
                        }
                        currencyButton2.isEnabled = true
                    }
               
                    if let uCurr3 = decodedData?[2].uCurr {
                
                        baseCurrency.text = decodedData?[2].uBase
                        baseValue3 = baseCurrency.text!
                        baseCurrency.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                        currencyLabel3.text = uCurr3
                        if currencyLabel3.text == "Remove"{
                            currencyLabel3.isHidden = true
                        }else{
                            currencyLabel3.isHidden = false
                        }
                        if uCurr3 != ""{
                            currencyButton3.setImage(currencyDataForUserDefaults[uCurr3]!, for: .normal)
                        }
                        currencyButton3.isEnabled = true
                       success9 = true
                       completion(success9)
                    }
            
            }
    }
    
    
    
    
    func fetchLiveData(_ base: String,_ currencyLabel: UILabel,_ currentValue: UILabel?,_ changePercent:UIButton?,_ activityIndicator: UIActivityIndicatorView, _ stackView: UIStackView?){
       
        activityIndicator.center.y=stackView!.center.y
        activityIndicator.center.x=currentValue!.center.x
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
      //  UIApplication.shared.beginIgnoringInteractionEvents()
        
        fetchJasonOfYesterday(base,activityIndicator,currencyLabel.text!){ (success1) in
            if (success1){
                self.fetchJasonOfToday(base,activityIndicator,currencyLabel.text!){ (success2) in
                    if (success2){
                        
                        self.calculateValueChange(currentValue,changePercent)
                        DispatchQueue.main.async {
                        activityIndicator.stopAnimating()
                       // UIApplication.shared.endIgnoringInteractionEvents()
                        currentValue!.isHidden=false
                        changePercent!.isHidden=false
                        }
                    }
                }
            }
        }
        
    }
   

    
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return currencyData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1{
            currencyLabel1.text=currencyData[row].currency
            if currencyLabel1.text == "Remove"{
                removed1 = true
            }
            else{
                removed1 = false
            }
            currencyButton1.setImage(currencyData[row].image!,for: .normal)
            currencyButton1.isHighlighted=false
            doneButtonCheck(currencyLabel1,done1,currencyButton1)
        }
        else if pickerView.tag == 2{
            currencyLabel2.text=currencyData[row].currency
            if currencyLabel2.text == "Remove"{
                removed2 = true
            }
            else{
                removed2 = false
            }
            currencyButton2.setImage(currencyData[row].image!,for: .normal)
            currencyButton2.isHighlighted=false
            doneButtonCheck(currencyLabel2,done2,currencyButton2)
          
        }
        else if pickerView.tag == 3 {
            currencyLabel3.text=currencyData[row].currency
            if currencyLabel3.text == "Remove"{
                removed3 = true
            }
            else{
                removed3 = false
            }
            currencyButton3.setImage(currencyData[row].image!,for: .normal)
            currencyButton3.isHighlighted=false
            doneButtonCheck(currencyLabel3,done3,currencyButton3)
           
        }
        else{
            if baseCurrencyData[row].currency == "Select Base Currency"{
                currencyButton1.isEnabled = false
                currencyButton2.isEnabled = false
                currencyButton3.isEnabled = false
            }
            baseCurrency.text = baseCurrencyData[row].currency
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 4{
            return baseCurrencyData[row].currency
        }
        else{
            return currencyData[row].currency
        }
    }
    
    @objc func doneClicked(){
        baseCurrency.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        baseCurrency.endEditing(true)
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
        
        loadInitialValues()
       
        
        
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
        changePercent1.isHidden=true
        changePercent1.layer.cornerRadius = 5
        changePercent1.setTitle(" 0.00% ", for: .normal)
        changePercent2.isHidden=true
        changePercent2.layer.cornerRadius = 5
        changePercent2.setTitle(" 0.00% ", for: .normal)
        changePercent3.isHidden=true
        changePercent3.layer.cornerRadius = 5
        changePercent3.setTitle(" 0.00% ", for: .normal)
    }
    
    func enableCurrencyButtons(){
        if baseCurrency.text != "Select Base Currency"{
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
    func doneButtonCheck(_ currencyL: UILabel?, _ doneB: UIButton?, _ currencyButton: UIButton?){
        if currencyL!.text == "Select"{
            selected = false
            highlightCurrencyButtons(currencyButton)
        }
        else{
            selected = true
            doneB!.isEnabled = true
            deHighlightCurrencyButtons(currencyButton)
        }
    }
    
    func fetchJasonOfYesterday(_ base:String,_ activityIndicator: UIActivityIndicatorView, _ curr:String,completion:@escaping (Bool) -> Void ){
        var success1: Bool = false
        let previousDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let yesterday = dateFormatter.string(from: previousDay!)
        print(yesterday)
        
        let jsonURL = "https://apilayer.net/api/historical?access_key=7e4329ef9daa6adce5d7775a6719bcb4&date=\(yesterday)&source=\(base)&currencies=\(curr)"
        
        guard let url = URL(string: jsonURL) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{
                return
            }
            do{
                let currencyValue = try
                    JSONDecoder().decode(Currency.self, from: data)
                for (key,value) in currencyValue.quotes{
                    self.prevCurrencyName = key
                    self.prevCurrencyValue = value
                }
                
                print("Yesterday")
                print("Previous Currency Name:\(self.prevCurrencyName), Previous Currency Value:\(self.prevCurrencyValue)")
              
                success1 = true
                completion(success1)
            } catch _{
                print("Unable to fetch the data")
                activityIndicator.stopAnimating()
            }
        }
        task.resume()
    }

    
    func fetchJasonOfToday(_ base: String,_ activityIndicator: UIActivityIndicatorView,_ curr:String,completion: @escaping (Bool)->Void){
        var success2: Bool = false
       
       let jsonURL = "https://apilayer.net/api/live?access_key=7e4329ef9daa6adce5d7775a6719bcb4&source=\(base)&currencies=\(curr)"

        guard let url = URL(string: jsonURL) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else{
                return
            }
            do{
                let currencyValue = try
                    JSONDecoder().decode(Currency.self, from: data)
                for (key,value) in currencyValue.quotes{
                     self.currentCurrencyName = key
                     self.currentCurrencyValue = value
                }
                print("Today")
                print("Current Currency Name:\(self.currentCurrencyName), Current Currency Value:\(self.currentCurrencyValue)")
               
                success2 = true
                completion(success2)
            } catch _{
                print("Unable to fetch the data")
                activityIndicator.stopAnimating()
            }
        }
        task.resume()
    }
    
    
    func calculateValueChange(_ valueField: UILabel?, _ percentField: UIButton?){
        DispatchQueue.main.sync {
            valueField?.text=String(format: "%.3f",self.currentCurrencyValue)
            let currPercentage = ((self.currentCurrencyValue - self.prevCurrencyValue ) / self.prevCurrencyValue) * 100
            print("\(currPercentage)%")
            percentField?.setTitle(String(format: "%.3f",currPercentage), for: .normal)
            self.formatButton(percentField, currPercentage)
            
        }
        
    }
    
  
    
    func formatButton(_ button: UIButton?, _ percentage: Float){
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
    
}



