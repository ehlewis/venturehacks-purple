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
    @IBOutlet weak var toggle: UISegmentedControl!
    
    var free = [MKPointAnnotation]()
    var paid = [MKPointAnnotation]()
    var handicapped = [MKPointAnnotation]()
    var noParking = [MKPointAnnotation]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initialLocation = CLLocation(latitude: 40.7461, longitude: -74.031)

        //var filePath = Bundle.main.path(forResource: "Places", ofType: "plist")
        //let items = NSArray(contentsOfFile: filePath!) as! [[String:AnyObject]]
        
        //var spots: [NSArray] = []
        var items: [NSDictionary] = []
        if let filePath = Bundle.main.path(forResource: "StreetInfo", ofType: "plist") {
            if let fromPlist = NSArray(contentsOfFile: filePath) as? [NSDictionary] {
                for element in fromPlist {
                    items.append(element)
                }
            }
        }
        
        for i in 0...items.count-1{
            let latitude = items[i]["latitude"]
            let longitude = items[i]["longitude"]
            let type = items[i]["type"]
            let length = items[i]["length"]
            makeAnnotation(latitude: latitude as! CLLocationDegrees, longitude: longitude as! CLLocationDegrees, parkingType: type as! String!, length: length as! String!)
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
        
        removeAll()
        addAll()

        
    }
    
    @IBAction func showHide(_ sender: Any) {
        if toggle.selectedSegmentIndex == 1{
            for f in free {
                mapView.addAnnotation(f)
            }
            for p in paid {
                mapView.removeAnnotation(p)
            }
            for h in handicapped {
                mapView.removeAnnotation(h)
            }
            for np in noParking {
                mapView.removeAnnotation(np)
            }
        }
        else{
            for f in free {
                mapView.addAnnotation(f)
            }
            for p in paid {
                mapView.addAnnotation(p)
            }
            for h in handicapped {
                mapView.addAnnotation(h)
            }
            for np in noParking {
                mapView.addAnnotation(np)
            }
        }
    }
    
    
    func addAll(){
        for f in free {
            mapView.addAnnotation(f)
        }
        for p in paid {
            mapView.addAnnotation(p)
        }
        for h in handicapped {
            mapView.addAnnotation(h)
        }
        for np in noParking {
            mapView.addAnnotation(np)
        }
    }
    func removeAll(){
        for f in free {
            mapView.removeAnnotation(f)
        }
        for p in paid {
            mapView.removeAnnotation(p)
        }
        for h in handicapped {
            mapView.removeAnnotation(h)
        }
        for np in noParking {
            mapView.removeAnnotation(np)
        }
    }
    
    func hideFree(){
        for f in free {
            mapView.removeAnnotation(f)
        }
    }
    func showAll(){
        for p in paid {
            mapView.addAnnotation(p)
        }
        for h in handicapped {
            mapView.addAnnotation(h)
        }
        for np in noParking {
            mapView.addAnnotation(np)
        }
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
            ann.glyph = length
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

