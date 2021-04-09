//
//  StudentLocationsTabBarController.swift
//  On the Map
//
//  Created by Ozan Kaki on 9.04.2021.
//

import UIKit

class StudentLocationsTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logoutTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func refreshLocations(_ sender: Any) {
        let client = UdacityClient()
        client.getStudentLocations(completion: handleStudentLocationsResponse(result:error:))
    }
    
    @IBAction func addLocation(_ sender: Any) {
    }
    
    func handleStudentLocationsResponse(result: Bool, error: Error?) {
        if result {
            guard let mapViewController = viewControllers?.first as? StudentLocationsMapViewController,
                let tableViewController = viewControllers?.last as? StudentLocationsTableViewController else {
                    return
            }

            tableViewController.reloadLocations()
            mapViewController.reloadLocations()
        }
    }
    
}
