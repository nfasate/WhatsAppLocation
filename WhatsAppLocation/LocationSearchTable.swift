////
////  LocationSearchTable.swift
////  MapKitTutorial
////
////  Created by Robert Chen on 12/28/15.
////  Copyright © 2015 Thorn Technologies. All rights reserved.
////
//
//import UIKit
//import MapKit
//
//class LocationSearchTable : UITableViewController {
//    var matchingItems:[MKMapItem] = []
//    var mapView: MKMapView? = nil
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//    }
//}
//
//extension LocationSearchTable : UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//
//        guard let mapView = mapView,
//            let searchBarText = searchController.searchBar.text else { return }
//        let request = MKLocalSearchRequest()
//        request.naturalLanguageQuery = searchBarText
//        request.region = mapView.region
//        let search = MKLocalSearch(request: request)
//        search.start { response, _ in
//            guard let response = response else {
//                return
//            }
//            self.matchingItems = response.mapItems
//            self.tableView.reloadData()
//        }
//    }
//}
//
//extension LocationSearchTable {
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return matchingItems.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
//        let selectedItem = matchingItems[indexPath.row].placemark
//        cell.textLabel?.text = selectedItem.name
//        cell.detailTextLabel?.text = ""
//        return cell
//    }
//}


//
//  LocationSearchTable.swift
//  Spear Chat
//
//  Created by Nilesh's MAC on 7/9/18.
//  Copyright © 2018 Spear. All rights reserved.
//

import UIKit
import MapKit

protocol LocationSearchTableDelegate: class {
    func didSearchLocation(_ location: CLLocation)
}

class LocationSearchTable : UITableViewController {
    var matchingItems:[MKMapItem] = []
    var mapView: MKMapView? = nil
    
    weak var delegate: LocationSearchTableDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension LocationSearchTable : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let mapView = mapView,
            let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.tableView.reloadData()
        }
    }
}

extension LocationSearchTable {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        cell.detailTextLabel?.text = ""
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coordinate = matchingItems[indexPath.row].placemark.coordinate
        let cLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        delegate?.didSearchLocation(cLocation)
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIButton {
    func leftImage(image: UIImage, renderMode: UIImageRenderingMode) {
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 2, right: image.size.width / 4)
        self.contentHorizontalAlignment = .left
        self.imageView?.contentMode = .scaleAspectFit
    }
    
    func rightImage(image: UIImage, renderMode: UIImageRenderingMode){
        self.setImage(image.withRenderingMode(renderMode), for: .normal)
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left:image.size.width / 2, bottom: 0, right: 0)
        self.contentHorizontalAlignment = .right
        self.imageView?.contentMode = .scaleAspectFit
    }
}
