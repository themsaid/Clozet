//
//  MapViewController.swift
//  clozet
//
//  Created by Mohamed Said on 3/30/15.
//  Copyright (c) 2015 Mohamed Said. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, SideBarDelegate, UISearchBarDelegate, MKMapViewDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    var currentLocation:CLLocationCoordinate2D!
    var distanceFromGround = CLLocationDistance(10000)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentLocation = CLLocationCoordinate2DMake(30.064071, 31.215664)
        
        let region = MKCoordinateRegionMakeWithDistance(currentLocation, distanceFromGround, distanceFromGround)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "TARDIS"
        annotation.subtitle = "Location where the TARDIS was seen"
        annotation.coordinate = currentLocation
        
        mapView.addAnnotation(annotation)
        
        view.clipsToBounds = true
        
        searchBar.layer.borderWidth = 2
        searchBar.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.9, alpha:1).CGColor
        
        let rightSideMenuNib = NSBundle.mainBundle().loadNibNamed("RightSideMenu", owner: self, options: nil)[0] as RightSideMenu
        rightSideMenuNib.frame = CGRectMake(view.frame.width-40, 42, view.frame.width - 90, view.frame.height - 42)
        rightSideMenuNib
        rightSideMenuNib.delegate = self
        rightSideMenuNib.originalXPosition = rightSideMenuNib.frame.origin.x
        rightSideMenuNib.manageSideMenuSwipe(rightSideMenuNib)
        view.addSubview(rightSideMenuNib)

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func zoomOutButtonClicked(sender: UIButton) {
        let span = MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta*2, longitudeDelta: mapView.region.span.longitudeDelta*2)
        let region = MKCoordinateRegion(center: mapView.region.center, span: span)
        
        mapView.setRegion(region, animated: true)
    }

    @IBAction func zoomInButtonClicked(sender: UIButton) {
        let span = MKCoordinateSpan(latitudeDelta: mapView.region.span.latitudeDelta/2, longitudeDelta: mapView.region.span.longitudeDelta/2)
        let region = MKCoordinateRegion(center: mapView.region.center, span: span)
        
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customAnnotation")
        
        annotationView.image = UIImage(named: "map")
        
        
        return annotationView
    }
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        
    }
    
}
