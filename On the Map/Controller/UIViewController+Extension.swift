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

    func showAlert(title: String = "Oops..", message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        present(alert, animated: true, completion: nil)
    }
    
    func openUrl(_ urlPath: String) {
        let url = URL(string: urlPath)!
        if UIApplication.shared.canOpenURL(url) {
            DispatchQueue.main.async {
                UIApplication.shared.open(url)
            }
        }
    }
}
