//
//  ViewController.swift
//  Money Matter
//
//  Created by Aruna Sairam Manjunatha on 19/5/19.
//  Copyright © 2019 Aruna Sairam Manjunatha. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    @IBOutlet weak var currencyPicker1: UIPickerView!
    
    @IBOutlet weak var currencyPicker2: UIPickerView!
    
    @IBOutlet weak var currencyPicker3: UIPickerView!
    
    
    @IBOutlet weak var done1: UIButton!
    
    @IBOutlet weak var done2: UIButton!
    
    @IBOutlet weak var done3: UIButton!
    
    @IBOutlet weak var currencyButton1: UIButton!
    @IBOutlet weak var currencyLabel1: UILabel!
    
    @IBOutlet weak var currencyButton2: UIButton!
    @IBOutlet weak var currencyLabel2: UILabel!

    @IBOutlet weak var currencyButton3: UIButton!
    @IBOutlet weak var currencyLabel3: UILabel!
    
  
    @IBOutlet weak var stackView1: UIStackView!
    
    @IBOutlet weak var stackView2: UIStackView!
    
    @IBOutlet weak var stackView3: UIStackView!
    
    @IBAction func button1Pressed(_ sender: Any) {
        currencyPicker1.isHidden=false
        currencyLabel1.isHidden = true
        done1.isHidden=false
        stackView1.isHidden=true
    }
    
    @IBAction func button2Pressed(_ sender: Any) {
        currencyPicker2.isHidden=false
        currencyLabel2.isHidden = true
        done2.isHidden=false
        stackView2.isHidden=true
    }
    
    @IBAction func button3Pressed(_ sender: Any) {
        currencyPicker3.isHidden=false
        currencyLabel3.isHidden = true
        done3.isHidden=false
        stackView3.isHidden=true
    }
    
    @IBAction func done1Pressed(_ sender: Any) {
        currencyPicker1.isHidden = true
        done1.isHidden=true
        currencyLabel1.isHidden = false
        stackView1.isHidden=false
    }
    
    
    @IBAction func done2Pressed(_ sender: Any) {
        currencyPicker2.isHidden = true
        done2.isHidden=true
        currencyLabel2.isHidden = false
        stackView2.isHidden=false
        
    }
    
    @IBAction func done3Pressed(_ sender: Any) {
        currencyPicker3.isHidden = true
        done3.isHidden=true
        currencyLabel3.isHidden = false
        stackView3.isHidden=false
        
    }
    var data: [(currency: String, image: UIImage?)] = [("Select Currency",UIImage(named: "add.gif")),("INR",UIImage(named: "india.png")),("AUD",UIImage(named: "aus.png")),("USD",UIImage(named:"usa.png"))]
    var currencyPicker = UIPickerView()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        done1.isHidden=true
        done2.isHidden=true
        done3.isHidden=true
        currencyPicker1.isHidden=true
        currencyPicker2.isHidden=true
        currencyPicker3.isHidden=true
        
    }
    

    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView.tag == 1{
            currencyLabel1.text=data[row].currency
            currencyButton1.setImage(data[row].image!,for: .normal)
        
            
        }
        else if pickerView.tag == 2{
            currencyLabel2.text=data[row].currency
            currencyButton2.setImage(data[row].image!,for: .normal)
          
        }
        else{
            currencyLabel3.text=data[row].currency
            currencyButton3.setImage(data[row].image!,for: .normal)
           
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row].currency
        
    }
    
    
    
}



