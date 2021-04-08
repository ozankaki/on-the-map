//
//  StudentLocationsListViewController.swift
//  On the Map
//
//  Created by Ozan Kaki on 7.04.2021.
//

import UIKit

class StudentLocationsTableViewController: UITableViewController {

    @IBOutlet weak var studentLocationsTableView: UITableView!
    
    var studentLocations: [StudentLocation] = []
    var tableRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableRefreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        studentLocationsTableView.addSubview(tableRefreshControl)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadStudentLocation()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentLocations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let studentLocation = studentLocations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentLocationTableViewCell")!
        cell.textLabel?.text = "\(studentLocation.firstName) \(studentLocation.lastName)"
        cell.detailTextLabel?.text = "\(studentLocation.mediaURL)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let student = studentLocations[indexPath.row]
        openUrl(student.mediaURL)
    }
    
    func loadStudentLocation() {
        UdacityClient.getStudentLocations(completion: handleStudentLocationsResponse(studentLocations:error:))
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.loadStudentLocation()
        tableRefreshControl.endRefreshing()
    }
    
    func handleStudentLocationsResponse(studentLocations: [StudentLocation], error: Error?) {
        self.studentLocations = studentLocations
        self.studentLocationsTableView.reloadData()
    }
}
