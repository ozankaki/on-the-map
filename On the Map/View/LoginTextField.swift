//
//  TextBox.swift
//  On the Map
//
//  Created by Ozan Kaki on 6.04.2021.
//

import UIKit

class LoginTextField: UITextField {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }

    func setupTextField() {
        backgroundColor = UIColor.transparentWhite
        textColor = UIColor.buttonBackground
        frame.size.height = 50
    }
}
