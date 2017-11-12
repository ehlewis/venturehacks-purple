//
//  ViewController.swift
//  Smart Park
//
//  Created by Evan Lewis on 11/11/17.
//  Copyright © 2017 ISawTheSign. All rights reserved.
//

import UIKit
import MapKit


/*class MyPointAnnotation : MKPointAnnotation {
    var pinTintColor: UIColor?
}*/

class MyPointAnnotation : MKPointAnnotation {
    var markerTintColor: UIColor?
    var glyph: String?
}

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var free = [MKPointAnnotation]()
    var paid = [MKPointAnnotation]()
    var handicapped = [MKPointAnnotation]()
    var noParking = [MKPointAnnotation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 40.7461, longitude: -74.031)

        let filePath = Bundle.main.path(forResource: "Places", ofType: "plist")
        let items = NSArray(contentsOfFile: filePath!) as! [[String:AnyObject]]
        for item in items{
            for element in item{
                print(element)
            }
        }
        
        
        //let newLocation = CLLocationCoordinate2DMake(40.7461, -74.031)
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self

        /*
        for n in free {
            mapView.removeAnnotation(n)
        }
        
        
        for c in free {
            mapView.addAnnotation(c)
        }
         */
        
        makeAnnotation(latitude: 40.7463, longitude: -74.035, parkingType: "free", length: "0")
        makeAnnotation(latitude: 40.74, longitude: -74.03, parkingType: "free", length: "∞")

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func makeAnnotation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, parkingType: String, length: String){
        let ann = MyPointAnnotation()
        
        ann.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        
        if(parkingType == "free"){
            ann.markerTintColor = .green
            ann.glyph = length
            free.append(ann)
        }
        else if(parkingType == "paid"){
            ann.markerTintColor = .orange
            ann.glyph = length
            paid.append(ann)
        }
        else if(parkingType == "handicapped"){
            ann.markerTintColor = .blue
            ann.glyph = length
            handicapped.append(ann)
        }
        else if(parkingType == "noParking"){
            ann.markerTintColor = .black
            noParking.append(ann)
        }
        
        mapView.addAnnotation(ann)
    }
    
    //IMPORTANT STOP DELETING THIS
    let regionRadius: CLLocationDistance = 2000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        } else {
            annotationView?.annotation = annotation
        }
        
        if let annotation = annotation as? MyPointAnnotation {
            annotationView?.markerTintColor = annotation.markerTintColor
            annotationView?.glyphText = annotation.glyph
        }
        
        return annotationView
    }

    
    

}

extension ViewController: MKMapViewDelegate {
    /*
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{
        print("Something wrong is happening")
        let circleView = MKCircleRenderer(overlay: overlay)
        circleView.strokeColor = UIColor.magenta
        print("DFHIUGYFHJKOIUGYCHVJBOIHUGYFHGVJBKNLI")
        return circleView
    }*/
}

