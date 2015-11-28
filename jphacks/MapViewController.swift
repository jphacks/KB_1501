//
//  MapViewController.swift
//  jphacks
//
//  Created by 山口智生 on 2015/11/28.
//  Copyright © 2015年 at. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    @IBAction func NextView(sender: AnyObject) {
        
    }
    
    let mapView = MKMapView()
    let locationManager = CLLocationManager()
    
    var spots: [Spot] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if(status == CLAuthorizationStatus.NotDetermined) {
            locationManager.requestAlwaysAuthorization()
        }
        
        mapView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 150)
        if !self.view.subviews.contains(mapView) {
            self.view.addSubview(mapView)
        }
        mapView.delegate = self
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(37.506804, 139.930531), 1000, 1000), animated: true)
        
        spots.forEach { spot in
            addSpotPin(spot)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addSpotPin(spot: Spot) {
        let pin = MKPointAnnotation()
        pin.title = spot.name
        pin.subtitle = spot.detail
        pin.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(spot.latitude), CLLocationDegrees(spot.longitude))
        mapView.addAnnotation(pin)
    }
    
    func addPin(lat: Double, lon: Double) {
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(lat), CLLocationDegrees(lon))
        pin.title = "title"
        pin.subtitle = "sub title"
        mapView.addAnnotation(pin)
    }
}

extension MapViewController: CLLocationManagerDelegate {
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
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake((manager.location?.coordinate.latitude)!, (manager.location?.coordinate.longitude)!), 100, 100), animated: true)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
}

extension MapViewController: MKMapViewDelegate {
    // Regionが変更された時に呼び出されるメソッド.
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print("regionDidChangeAnimated")
    }
}
