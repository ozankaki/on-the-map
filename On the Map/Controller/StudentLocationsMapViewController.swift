//
//  StudentLocationsMapViewController.swift
//  On the Map
//
//  Created by Ozan Kaki on 8.04.2021.
//

import UIKit
import MapKit

class StudentLocationsMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var studentLocationsMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        studentLocationsMapView.delegate = self
        UdacityClient().getStudentLocations(completion: handleStudentLocationsResponse(result:error:))
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "studentLoc") as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "studentLoc")
        }
        
        annotationView!.canShowCallout = true
        annotationView!.rightCalloutAccessoryView = UIButton(type: .infoLight)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        if let path = view.annotation?.subtitle {
            openUrl(path!)
        }
    }
    
    func handleStudentLocationsResponse(result: Bool, error: Error?) {
        if result {
            self.loadStudentLocations()
        } else {
            showAlert(message: error?.localizedDescription ?? Constants.Errors.genericError)
        }
    }
    
    func loadStudentLocations() {
        studentLocationsMapView.removeAnnotations(studentLocationsMapView.annotations)
        for location in UdacityClient.studentLocations {
            let annotation = MKPointAnnotation()
            annotation.title = "\(location.firstName ?? "") \(location.lastName ?? "")"
            annotation.subtitle = location.mediaURL
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude!, longitude: location.longitude!)
            studentLocationsMapView.addAnnotation(annotation)
        }
    }
    
    func reloadLocations() {
        self.loadStudentLocations()
    }

}
