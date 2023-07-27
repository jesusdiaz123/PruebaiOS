//
//  MapViewController.swift
//  ProyectoListaUsuarios
//
//  Created by Jesus Alberto Diaz de Leon on 25/07/23.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //MARK: -Outlets
    @IBOutlet weak var myMap: MKMapView!
    
    //MARK: -Variables
    var latitud: Double?
    var longitud: Double?
    
    //MARK: -Vista
    override func viewDidLoad() {
        super.viewDidLoad()

        let coordinate = CLLocationCoordinate2D(latitude: latitud ?? 0, longitude: longitud ?? 0)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        myMap.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        myMap.addAnnotation(pin)
    }

}
