//
//  UIViewController.swift
//  On the Map
//
//  Created by Ozan Kaki on 6.04.2021.
//

import UIKit

extension UIViewController {
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
//        TMDBClient.logout(completion: handleLogoutResponse(result:error:))
    }
    
    func handleLogoutResponse(result: Bool?, error: Error?) {
        if result != nil && result == true {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
