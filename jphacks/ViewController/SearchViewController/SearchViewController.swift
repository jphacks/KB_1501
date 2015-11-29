//
//  SearchViewController.swift
//  jphacks
//
//  Created by 内村祐之 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//
import Foundation
import UIKit
import CoreLocation

class SearchViewController: BaseViewController {
    
    @IBOutlet weak var startLocationButton: UIButton!
    @IBOutlet weak var targetLocationButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!

    @IBOutlet weak var sightSeeingsToggle: SpotOptionButton!
    @IBOutlet weak var toiletToggle: SpotOptionButton!
    @IBOutlet weak var nightSpotsToggle: SpotOptionButton!
    @IBOutlet weak var monumentsToggle: SpotOptionButton!
    @IBOutlet weak var convinienceToggle: SpotOptionButton!
    @IBOutlet weak var theatersToggle: SpotOptionButton!

    var splashImageView: UIImageView!
    var walkAnimationImageView: UIImageView!

    let locationManager = CLLocationManager()
    
    
    @IBAction func GoToMapView(sender: AnyObject) {
        var spots: [Spot] = []
        if sightSeeingsToggle.hilightened {
            spots += SpotManager.sharedController.sightseeingSpotRepository.spots as [Spot]
        }
        if toiletToggle.hilightened {
            spots += SpotManager.sharedController.toiletSpotRepository.spots as [Spot]
        }
        if nightSpotsToggle.hilightened {
            spots += SpotManager.sharedController.nightViewSpotRepository.spots as [Spot]
        }
        if monumentsToggle.hilightened {
            spots += SpotManager.sharedController.sculptureSpotRepository.spots as [Spot]
        }
        if theatersToggle.hilightened {
            spots += SpotManager.sharedController.filmingLocationSpotRepository.spots as [Spot]
        }
        
        var viaLocations: [CLLocationCoordinate2D] = []
        if let spot = SpotManager.startSpot {
            viaLocations.append(CLLocationCoordinate2D(latitude: spot.latitude, longitude: spot.longitude))
        } else {
            if let coordinate = locationManager.location?.coordinate {
                viaLocations.append(coordinate)
            } else {
                let alertViewController = UIAlertController(title: "現在地", message: "位置情報を取得できません", preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(alertViewController, animated: true, completion: { dispatch_after(2, dispatch_get_main_queue(), {self.dismissViewControllerAnimated(true, completion: nil)}) })
                return
            }
        }
        if let spot = SpotManager.targetSpot {
            viaLocations.append(CLLocationCoordinate2D(latitude: spot.latitude, longitude: spot.longitude))
        } else {
            let alertViewController = UIAlertController(title: "未入力", message: "目的地を設定", preferredStyle: UIAlertControllerStyle.Alert)
            self.presentViewController(alertViewController, animated: true, completion: { dispatch_after(2, dispatch_get_main_queue(), {self.dismissViewControllerAnimated(true, completion: nil)}) })
            return
        }
        
        let storyboard = UIStoryboard(name: "MapView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! MapViewController
        controller.spots = spots
        controller.viaLocations = viaLocations
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 位置情報に関して権限をもらう
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if(status == CLAuthorizationStatus.NotDetermined) {
            locationManager.requestAlwaysAuthorization()
        }
        
        let header = SearchHeaderView()
        header.setup(CGRectMake(0, UIApplication.sharedApplication().statusBarFrame.height, self.view.bounds.width, 50))
        self.view.addSubview(header)
        
        searchButton.layer.cornerRadius = 60
        let frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.size.width + 100, height: self.view.frame.size.height + 100)
        self.splashImageView = UIImageView(frame: frame)
        self.splashImageView.center = self.view.center
        self.splashImageView.image = UIImage(named: "splash")
        self.view.addSubview(self.splashImageView)

        let frame2 = CGRect(x: self.view.center.x, y: self.view.center.y, width: 50, height: 50)
        self.walkAnimationImageView = UIImageView(frame: frame2)
        self.walkAnimationImageView.center = self.view.center
        self.walkAnimationImageView.center.y += 70
        self.walkAnimationImageView.animationImages = [UIImage]()
        self.walkAnimationImageView.image = UIImage(named: "walk_00000")
        for i in 0..<30 {
            let frameName = String(format: "walk_%05d", i)
            self.walkAnimationImageView.animationImages?.append(UIImage(named: frameName)!)
        }
        self.view.addSubview(self.walkAnimationImageView)
    }
    
    override func viewWillAppear(animated: Bool) {
        startLocationButton.setTitle(SpotManager.startSpot?.name ?? "(現在地)", forState: .Normal)
        targetLocationButton.setTitle(SpotManager.targetSpot?.name ?? "(タップして設定)", forState: .Normal)
    }
    
    override func viewDidAppear(animated: Bool) {
        self.walkAnimationImageView.animationDuration = 1
        self.walkAnimationImageView.startAnimating()
        
        UIView.animateWithDuration(0.6, // 0.3
            delay: 1.0, // 1.0,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () in
                self.splashImageView.transform = CGAffineTransformMakeScale(0.9, 0.9)
                self.walkAnimationImageView.transform = CGAffineTransformMakeScale(0.9, 0.9)
            }, completion: nil
        )
        
        UIView.animateWithDuration(0.5, // 0.2,
            delay: 1.6, // 1.3,
            options: UIViewAnimationOptions.CurveEaseOut,
            animations: { () in
                self.splashImageView.transform = CGAffineTransformMakeScale(1.2, 1.2)
                self.splashImageView.alpha = 0
                self.walkAnimationImageView.transform = CGAffineTransformMakeScale(1.2, 1.2)
                self.walkAnimationImageView.alpha = 0
            }, completion: { (Bool) in
                self.splashImageView.removeFromSuperview()
                self.walkAnimationImageView.removeFromSuperview()
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SetStartLocation(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "SpotSetView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! SpotSetViewController
        controller.completion = {(spot:Spot?) -> Void in
            SpotManager.startSpot = spot
        }
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func SetTargetLocation(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "SpotSetView", bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as! SpotSetViewController
        controller.completion = {(spot:Spot?) -> Void in
            SpotManager.targetSpot = spot
        }
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
}


extension SearchViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch (status) {
        case .NotDetermined:
            print("NotDetermined")
        case .Restricted:
            print("Restricted")
        case .Denied:
            print("Denied")
        case .AuthorizedAlways:
            print("AuthorizedAlways")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest// 取得精度の設定.
            locationManager.distanceFilter = 1// 取得頻度の設定.
            locationManager.startUpdatingLocation()
        case .AuthorizedWhenInUse:
            print("AuthorizedWhenInUse")
        }
    }
    
    // 位置情報がupdateされた時
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("\(manager.location?.coordinate.latitude),\(manager.location?.coordinate.longitude)")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
}

