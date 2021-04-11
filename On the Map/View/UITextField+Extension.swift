//
//  UITextField+Extension.swift
//  On the Map
//
//  Created by Ozan Kaki on 10.04.2021.
//

import UIKit

extension UITextField {
    
    var isEmpty: Bool {
        return text == nil || text!.isEmpty
    }

}
