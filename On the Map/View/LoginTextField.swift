//
//  TextBox.swift
//  On the Map
//
//  Created by Ozan Kaki on 6.04.2021.
//

import UIKit

class LoginTextField: UITextField {
    
//    init() {
//        super.init(frame: CGRect.zero)
//        setupTextField()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupTextField()
    }
    
    func setupTextField() {
        backgroundColor = UIColor.transparentWhite
        textColor = UIColor.button
        frame.size.height = 50
    }
}
