//
//  ViewController.swift
//  Pide Taxi Trial
//
//  Created by Mickey Goga on 1/4/18.
//  Copyright © 2018 Magy Elias. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailErrorImageView: UIImageView!
    @IBOutlet weak var passwordErrorImageView: UIImageView!
    
//    var email : String = "it@iotblue.net"
//    var password : String = "123"
    
    let api_URL = "https://sandbox.pidetaxi.es/api/users/login"
//    "momer@iotblue.net"   "123456"
    var params : [String : String] = ["email" : "", "password" : "", "lang" : "en"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTextFields()
    }
    
    //MARK: - ReturnKeyboardButtonAction
    /************************************************************************************************/
    // Designate this class as the text fields' delegate and set their keyboards while we're at it.
    func initializeTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - SiginingInAction
    /************************************************************************************************/
    @IBAction func signInAction_Button(_ sender: Any) {
//        if (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! {
//            displayAlertMessage(messageToDisplay: "Field Required")
//        } else if  let emailAddress = emailTextField.text  {
//            if !isEmailValid(emailAddressString: emailAddress) {
//                displayAlertMessage(messageToDisplay: "Invalid email")
//            } else if !emailAddress.isEqual(email) {
//                displayAlertMessage(messageToDisplay: "Invalid email or password")
//            } else {
//                displayAlertMessage(messageToDisplay: "Sign In Successfully")
//            }
//        }
        print(emailTextField.text!)
        print(passwordTextField.text!)
        
        if (emailTextField.text?.isEmpty)! {
            displayAlertMessage(messageToDisplay: "Email Field Required")
            print("Email Field Required")
            emailErrorImageView.isHidden = false
        } else if (passwordTextField.text?.isEmpty)! {
            displayAlertMessage(messageToDisplay: "Password Field Required")
            print("Password Field Required")
            passwordErrorImageView.isHidden = false
        } else {
            let emailAddress = emailTextField.text!
            let passwordString = passwordTextField.text!
            if !isEmailValid(emailAddressString: emailAddress) {
                displayAlertMessage(messageToDisplay: "Invalid email")
                print("Invalid email")
                emailErrorImageView.isHidden = false
            } else {
                params["email"] = emailTextField.text
                params["password"] = passwordTextField.text
                getLoginData(url: api_URL, parameters: params, email: emailAddress, password: passwordString)
            }
//            else if !emailAddress.isEqual(email) || !passwordString.isEqual(password) {
//                displayAlertMessage(messageToDisplay: "Invalid email or password")
//                print("Invalid email or password")
//                emailErrorImageView.isHidden = false
//                passwordErrorImageView.isHidden = false
//            } else {
//                displayAlertMessage(messageToDisplay: "Sign In Successfully")
//                print("Sign In Successfully")
//                emailErrorImageView.isHidden = true
//                passwordErrorImageView.isHidden = true
//            }
        }
    }
    
    //MARK: - Networking
    /***********************************************************************************************************/
    //Write the getWeatherData method here:
    func getLoginData(url: String, parameters: [String: String], email: String, password: String) {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default)
            .responseJSON { response in         //Closure
                print(response.request as Any)  // original URL request
                print(response.response as Any) // URL response
                print(response.result.value as Any)   // result of response serialization
                let statusCode = response.response?.statusCode
                if response.result.isSuccess {
                    print("Success! Got the login data")
//                   if !self.emailTextField.text!.isEqual(self.params["email"]) || !self.passwordTextField.text!.isEqual(self.params["password"]) {
                    if statusCode != 200 {
                        print("Invalid email or password")
                        self.emailErrorImageView.isHidden = false
                        self.passwordErrorImageView.isHidden = false
                        self.displayAlertMessage(messageToDisplay: "Invalid email or password")
                    } else {
                        print("Sign In Successfully")
                        self.emailErrorImageView.isHidden = true
                        self.passwordErrorImageView.isHidden = true
                        self.displayAlertMessage(messageToDisplay: "Sign In Successfully")
                    }
                } else {
                    print("\(statusCode)")
                    print("Error \(response.result.error)")
                }
            }
    }

    //MARK: - Validate Email
    /************************************************************************************************/
    func isEmailValid(emailAddressString : String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
//        print(emailAddressString)
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))

            if results.count == 0
            {
                print("return email not valid")
                return false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            print("return email not valid")
            return false
        }
        print("return email valid")
        return true
    }
    
//    func isPasswordValid(passwordString : String) -> Bool {
//        let
//    }
    
    //MARK: - Displaying Alert Message
    /************************************************************************************************/
    func displayAlertMessage(messageToDisplay: String)
    {
        let alertController = UIAlertController(title: "Alert", message: messageToDisplay, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped")
            self.emailTextField.text = ""
            self.passwordTextField.text = ""
        }
        
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    //MARK: - Return Action
    /************************************************************************************************/
    // Dismiss the keyboard when the user taps the "Return" key or its equivalent while editing a text field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
          nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    //MARK: - SiginingUpAction
    /************************************************************************************************/
    @IBAction func signUp_Action_Button(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSignUpViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSignUpViewController" {
            let secondVC = segue.destination as! SignUpViewController
        }
    }
}
