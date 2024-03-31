//
//  MapViewController.swift
//  CafeMemo
//
//  Created by misaki on 2024/03/13.
//

import UIKit
import MapKit
import RealmSwift
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    let realm = try! Realm() // Realmのインスタンスを定義

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        showPinsOnMap()
    }

    /*func showPinsOnMap() {
        let tweets = realm.objects(Tweet.self)

        for tweet in tweets {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: tweet.latitude, longitude: tweet.longitude)
            mapView.addAnnotation(annotation)
        }
    }*/
    func showPinsOnMap() {
        let tweets = realm.objects(Tweet.self)

        for tweet in tweets {
            // 緯度と経度の値が両方とも0でない場合にピンを表示する
            if tweet.latitude != 0 && tweet.longitude != 0 {
                let annotation = MKPointAnnotation()
                annotation.coordinate = CLLocationCoordinate2D(latitude: tweet.latitude, longitude: tweet.longitude)
                mapView.addAnnotation(annotation)
            }
        }
    }

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "pin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }
}
