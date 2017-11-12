//
//  boundaries.swift
//  Smart Park
//
//  Created by Evan Lewis on 11/11/17.
//  Copyright © 2017 ISawTheSign. All rights reserved.
//
/*
import Foundation
import UIKit
import MapKit

class Boundaries {
    var name: String?
    var boundary: [CLLocationCoordinate2D] = []
    
    var midCoordinate = CLLocationCoordinate2D()
    var overlayTopLeftCoordinate = CLLocationCoordinate2D()
    var overlayTopRightCoordinate = CLLocationCoordinate2D()
    var overlayBottomLeftCoordinate = CLLocationCoordinate2D()
    var overlayBottomRightCoordinate = CLLocationCoordinate2D()
    
    var overlayBoundingMapRect: MKMapRect?


class func plist(_ plist: String) -> Any? {
    let filePath = Bundle.main.path(forResource: plist, ofType: "plist")!
    let data = FileManager.default.contents(atPath: filePath)!
    return try! PropertyListSerialization.propertyList(from: data, options: [], format: nil)
}

    static func parseCoord(dict: [String: Any], fieldName: String) -> CLLocationCoordinate2D {
        guard let coord = dict[fieldName] as? String else {
            return CLLocationCoordinate2D()
        }
        let point = CGPointFromString(coord)
        return CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
}

    init(filename: String) {
        guard let properties = Boundaries.plist(filename) as? [String : Any],
            let boundaryPoints = properties["boundary"] as? [String] else { return }
        
        midCoordinate = Boundaries.parseCoord(dict: properties, fieldName: "midCoord")
        overlayTopLeftCoordinate = Boundaries.parseCoord(dict: properties, fieldName: "overlayTopLeftCoord")
        overlayTopRightCoordinate = Boundaries.parseCoord(dict: properties, fieldName: "overlayTopRightCoord")
        overlayBottomLeftCoordinate = Boundaries.parseCoord(dict: properties, fieldName: "overlayBottomLeftCoord")
        overlayBottomRightCoordinate = Boundaries.parseCoord(dict: properties, fieldName: "overlayBottomRightCoord")

        
        let cgPoints = boundaryPoints.map { CGPointFromString($0) }
        boundary = cgPoints.map { CLLocationCoordinate2DMake(CLLocationDegrees($0.x), CLLocationDegrees($0.y)) }
    }
    /*var overlayBoundingMapRect: MKMapRect {
        get {
            let topLeft = MKMapPointForCoordinate(overlayTopLeftCoordinate)
            let topRight = MKMapPointForCoordinate(overlayTopRightCoordinate)
            let bottomLeft = MKMapPointForCoordinate(overlayBottomLeftCoordinate)
            //let bottomRight = MKMapPointForCoordinate(overlayBottomRightCoordinate)

            return MKMapRectMake(
                topLeft.x,
                topLeft.y,
                fabs(topLeft.x - topRight.x),
                fabs(topLeft.y - bottomLeft.y))
        }
    }*/

}*/
