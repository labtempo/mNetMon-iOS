//
//  ViewController.swift
//  Location
//
//  Created by Henrique do Prado Linhares on 09/10/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import UIKit
import MapKit

/*
ViewController that controls the home screen
*/
class HomeViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var recordLocationSwitch: UISwitch!
    @IBOutlet weak var recordLocationStatusView: UIView!
    
    @IBOutlet weak var authorizationStatusLabel: UILabel!
    @IBOutlet weak var authorizationStatusView: UIView!
    @IBOutlet weak var layerDetailLabel: UILabel!
    
    var updateTimer = NSTimer()
    var currentLayer:Int = 1
    
    override func viewWillAppear(animated: Bool) {
        self.recordLocationSwitch.on = AppData.sharedInstance.getIsCurrentlyReading()
        self.update()
        self.centerMapOnUser()

        self.updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
    }
    
    
    
    func drawMapWithPinsFromReads(pReads:[Read]){
        self.mapView.removeAnnotations(self.mapView.annotations)
        for r:Read in pReads {
            
            var pin:ColorPointAnnotation
            
            switch (r.signalStrength.signalQuality){
                case .verybad: pin = ColorPointAnnotation(pinColor: AppColors.signalVeryBadColor)
                case .bad: pin = ColorPointAnnotation(pinColor: AppColors.signalBadColor)
                case .regular: pin = ColorPointAnnotation(pinColor: AppColors.signalRegularColor)
                case .good: pin = ColorPointAnnotation(pinColor: AppColors.signalGoodColor)
                case .verygood: pin = ColorPointAnnotation(pinColor: AppColors.signalVeryGoodColor)
            }
            
            pin.title = r.ID.description
            pin.coordinate.latitude = r.latitude
            pin.coordinate.longitude = r.longitude
            
            
            mapView.addAnnotation(pin)
        }
    }

    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let pin = view.annotation as! ColorPointAnnotation
        print(pin.title)
        let pinID = Int(pin.title!)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.updateTimer.invalidate()
    }
    
    func centerMapOnUser(){
        let lastUserLocation = Location.sharedInstance.getLastUserLocation()
        if ((lastUserLocation) != nil){
            let lastUserLocationCoord2d = CLLocationCoordinate2D(latitude: (lastUserLocation?.coordinate.latitude)!, longitude: (lastUserLocation?.coordinate.longitude)!)
            self.mapView.setCenterCoordinate(lastUserLocationCoord2d, animated: true)
        }
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let deltaCoeficient = self.mapView.region.span.latitudeDelta + self.mapView.region.span.longitudeDelta
        print ("Delta Coeficient :"+deltaCoeficient.description)
        if (deltaCoeficient < 0.1){
            if (self.currentLayer != 1){
               self.drawMapWithPinsFromReads(LayerManager.getAllReads())
                self.currentLayer = 1
            }
        } else {
                self.drawMapWithPinsFromReads(LayerManager.getReadsByDeltaCoeficient(deltaCoeficient))
                self.currentLayer = 2
        }
    }

    
    func update(){
        self.layerDetailLabel.text = "Layer" + self.currentLayer.description + " - Pins: "+self.mapView.annotations.count.description
        
        if (Location.sharedInstance.doesHaveFullCLAuthorization()){
            self.authorizationStatusLabel.text = "Authorized"
            self.authorizationStatusView.backgroundColor = AppColors.myGreenColor
        } else {
            self.authorizationStatusLabel.text = "Not Authorized"
            self.authorizationStatusView.backgroundColor = AppColors.myRedColor
        }
        
        if (AppData.sharedInstance.getIsCurrentlyReading()){
            self.recordLocationStatusView.backgroundColor = AppColors.myGreenColor
        } else {
            self.recordLocationStatusView.backgroundColor = AppColors.myRedColor
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        AppData.sharedInstance.changeIsCurrentlyReadingStatus()
        if (AppData.sharedInstance.getIsCurrentlyReading()){
            Location.sharedInstance.startReading()
        } else {
            Location.sharedInstance.stopReading()
        }
    }
    
    //MKMapViewDelegate Method - View For Annotation
    //Without using reusable pins
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        let colorPointAnnotation = annotation as! ColorPointAnnotation
        pinView.pinTintColor = colorPointAnnotation.pinColor
        pinView.annotation = annotation
        return pinView
    }
    

    /* MKMapViewDelegate Method - View For Annotation
    Using Reusable identifiers to build pins
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        print("# VIEW FOR ANNOTATION CALLED #")
        
        if annotation is MKUserLocation {
            return nil
        }
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            let colorPointAnnotation = annotation as! ColorPointAnnotation
            pinView?.pinTintColor = colorPointAnnotation.pinColor
        }
        else {
            pinView?.annotation = annotation
        }
        return pinView
    } */
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        let alert = UIAlertController(title: "Memory Warning!", message: "From HomeViewController", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}