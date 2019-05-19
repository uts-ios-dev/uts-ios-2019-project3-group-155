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
    
    @IBOutlet weak var currencyTrigger1: UITextField!
    @IBOutlet weak var currencyButton1: UIButton!
    @IBOutlet weak var currencyLabel1: UILabel!
    
    @IBOutlet weak var currencyTrigger2: UITextField!
    @IBOutlet weak var currencyButton2: UIButton!
    @IBOutlet weak var currencyLabel2: UILabel!
    
    @IBOutlet weak var currencyTrigger3: UITextField!
    @IBOutlet weak var currencyButton3: UIButton!
    @IBOutlet weak var currencyLabel3: UILabel!
    
    @IBAction func button1Pressed(_ sender: Any) {
        currencyPicker1.isHidden=false
    }
    
    @IBAction func button2Pressed(_ sender: Any) {
        currencyPicker2.isHidden=false
    }
    
    @IBAction func button3Pressed(_ sender: Any) {
        currencyPicker3.isHidden=false
    }
    
    
    
    var data: [(currency: String, image: UIImage?)] = [("Select Currency",UIImage(named: "add.gif")),("INR",UIImage(named: "india.png")),("AUD",UIImage(named: "aus.png")),("USD",UIImage(named:"usa.png"))]
    var currencyPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker1.isHidden=true
        currencyPicker2.isHidden=true
        currencyPicker3.isHidden=true
        /*  currencyPicker.delegate=self
         currencyPicker.dataSource=self
         currencyTrigger1.inputView=currencyPicker
         currencyTrigger2.inputView=currencyPicker
         currencyTrigger3.inputView=currencyPicker*/
        
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
            pickerView.isHidden = true
        }
        else if pickerView.tag == 2{
            currencyLabel2.text=data[row].currency
            currencyButton2.setImage(data[row].image!,for: .normal)
            pickerView.isHidden = true
        }
        else{
            currencyLabel3.text=data[row].currency
            currencyButton3.setImage(data[row].image!,for: .normal)
            pickerView.isHidden = true
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row].currency
        
    }
    
}



