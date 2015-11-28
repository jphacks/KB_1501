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
    
    private let mapView = MKMapView()
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
        addRoute(CLLocationCoordinate2D(latitude:34.6944022737767, longitude: 135.195888597644), toCoordinate: CLLocationCoordinate2D(latitude: 34.709759, longitude: 135.248512))
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
    
    func addRoute(fromCoordinate: CLLocationCoordinate2D, toCoordinate: CLLocationCoordinate2D) {
        let fromItem: MKMapItem = MKMapItem(placemark: MKPlacemark(coordinate: fromCoordinate, addressDictionary: nil))
        let toItem: MKMapItem = MKMapItem(placemark: MKPlacemark(coordinate: toCoordinate, addressDictionary: nil))
        
        // MKDirectionsRequestを生成.
        let myRequest: MKDirectionsRequest = MKDirectionsRequest()
        
        // 出発&目的地
        myRequest.source = fromItem
        myRequest.destination = toItem
        
        myRequest.requestsAlternateRoutes = false
        
        // 徒歩
        myRequest.transportType = MKDirectionsTransportType.Walking
        
        // MKDirectionsを生成してRequestをセット.
        let myDirections: MKDirections = MKDirections(request: myRequest)
        
        // 経路探索.
        myDirections.calculateDirectionsWithCompletionHandler { (response: MKDirectionsResponse?, error: NSError?) -> Void in
            if error != nil {
                print(error)
                return
            }
            
            if let route = response?.routes.first as MKRoute? {
                print("目的地まで \(route.distance)km")
                print("所要時間 \(Int(route.expectedTravelTime/60))分")
            
                // mapViewにルートを描画.
                self.mapView.addOverlay(route.polyline)
            }

        }
    }
    
    // tapをおいたとき用
    func getLocationFromTap(sender: UILongPressGestureRecognizer) -> CLLocationCoordinate2D {
        return self.mapView.convertPoint(sender.locationInView(mapView), toCoordinateFromView: mapView)
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
        // 中心を変更
        mapView.setCenterCoordinate(CLLocationCoordinate2DMake((manager.location?.coordinate.latitude)!, (manager.location?.coordinate.longitude)!), animated: true)
        
        // test, add pin
        addPin((manager.location?.coordinate.latitude)!, lon: (manager.location?.coordinate.longitude)!)
        print("\(manager.location?.coordinate.latitude),\(manager.location?.coordinate.longitude)")
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
    
    // 経路を描画するときの色や線の太さを指定
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 3
            return polylineRenderer
        } else {
            // ダミー
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        }
    }
}
