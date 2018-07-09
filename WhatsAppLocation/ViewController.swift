//
//  ViewController.swift
//  WhatsAppLocation
//
//  Created by NILESH_iOS on 09/07/18.
//  Copyright © 2018 iDev. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var mapView: MKMapView = MKMapView()
    
    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSearchBar()
        //mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        //loadInitialData()
        //mapView.addAnnotations(artworks)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addMapView()
        addNavigationBarBtns()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func refreshBtnTapped(_ sender: UIBarButtonItem) {
    }
    
    @objc func cancelBtnTapped(_ sender: UIBarButtonItem) {
    }
    
    func addMapView() {
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = view.frame.size.height
        
        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        mapView.mapType = MKMapType.standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        // Or, if needed, we can position map in the center of the view
        mapView.center = view.center
        
        view.addSubview(mapView)
        
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(location: initialLocation)
        
        mapView.delegate = self
        
        let artwork = Artwork(title: "King David Kalakaua",
                              locationName: "Waikiki Gateway Park",
                              discipline: "Sculpture",
                              coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        mapView.addAnnotation(artwork)
    }
    
    func addSearchBar() {
        let locationSearchTable = LocationSearchTable()
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.delegate = self
        resultSearchController?.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapView
    }
    
    func addNavigationBarBtns() {
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshBtnTapped(_:)))
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelBtnTapped(_:)))
        
        navigationItem.rightBarButtonItem = refresh
        navigationItem.leftBarButtonItem = cancel
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedAlways {
            mapView.showsUserLocation = true
            mapView.showsTraffic = true
            locationManager.startUpdatingLocation()
            locationManager.delegate = self
        } else {
            locationManager.requestAlwaysAuthorization()
        }
        //    if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
        //      mapView.showsUserLocation = true
        //    } else {
        //      locationManager.requestWhenInUseAuthorization()
        //    }
    }
    
    // MARK: - Helper methods
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension ViewController: MKMapViewDelegate {
    // 1
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        // 2
//        guard let annotation = annotation as? Artwork else { return nil }
//        // 3
//        let identifier = "marker"
//        if #available(iOS 11.0, *) {
//            var view: MKMarkerAnnotationView
//            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
//                as? MKMarkerAnnotationView {
//                dequeuedView.annotation = annotation
//                view = dequeuedView
//            } else {
//                // 5
//                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                view.canShowCallout = true
//                view.calloutOffset = CGPoint(x: -5, y: 5)
//                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
//            }
//            return view
//        } else {
//            // Fallback on earlier versions
//        }
//        // 4
//
//    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        
        
//        if status == .authorizedAlways || status == .authorizedWhenInUse {
//            locationManager.startUpdatingLocation()
//        }
//        switch status {
//        case .notDetermined:
//            locationManager.requestAlwaysAuthorization()
//            removeLocationAlertLabel()
//            break
//        case .authorizedWhenInUse:
//            locationManager.distanceFilter = CLLocationDistance(50.0)
//            locationManager.requestAlwaysAuthorization()
//            locationManager.startUpdatingLocation()
//            removeLocationAlertLabel()
//            break
//        case .authorizedAlways:
//            locationManager.distanceFilter = CLLocationDistance(50.0)
//            locationManager.startUpdatingLocation()
//            removeLocationAlertLabel()
//            break
//        case .restricted:
//            // restricted by e.g. parental controls. User can't enable Location Services
//            NotificationCenter.default.post(name: Notification.Name(rawValue: Macros.Notification.Notification_ShowLocationServiceOffAlert), object: nil)
//            break
//        case .denied:
//            // user denied your app access to Location Services, but can grant access from Settings.app
//            NotificationCenter.default.post(name: Notification.Name(rawValue: Macros.Notification.Notification_ShowLocationServiceOffAlert), object: nil)
//            break
//        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            print("location:: \(locations)")
        }
        
        if let location = locations.first {
//            let span = MKCoordinateSpanMake(0.05, 0.05)
//            let region = MKCoordinateRegion(center: location.coordinate, span: span)
//            mapView.setRegion(region, animated: true)
            
            centerMapOnLocation(location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}

extension ViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        navigationItem.rightBarButtonItems = nil
        navigationItem.leftBarButtonItems = nil
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        addNavigationBarBtns()
    }
}
