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

    let networkStatus = CheckNetwork()
    
    let homePageActivityIndicator = UIActivityIndicatorView()
    
    @IBOutlet weak var myWatchListButton: UIButton!
    @IBOutlet weak var currencyConvertorButton: UIButton!
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
      return false
    }

    @IBAction func CurrencyConvertor(_ sender: Any) {
        view.addSubview(homePageActivityIndicator)
        self.displayActivityIndicator(true)
        usleep(100000)
        if (networkStatus.connectedToNetwork()) {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "currencyConvertor", sender: nil)
                self.displayActivityIndicator(false)
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
            self.displayActivityIndicator(false)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    
    @IBAction func myCurrenciesButton(_ sender: Any) {
        view.addSubview(homePageActivityIndicator)
       self.displayActivityIndicator(true)
       usleep(100000)
        if (networkStatus.connectedToNetwork()){
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "myCurrencies", sender: nil)
                self.displayActivityIndicator(false)
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
             self.displayActivityIndicator(false)
            self.present(alert, animated: true, completion: nil)
            
        }
       
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      myWatchListButton.layer.borderColor = #colorLiteral(red: 0.003920819145, green: 0.003922065254, blue: 0.003920426592, alpha: 1)
        myWatchListButton.layer.borderWidth = 7
        currencyConvertorButton.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        currencyConvertorButton.layer.borderWidth = 7
      
    }
    
    func displayActivityIndicator(_ state: Bool){
        if (state){
            homePageActivityIndicator.center.y = self.view.center.y+40
            homePageActivityIndicator.center.x = self.view.center.x
            homePageActivityIndicator.style = .white
            homePageActivityIndicator.hidesWhenStopped = true
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
