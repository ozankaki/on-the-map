//
//  StudentLocationsListViewController.swift
//  On the Map
//
//  Created by Ozan Kaki on 7.04.2021.
//

import UIKit

class StudentLocationsTableViewController: UITableViewController {

    @IBOutlet weak var studentLocationsTableView: UITableView!
    
    var tableRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableRefreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        studentLocationsTableView.addSubview(tableRefreshControl)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UdacityClient.studentLocations.count > 0 {
            self.loadStudentLocations()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UdacityClient.studentLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentLocation = UdacityClient.studentLocations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationTableViewCell")!
        cell.textLabel?.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        cell.detailTextLabel?.text = "\(studentLocation.mediaURL)"
        
        return cell
    }
    
    func loadStudentLocations() {
        UdacityClient.getStudentLocations(completion: handleStudentLocationsResponse(result:error:))
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.loadStudentLocations()
        tableRefreshControl.endRefreshing()
    }
    
    func handleStudentLocationsResponse(result: Bool, error: Error?) {
        self.reloadStudentLocations()
    }
    
    func reloadLocations() {
        self.reloadStudentLocations()
    }
    
    func reloadStudentLocations() {
        if studentLocationsTableView != nil {
            self.studentLocationsTableView.reloadData()
        }
    }
}
