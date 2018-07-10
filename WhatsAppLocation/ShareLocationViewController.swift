//
//  ViewController.swift
//  WhatsAppLocation
//
//  Created by NILESH_iOS on 09/07/18.
//  Copyright © 2018 iDev. All rights reserved.
//

//import UIKit
//import MapKit
//
//class ShareLocationViewController: UIViewController {
//
//    var mapView: MKMapView = MKMapView()
//
//    let regionRadius: CLLocationDistance = 1000
//    let locationManager = CLLocationManager()
//    var resultSearchController:UISearchController? = nil
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        addSearchBar()
//        //mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
//        //loadInitialData()
//        //mapView.addAnnotations(artworks)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        addMapView()
//        addNavigationBarBtns()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        checkLocationAuthorizationStatus()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    @objc func refreshBtnTapped(_ sender: UIBarButtonItem) {
//    }
//
//    @objc func cancelBtnTapped(_ sender: UIBarButtonItem) {
//    }
//
//    func addMapView() {
//        let leftMargin:CGFloat = 0
//        let topMargin:CGFloat = 0
//        let mapWidth:CGFloat = view.frame.size.width
//        let mapHeight:CGFloat = view.frame.size.height
//
//        mapView.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
//
//        mapView.mapType = MKMapType.standard
//        mapView.isZoomEnabled = true
//        mapView.isScrollEnabled = true
//
//        // Or, if needed, we can position map in the center of the view
//        mapView.center = view.center
//
//        view.addSubview(mapView)
//
//        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
//        centerMapOnLocation(location: initialLocation)
//
//        mapView.delegate = self
//
//        let artwork = Artwork(title: "King David Kalakaua",
//                              locationName: "Waikiki Gateway Park",
//                              discipline: "Sculpture",
//                              coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
//        mapView.addAnnotation(artwork)
//    }
//
//    func addSearchBar() {
//        let locationSearchTable = LocationSearchTable()
//        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
//        resultSearchController?.delegate = self
//        resultSearchController?.searchResultsUpdater = locationSearchTable
//        let searchBar = resultSearchController!.searchBar
//        searchBar.sizeToFit()
//        searchBar.placeholder = "Search for places"
//        navigationItem.titleView = resultSearchController?.searchBar
//        resultSearchController?.hidesNavigationBarDuringPresentation = false
//        resultSearchController?.dimsBackgroundDuringPresentation = true
//        definesPresentationContext = true
//        locationSearchTable.mapView = mapView
//    }
//
//    func addNavigationBarBtns() {
//        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshBtnTapped(_:)))
//        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelBtnTapped(_:)))
//
//        navigationItem.rightBarButtonItem = refresh
//        navigationItem.leftBarButtonItem = cancel
//    }
//
//    func checkLocationAuthorizationStatus() {
//        if CLLocationManager.authorizationStatus() == .authorizedAlways {
//            mapView.showsUserLocation = true
//            mapView.showsTraffic = true
//            locationManager.startUpdatingLocation()
//            locationManager.delegate = self
//        } else {
//            locationManager.requestAlwaysAuthorization()
//        }
//        //    if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
//        //      mapView.showsUserLocation = true
//        //    } else {
//        //      locationManager.requestWhenInUseAuthorization()
//        //    }
//    }
//
//    // MARK: - Helper methods
//
//    func centerMapOnLocation(location: CLLocation) {
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
//                                                                  regionRadius, regionRadius)
//        mapView.setRegion(coordinateRegion, animated: true)
//    }
//}
//
//extension ShareLocationViewController: MKMapViewDelegate {
//    // 1
////    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
////        // 2
////        guard let annotation = annotation as? Artwork else { return nil }
////        // 3
////        let identifier = "marker"
////        if #available(iOS 11.0, *) {
////            var view: MKMarkerAnnotationView
////            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
////                as? MKMarkerAnnotationView {
////                dequeuedView.annotation = annotation
////                view = dequeuedView
////            } else {
////                // 5
////                view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
////                view.canShowCallout = true
////                view.calloutOffset = CGPoint(x: -5, y: 5)
////                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
////            }
////            return view
////        } else {
////            // Fallback on earlier versions
////        }
////        // 4
////
////    }
//
//    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
//                 calloutAccessoryControlTapped control: UIControl) {
//        let location = view.annotation as! Artwork
//        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
//        location.mapItem().openInMaps(launchOptions: launchOptions)
//    }
//}
//
//extension ShareLocationViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            locationManager.requestLocation()
//        }
//
//
////        if status == .authorizedAlways || status == .authorizedWhenInUse {
////            locationManager.startUpdatingLocation()
////        }
////        switch status {
////        case .notDetermined:
////            locationManager.requestAlwaysAuthorization()
////            removeLocationAlertLabel()
////            break
////        case .authorizedWhenInUse:
////            locationManager.distanceFilter = CLLocationDistance(50.0)
////            locationManager.requestAlwaysAuthorization()
////            locationManager.startUpdatingLocation()
////            removeLocationAlertLabel()
////            break
////        case .authorizedAlways:
////            locationManager.distanceFilter = CLLocationDistance(50.0)
////            locationManager.startUpdatingLocation()
////            removeLocationAlertLabel()
////            break
////        case .restricted:
////            // restricted by e.g. parental controls. User can't enable Location Services
////            NotificationCenter.default.post(name: Notification.Name(rawValue: Macros.Notification.Notification_ShowLocationServiceOffAlert), object: nil)
////            break
////        case .denied:
////            // user denied your app access to Location Services, but can grant access from Settings.app
////            NotificationCenter.default.post(name: Notification.Name(rawValue: Macros.Notification.Notification_ShowLocationServiceOffAlert), object: nil)
////            break
////        }
//
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if locations.first != nil {
//            print("location:: \(locations)")
//        }
//
//        if let location = locations.first {
////            let span = MKCoordinateSpanMake(0.05, 0.05)
////            let region = MKCoordinateRegion(center: location.coordinate, span: span)
////            mapView.setRegion(region, animated: true)
//
//            centerMapOnLocation(location: location)
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("error:: (error)")
//    }
//}
//
//extension ShareLocationViewController: UISearchControllerDelegate {
//    func willPresentSearchController(_ searchController: UISearchController) {
//        navigationItem.rightBarButtonItems = nil
//        navigationItem.leftBarButtonItems = nil
//    }
//
//    func willDismissSearchController(_ searchController: UISearchController) {
//        addNavigationBarBtns()
//    }
//}



//
//  ViewController.swift
//  Spear Chat
//
//  Created by Nilesh's MAC on 7/9/18.
//  Copyright © 2018 Spear. All rights reserved.
//

import UIKit
import MapKit

class ShareLocationViewController: UIViewController {
    
    var mapView: MKMapView = MKMapView()
    
    
    let regionRadius: CLLocationDistance = 1000
    let locationManager = CLLocationManager()
    var resultSearchController:UISearchController? = nil
    
    var currentLocation: CLLocation?
    
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
        addControlContainer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationAuthorizationStatus()
        addBottomSheetView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func refreshBtnTapped(_ sender: UIBarButtonItem) {
        if let location = currentLocation {
            centerMapOnLocation(location: location)
        }
    }
    
    @objc func cancelBtnTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
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
        
        //let artwork = Artwork(title: "King David Kalakaua",
        //locationName: "Waikiki Gateway Park",
        //discipline: "Sculpture",
        //coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        //mapView.addAnnotation(artwork)
    }
    
    func addSearchBar() {
        let locationSearchTable = LocationSearchTable()
        locationSearchTable.delegate = self
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
    
    func addControlContainer() {
        let contentView = UIView(frame: CGRect(x: view.frame.size.width - 55, y: 80, width: 50, height: 90))
        let a = UIButton(frame: CGRect(x: 10, y: 5, width: 30, height: 30))
        a.setImage(#imageLiteral(resourceName: "infoIcon"), for: .normal)
        a.tintColor = UIColor.blue
        a.addTarget(self, action: #selector(infoBtnTapped), for: .touchUpInside)
        let b = UIButton(frame: CGRect(x: 5, y: a.frame.size.height + 15, width: 40, height: 40))
        b.setImage(#imageLiteral(resourceName: "currentLocation"), for: .normal)
        b.tintColor = UIColor.blue
        b.addTarget(self, action: #selector(currentLocBtnTapped), for: .touchUpInside)
        
        let lineView = UIView(frame: CGRect(x: 1, y: 44, width: contentView.frame.size.width-2, height: 0.5))
        lineView.backgroundColor = UIColor.lightGray
        
        contentView.addSubview(a)
        contentView.addSubview(lineView)
        contentView.addSubview(b)
        contentView.backgroundColor = UIColor.white
        
        view.addSubview(contentView)
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
    }
    
    func addBottomSheetView() {
        // 1- Init bottomSheetVC
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.delegate = self
        // 2- Add bottomSheetVC as a child view
        self.addChildViewController(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParentViewController: self)
        
        // 3- Adjust bottomSheet frame and initial position.
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
    
    // MARK: - Helper methods
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc func infoBtnTapped() {
        
    }
    
    @objc func currentLocBtnTapped() {
        if let location = currentLocation {
            centerMapOnLocation(location: location)
        }
    }
}

extension ShareLocationViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}

extension ShareLocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.first != nil {
            print("location:: \(locations)")
        }
        
        if let location = locations.first {
            currentLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
}

extension ShareLocationViewController: UISearchControllerDelegate {
    func willPresentSearchController(_ searchController: UISearchController) {
        navigationItem.rightBarButtonItems = nil
        navigationItem.leftBarButtonItems = nil
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        addNavigationBarBtns()
    }
}

extension ShareLocationViewController: BottomSheetViewControllerDelegate {
    func didShareLocation() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ShareLocationViewController: LocationSearchTableDelegate {
    func didSearchLocation(_ location: CLLocation) {
        print("Search Location: \(location)")
        resultSearchController?.searchBar.text = ""
        addNavigationBarBtns()
        centerMapOnLocation(location: location)
    }
}
