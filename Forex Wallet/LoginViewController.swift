//
//  LoginViewController.swift
//  Money Matter
//
//  Created by Aruna Sairam Manjunatha on 27/5/19.
//  Copyright © 2019 Aruna Sairam Manjunatha. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

   
    

    @IBAction func CurrencyConvertor(_ sender: Any) {
        self.displayActivityIndicator(true)
        usleep(100000)
        DispatchQueue.main.async {
            
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "CurrencyConvertor") as! CurrencyConvertor
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func myCurrenciesButton(_ sender: Any) {
       self.displayActivityIndicator(true)
       usleep(100000)
       DispatchQueue.main.async {
           
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "wallethome") as! ViewController
            self.present(newViewController, animated: true, completion: nil)
    }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    func displayActivityIndicator(_ state: Bool){
        let homePageActivityIndicator = UIActivityIndicatorView()
        homePageActivityIndicator.center.y = self.view.center.y+40
        homePageActivityIndicator.center.x = self.view.center.x
        homePageActivityIndicator.style = .gray
        homePageActivityIndicator.hidesWhenStopped = true
        view.addSubview(homePageActivityIndicator)
        if (state){
            homePageActivityIndicator.startAnimating()
        }else{
            homePageActivityIndicator.stopAnimating()
        }
        
        
    }
    
//    @IBAction func touchID(_ sender: Any) {
//        let context:LAContext = LAContext()
//        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
//            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Use your finger print to login", reply: {(wasCorrect,error) in
//                if (wasCorrect)
//                {
//                    print("Correct")
//
//                    DispatchQueue.main.async {
//                        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "wallethome") as! ViewController
//                        self.present(newViewController, animated: true, completion: nil)
//                    }
//                }
//                else
//                {
//                    print("Incorrect")
//                }
//            })
//        }
//        else
//        {
//            print("Not Supported")
//        }
//
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
