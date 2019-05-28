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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchID(_ sender: Any) {
        let context:LAContext = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil){
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Use your finger print to login", reply: {(wasCorrect,error) in
                if (wasCorrect)
                {
                    print("Correct")
                    
                    DispatchQueue.main.async {
                        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "wallethome") as! ViewController
                        self.present(newViewController, animated: true, completion: nil)
                    }
                }
                else
                {
                    print("Incorrect")
                }
            })
        }
        else
        {
            print("Not Supported")
        }
        
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
