//
//  AddLocationViewController.swift
//  On the Map
//
//  Created by Ozan Kaki on 9.04.2021.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var studentLocationMapView: MKMapView!
    
    var address: String!
    var link: String!
    var location: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        getLocationFromAddress()
    }
    
    @IBAction func addLocation(_ sender: Any) {
        let studentLocation = prepareStudentLocation()
        UdacityClient().addStudentLocation(studentLocation: studentLocation,
                                           completion: handleAddLocationResponse(result:error:))
        
    }
    
    func prepareStudentLocation() -> StudentLocation {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateString = formatter.string(from: today)
        
        let studentLocation = StudentLocation()
        studentLocation.firstName = UdacityClient.Auth.firstName
        studentLocation.lastName = UdacityClient.Auth.lastName
        studentLocation.longitude = (self.location?.coordinate.longitude)!
        studentLocation.latitude = (self.location?.coordinate.latitude)!
        studentLocation.mapString = address
        studentLocation.mediaURL = link
        studentLocation.uniqueKey = UdacityClient.Auth.key
        studentLocation.objectId = UdacityClient.Auth.sessionId
        studentLocation.createdAt = dateString
        studentLocation.updatedAt = dateString
        
        return studentLocation
    }
    
    func getLocationFromAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] placemarks, error in
            if let placemark = placemarks?.first, let location = placemark.location {
                let mark = MKPlacemark(placemark: placemark)

                if var region = self?.studentLocationMapView.region {
                    region.center = location.coordinate
                    region.span.longitudeDelta /= 8.0
                    region.span.latitudeDelta /= 8.0
                    self?.studentLocationMapView.setRegion(region, animated: true)
                    self?.studentLocationMapView.addAnnotation(mark)
                }
                self?.location = location
            } else {
                print(error!)
            }
        }
    }
    
    func handleAddLocationResponse(result: Bool, error: Error?) {
        if result {
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }

}
