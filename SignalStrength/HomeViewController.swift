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

    @IBOutlet weak var numberOfPinsLabel: UILabel!
    
    @IBOutlet weak var deltaCoeficientLabel: UILabel!
    
    
    var updateTimer = NSTimer()
    
    
    //Beginning of ViewController methods
    override func viewWillAppear(animated: Bool) {
        self.recordLocationSwitch.on = AppData.sharedInstance.getIsCurrentlyReading()
        self.update()
        self.centerMapOnUser()
        self.updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.updateTimer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        let alert = UIAlertController(title: "Memory Warning!", message: "From HomeViewController", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    //End of ViewController methods
    
    
    //Beginning of MapView methods
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let pin = view.annotation as! ColorPointAnnotation
        print(pin.title)
    }
    
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.drawMapWithPins()
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
    //End of MapView Methods
    
    
    func update(){
        self.numberOfPinsLabel.text = "Pins: "+self.mapView.annotations.count.description
        let deltaCoeficient = self.mapView.region.span.latitudeDelta + self.mapView.region.span.longitudeDelta
        self.deltaCoeficientLabel.text = "MapDelta :" + deltaCoeficient.description
        
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
    
    
    private func getReadsInVisibleMapRect()->[Read]{
        
        var pins = AppData.sharedInstance.getReads()
        
        var readsInVisibleMapRect = [Read]()
        
        while (!pins.isEmpty){
            let pin = pins.removeFirst()
            if (self.mapView.annotationsInMapRect(self.mapView.visibleMapRect).contains(pin as NSObject)){
                readsInVisibleMapRect.append(pin)
            }
        }
        return readsInVisibleMapRect
    }
    
    
    private func drawMapWithPinsFromReads(pReads:[Read]){
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
            if (!mapView.annotationsInMapRect(self.mapView.visibleMapRect).contains(pin)){
                self.mapView.removeAnnotation(pin)
            }
        }
    }


    private func centerMapOnUser(){
        let lastUserLocation = Location.sharedInstance.getLastUserLocation()
        if ((lastUserLocation) != nil){
            let lastUserLocationCoord2d = CLLocationCoordinate2D(latitude: (lastUserLocation?.coordinate.latitude)!, longitude: (lastUserLocation?.coordinate.longitude)!)
            self.mapView.setCenterCoordinate(lastUserLocationCoord2d, animated: true)
        }
    }
    
    
    
    private func drawMapWithPins(){
        let deltaCoeficient = self.mapView.region.span.latitudeDelta + self.mapView.region.span.longitudeDelta
        print ("Delta Coeficient :"+deltaCoeficient.description)
        self.drawMapWithPinsFromReads(AppData.sharedInstance.getReads())
    }
    
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        AppData.sharedInstance.changeIsCurrentlyReadingStatus()
        if (AppData.sharedInstance.getIsCurrentlyReading()){
            Location.sharedInstance.startReading()
        } else {
            Location.sharedInstance.stopReading()
        }
    }
    
    
}