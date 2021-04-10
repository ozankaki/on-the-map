//
//  AddLocationViewController.swift
//  On the Map
//
//  Created by Ozan Kaki on 9.04.2021.
//

import UIKit
import MapKit

class AddLocationViewController: UIViewController, Loadable {

    @IBOutlet weak var studentLocationMapView: MKMapView!
    
    var address: String!
    var link: String!
    var location: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        getLocationFromAddress()
    }
    
    @IBAction func addLocation(_ sender: Any) {
        let studentInformation = prepareStudentInformation()
        UdacityClient().addStudentInformation(studentInformation: studentInformation,
                                           completion: handleAddLocationResponse(result:error:))
        
    }
    
    func prepareStudentInformation() -> StudentInformation {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let dateString = formatter.string(from: today)
        
        let info = StudentInformation()
        info.firstName = UdacityClient.Auth.firstName
        info.lastName = UdacityClient.Auth.lastName
        info.longitude = (self.location?.coordinate.longitude)!
        info.latitude = (self.location?.coordinate.latitude)!
        info.mapString = address
        info.mediaURL = link
        info.uniqueKey = UdacityClient.Auth.key
        info.objectId = UdacityClient.Auth.sessionId
        info.createdAt = dateString
        info.updatedAt = dateString
        
        return info
    }
    
    func getLocationFromAddress() {
        self.startLoading()
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] placemarks, _ in
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
                self?.stopLoading()
            } else {
                self?.stopLoading()
                let alert = UIAlertController(title: Constants.wrongAddressTitle,
                                              message: Constants.Errors.wrongAddress, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Back", style: .cancel, handler: {_ in
                    self?.navigationController?.popViewController(animated: true)
                }))
                self!.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func handleAddLocationResponse(result: Bool, error: Error?) {
        if result {
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
            }
        } else {
            showAlert(message: error?.localizedDescription ?? Constants.Errors.genericError)
        }
    }

}
