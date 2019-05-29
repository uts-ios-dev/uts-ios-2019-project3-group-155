//
//  CurrencyConvertor.swift
//  Forex Wallet
//
//  Created by Aruna Sairam Manjunatha on 29/5/19.
//  Copyright © 2019 Aruna Sairam Manjunatha. All rights reserved.
//

import UIKit

class CurrencyConvertor: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var currencyData: [(currency: String, image: UIImage?)] = [/*("Remove",UIImage(named: "add.png")),*/("Select",UIImage(named: "add.png")),("INR",UIImage(named: "india.png")),("AUD",UIImage(named: "aus.png")),("USD",UIImage(named:"usa.png"))]
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
