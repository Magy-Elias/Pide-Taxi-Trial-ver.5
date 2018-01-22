//
//  SignUpViewController.swift
//  Pide Taxi Trial
//
//  Created by Mickey Goga on 1/21/18.
//  Copyright © 2018 Magy Elias. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController , UITextFieldDelegate {
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeTextFields()
    }
    
    //MARK: - ReturnKeyboardButtonAction
    /************************************************************************************************/
    // Designate this class as the text fields' delegate and set their keyboards while we're at it.
    func initializeTextFields() {
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        countryTextField.delegate = self
        mobileTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func goBackAction_Button(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
}
