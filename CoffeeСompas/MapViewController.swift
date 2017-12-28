//
//  MapViewController.swift
//  CoffeeСompas
//
//  Created by student on 25.12.2017.
//  Copyright © 2017 com.sfedu.sinigr. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class MapViewController: UIViewController {

    
    var fireSourceRef: DatabaseReference!
    var fireObservers = NSMutableDictionary()
    var coffeeShops = [CoffeeShopAnnotation]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    let regionRadius: CLLocationDistance = 7000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: 47.229281, longitude: 39.723223)
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        fireSourceRef = FireWrapper.data.userData.root.child(CoffeeShop.path)
        fireSourceRef.load(with: self.loadCoffeeShops(withSnapshot: ))
    }
    
    func loadCoffeeShops(withSnapshot snapshot: DataSnapshot) {
        var css = [CoffeeShop]()
        for child in snapshot.children {
            if let cs = CoffeeShop.decode(fromSnapshot: child as! DataSnapshot) {
                css.append(cs)
            }
        }
        for cs in css {
            coffeeShops.append(CoffeeShopAnnotation(coffeeShop: cs))
        }
        mapView.addAnnotations(coffeeShops)
        //mapView.reloadInputViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? CoffeeShopAnnotation else {return nil}
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
