//
//  BottomSheetViewController.swift
//  Spear Chat
//
//  Created by Nilesh's MAC on 7/9/18.
//  Copyright © 2018 Spear. All rights reserved.
//

import UIKit
import MapKit

protocol BottomSheetViewControllerDelegate: class {
    func didShareLocation()
}

class BottomSheetViewController: UIViewController {

    var currentLocationButton: UIButton!
    var textLabel: UILabel!
    var nearByTableView: UITableView?
    var nearByLocationArray: [MKMapItem]? = []
    
    let fullView: CGFloat = 100
    var partialView: CGFloat {
        return UIScreen.main.bounds.height - (currentLocationButton.frame.maxY + UIApplication.shared.statusBarFrame.height + 50)
    }
    
    weak var delegate: BottomSheetViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.panGesture))
        view.addGestureRecognizer(gesture)
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.6, animations: { [weak self] in
            let frame = self?.view.frame
            let yComponent = self?.partialView
            self?.view.frame = CGRect(x: 0, y: yComponent!, width: frame!.width, height: frame!.height)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addViews() {
        let lineView = UIView(frame: CGRect(x: (view.frame.size.width/2) - 22.5, y: 6, width: 45, height: 7))
        lineView.layer.cornerRadius = 3.5
        lineView.backgroundColor = UIColor.lightGray
        view.addSubview(lineView)
        
        currentLocationButton = UIButton(frame: CGRect(x: 0, y: lineView.frame.size.height + 20, width: view.frame.size.width, height: 50))
        currentLocationButton.addTarget(self, action: #selector(currentLocationBtnTapped), for: .touchUpInside)
        //mapButton.addTarget(self, action: #selector(ViewController.btnOpenMap(_:)), for: .touchUpInside)
        currentLocationButton.leftImage(image: UIImage(named: "shareLocation")!, renderMode: .alwaysOriginal)
        currentLocationButton.setTitle("      Send Your Current Location", for: .normal)
        currentLocationButton.setTitleColor(UIColor.black, for: .normal)
        currentLocationButton.contentHorizontalAlignment = .left
        view.addSubview(currentLocationButton)
        
        textLabel = UILabel(frame: CGRect(x: 68, y: currentLocationButton.frame.size.height + 7, width: 150, height: 20))
        textLabel.text = "Accurate to 50m"
        textLabel.textColor = UIColor.gray
        textLabel.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        view.addSubview(textLabel)
        
        nearByTableView = UITableView(frame: CGRect(x: 0, y: textLabel.frame.origin.y+30, width: view.frame.size.width, height: 50), style: UITableViewStyle.plain)
        nearByTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        nearByTableView?.delegate = self
        nearByTableView?.dataSource = self
        view.addSubview(nearByTableView!)
        
        nearByTableView?.translatesAutoresizingMaskIntoConstraints = false
        nearByTableView?.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        nearByTableView?.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        nearByTableView?.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 10).isActive = true
        nearByTableView?.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let velocity = recognizer.velocity(in: self.view)
        let y = self.view.frame.minY
        if ( y + translation.y >= fullView) && (y + translation.y <= partialView ) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
        if recognizer.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullView) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            
            UIView.animate(withDuration: duration, delay: 0.0, options: [.allowUserInteraction], animations: {
                if  velocity.y >= 0 {
                    self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                } else {
                    self.view.frame = CGRect(x: 0, y: self.fullView, width: self.view.frame.width, height: self.view.frame.height)
                }
                
            }, completion: nil)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        let gesture = (gestureRecognizer as! UIPanGestureRecognizer)
        let direction = gesture.velocity(in: view).y
        
        let y = view.frame.minY
        if (y == fullView && nearByTableView?.contentOffset.y == 0 && direction > 0) || (y == partialView) {
            nearByTableView?.isScrollEnabled = false
        } else {
            nearByTableView?.isScrollEnabled = true
        }
        
        return false
    }
    
    @objc func currentLocationBtnTapped() {
        delegate?.didShareLocation()
    }
}

extension BottomSheetViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return nearByLocationArray.count
        if let nearbyArr = nearByLocationArray, nearbyArr.count > 0 {
            return 10
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        //let selectedItem = nearByLocationArray[indexPath.row].placemark
        if let nearbyArr = nearByLocationArray, nearbyArr.count > 0 {
            cell.textLabel?.text = "Data: \(indexPath.row)"//selectedItem.name
            cell.imageView?.image = #imageLiteral(resourceName: "location")
        }else {
            cell.textLabel?.text = "Searching..."
            cell.textLabel?.textColor = UIColor.darkGray
            cell.textLabel?.textAlignment = .center
            cell.imageView?.image = nil
        }
        
        return cell
    }
}
