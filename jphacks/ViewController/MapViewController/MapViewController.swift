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

class MapViewController: BaseViewController {
    
    private let mapView = MKMapView()
    
    let dismissButton: UIButton! = UIButton()
    
    // pinを立てるやつたち
    var spots: [Spot] = []
    
    // 経路として通る点
    var viaLocations: [CLLocationCoordinate2D] = []
    
    // 詳細を上に表示
    var spotDetailView: SpotDetailView! = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let statusBarHeight = Util.getStatusBarHeight()
        mapView.frame = CGRectMake(0, statusBarHeight, self.view.bounds.width, self.view.bounds.height - statusBarHeight)
        if !self.view.subviews.contains(mapView) {
            self.view.addSubview(mapView)
        }
        mapView.delegate = self
        
        // mapの表示範囲
        fitMapWithSpots(viaLocations.first!, toLocation: viaLocations.last!)
        
        // 渡されたspotsについてピンを立てる
        spots.forEach { spot in
            addSpotPin(spot)
        }
        
        // 経路を表示
        var prel: CLLocationCoordinate2D! = nil
        for l in self.viaLocations {
            if let unwrappedPrel = prel {
                addRoute(unwrappedPrel, toCoordinate: l)
            }
            prel = l
        }

        
        // mapをタップしたら詳細が消えるようにrecognizerを追加
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tappedMap")
        mapView.addGestureRecognizer(tapGestureRecognizer)

        // 閉じるボタン
        dismissButton.frame = CGRectMake(30,50, 50,50)
        dismissButton.layer.cornerRadius = 25
        dismissButton.setTitle("✕", forState: .Normal)
        dismissButton.titleLabel?.font = UIFont.systemFontOfSize(30)
        dismissButton.setTitleColor(Constants.COLOR_DISABLED, forState: .Normal)
        dismissButton.setTitleColor(Constants.COLOR_WHITE, forState: .Highlighted)
        dismissButton.backgroundColor = Constants.COLOR_WHITE
        dismissButton.addTarget(self, action: "dismiss", forControlEvents: .TouchUpInside)
        self.view.addSubview(dismissButton)
        
        if spotDetailView == nil {
            spotDetailView = SpotDetailView.create(self)
            self.view.addSubview(spotDetailView)
        }
        spotDetailView.setUp(self.spots.first ?? Spot(name: "大阪", address: "0-0-0", detail: "ｆｄさいｆｊｄしお", latitude: 135, longitude: 35))
        spotDetailView.hidden = true
        
    }
    
    func fitMapWithSpots(fromLocation: CLLocationCoordinate2D, toLocation: CLLocationCoordinate2D) {
        // fromLocation, toLocationに基いてmapの表示範囲を設定
        // 現在地と目的地を含む矩形を計算
        let maxLat: Double
        let minLat: Double
        let maxLon: Double
        let minLon: Double
        if fromLocation.latitude > toLocation.latitude {
            maxLat = fromLocation.latitude
            minLat = toLocation.latitude
        } else {
            maxLat = toLocation.latitude
            minLat = fromLocation.latitude
        }
        if fromLocation.longitude > toLocation.longitude {
            maxLon = fromLocation.longitude
            minLon = toLocation.longitude
        } else {
            maxLon = toLocation.longitude
            minLon = fromLocation.longitude
        }
        
        let center = CLLocationCoordinate2DMake((maxLat + minLat) / 2, (maxLon + minLon) / 2)
        
        let mapMargin:Double = 1.5;  // 経路が入る幅(1.0)＋余白(0.5)
        let leastCoordSpan:Double = 0.005;    // 拡大表示したときの最大値
        let span = MKCoordinateSpanMake(fmax(leastCoordSpan, fabs(maxLat - minLat) * mapMargin), fmax(leastCoordSpan, fabs(maxLon - minLon) * mapMargin))
        
        mapView.setRegion(mapView.regionThatFits(MKCoordinateRegionMake(center, span)), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tappedMap() {
        self.spotDetailView.hidden = true
    }
    
    func dismiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addSpotPin(spot: Spot) {
        let pin = MKPointAnnotation()
        pin.title = spot.name
        pin.subtitle = spot.detail
        pin.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(spot.latitude), CLLocationDegrees(spot.longitude))
        
        mapView.addAnnotation(pin)
    }
    
    func addPin(location: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = location
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
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation === mapView.userLocation { // 現在地を示すアノテーションの場合はデフォルトのまま
            return nil
        } else {
            let reuseId = "pin"
            var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
            if pinView == nil {
                pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView?.animatesDrop = true
            }
            else {
                pinView?.annotation = annotation
            }
            
            return pinView
        }
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        print("callout tapped2")
        spotDetailView.hidden = false
    }

}
