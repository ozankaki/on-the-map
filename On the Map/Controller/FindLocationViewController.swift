//
//  FindLocationViewController.swift
//  On the Map
//
//  Created by Ozan Kaki on 9.04.2021.
//

import UIKit

class FindLocationViewController: UIViewController {

    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var linkTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTexField(locationTextField, self)
        delegateTexField(linkTextField, self)
    }
    
    @IBAction func findLocation(_ sender: Any) {
        if locationTextField.isEmpty || linkTextField.isEmpty {
            showAlert(message: Constants.Errors.requiredFields)
        }
        performSegue(withIdentifier: "addLocationSeque", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addLocationSeque" {
            guard let addLocationVC = segue.destination as? AddLocationViewController else {
                return
            }
            
            addLocationVC.address = locationTextField.text
            addLocationVC.link = linkTextField.text
        }
    }

}
