//
//  LoadingView.swift
//  On the Map
//
//  Created by Ozan Kaki on 9.04.2021.
//

import UIKit

class LoadingView: UIActivityIndicatorView {
    func setupLayout(targetView: UIView) {
        targetView.isUserInteractionEnabled = false
        targetView.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: targetView.frame.size.width).isActive = false
        self.heightAnchor.constraint(equalToConstant: targetView.frame.size.height).isActive = false
        self.centerYAnchor.constraint(equalTo: targetView.centerYAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: targetView.centerXAnchor).isActive = true
        
        self.setupLayout()
        self.startAnimating()
    }
    
    func setupLayout() {
        self.style = .large
        self.color = UIColor.udacityBlue
    }
}
