//
//  SignUpViewController.swift
//  LoginDemo
//
//  Created by Abrahamas on 09/01/2020.
//  Copyright © 2020 Abraham Asmile. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTexField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        Create a method
        setUpElements()
    
    }
    func setUpElements() {
        
//        hide the error label
        errorLabel.alpha = 0
        
//        style the elements
        Utilities.styleTextField(firstNameTexField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
        
        
    }
// check the filed and validate and validate that the data is correct. If everything is correct the method return nil. otherwise, it return the error message.

    func validateFields() -> String? {
//        check that all fields are filled in
        if firstNameTexField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            
        {
            
             return "Please fill in all fields "
            
        }
        
        //            check the password field
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if   Utilities.isPasswordValid(cleanedPassword) == false {
//            password ain't secure enought
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
        
    }

    
    @IBAction func signUpTap(_ sender: Any) {
//        validate the fields
        let error = validateFields()
        if error != nil {
//            there's something wrong with the filed, show error message
           showError(error!)
        }
        else {
//            create cleaned versions of the data
            let firstName = firstNameTexField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //        create the user
         
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
               
//              check for errors
                if err != nil {
//                    there was an errot creating the user
                    self.showError("Error creating the user")
                }
                else{
//                    user was created successfully, now store first name and last name
                    let db = Firestore.firestore()
                                   db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "uid":result!.user.uid]) { (error) in
                                    if error != nil {
//                                      show error message
                                        self.showError("Error saving user data")
                                    }
                                   }
                     //        transition to the home screen
                    
                    self.transitionToHome()
                    
                }
            }
       
        }
        
        
    }
    
    func showError(_ message : String) {
         errorLabel.text = message
         errorLabel.alpha = 1
    }
    func transitionToHome()  {
        let homeViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
}

