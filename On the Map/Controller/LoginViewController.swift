//
//  ViewController.swift
//  On the Map
//
//  Created by Ozan Kaki on 6.04.2021.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var facebookLoginButton: FacebookButton!
    @IBOutlet weak var loginButton: LoginButton!
    @IBOutlet weak var signUpButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareTexField(usernameTextField)
        prepareTexField(passwordTextField)
    }

    @IBAction func loginTapped(_ sender: Any) {
        setLoggingIn(true)
        // TODO: use textfields
        UdacityClient().login(username: "ozankaki@gmail.com", password: "Ok125125!@z",
                            completion: handleLoginResponse(success:error:))
    }

    func prepareTexField(_ texField: UITextField) {
        texField.delegate = self
    }
    
    func setLoggingIn(_ loggingIn: Bool) {
//        if loggingIn {
//            activityIndicator.startAnimating()
//        } else {
//            activityIndicator.stopAnimating()
//        }
        usernameTextField.isEnabled = !loggingIn
        passwordTextField.isEnabled = !loggingIn
        loginButton.isEnabled = !loggingIn
        facebookLoginButton.isEnabled = !loggingIn
        signUpButton.isEnabled = !loggingIn
    }
    
    func handleLoginResponse(success: Bool, error: Error?) {
        setLoggingIn(false)
        if success {
            performSegue(withIdentifier: "completeLogin", sender: nil)
        } else {
            showAlert(title: Constants.failedLogin,
                      message: error?.localizedDescription ?? Constants.invalidCredentials)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
