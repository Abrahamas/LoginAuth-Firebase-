//
//  LoginViewController.swift
//  LoginDemo
//
//  Created by Abrahamas on 09/01/2020.
//  Copyright © 2020 Abraham Asmile. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        create the method
        setUpElements()
        
    }
    func setUpElements () {
//        hide the error label
        errorLabel.alpha = 0
        
// style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }

    
    
    @IBAction func loginTap(_ sender: Any) {
        
//        validate the text fields
        
        
//created text field
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
//signing the user
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
//                couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
                
            }
            else{
//                 user sign in successfully
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
                      
            }
        }
        
    }
    

}
