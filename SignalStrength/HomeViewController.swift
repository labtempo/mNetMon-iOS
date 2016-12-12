//
//  ViewController.swift
//  Location
//
//  Created by Henrique do Prado Linhares on 09/10/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

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
    
    var deltaCoeficient:Double = 1
    
    var currentLayer = 0
    
    var updateTimer = NSTimer()
    
    
    //Beginning of ViewController methods
    override func viewWillAppear(animated: Bool) {
        self.update()
        self.centerMapOnUser()
        self.updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(HomeViewController.update), userInfo: nil, repeats: true)
    
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.updateTimer.invalidate()
    }
    
    override func viewDidLoad() {
        self.recordLocationSwitch.on = false
        self.recordLocationStatusView.backgroundColor = AppColors.viewRedColor
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
        self.chooseLayer()
        self.drawMapWithPins()
    }
    
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        self.chooseLayer()
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
        self.deltaCoeficient = self.mapView.region.span.latitudeDelta + self.mapView.region.span.longitudeDelta
        
        if (AppData.sharedInstance.locationReader.doesHaveFullCLAuthorization()){
            self.authorizationStatusLabel.text = "Authorized"
            self.authorizationStatusView.backgroundColor = AppColors.viewGreenColor
        } else {
            self.authorizationStatusLabel.text = "Not Authorized"
            self.authorizationStatusView.backgroundColor = AppColors.viewRedColor
        }

    }
    
    
    private func getReadsInVisibleMapRect()->[Read]{
        
        let layer = LayerAcR.all().filter("id == \(self.currentLayer)").first!
        
        var pins = layer.reads
        
        var readsInVisibleMapRect = [Read]()
        
        while (!pins.isEmpty){
            let pin = pins.removeFirst()
            if (self.mapView.annotationsInMapRect(self.mapView.visibleMapRect).contains(pin as NSObject)){
                readsInVisibleMapRect.append(pin)
            }
        }
        return readsInVisibleMapRect
    }
    
    
    private func drawMapWithPinsFromReads(pReads:List<Read>){
        self.mapView.removeAnnotations(self.mapView.annotations)
        for r:Read in pReads {
            
            var pin:ColorPointAnnotation
            
            let signalQuality = SignalQuality.calculateSignalQuality(r.signalStrength)
            
            switch (signalQuality){
                case .verybad: pin = ColorPointAnnotation(pinColor: AppColors.signalVeryBadColor)
                case .bad: pin = ColorPointAnnotation(pinColor: AppColors.signalBadColor)
                case .regular: pin = ColorPointAnnotation(pinColor: AppColors.signalRegularColor)
                case .good: pin = ColorPointAnnotation(pinColor: AppColors.signalGoodColor)
                case .verygood: pin = ColorPointAnnotation(pinColor: AppColors.signalVeryGoodColor)
            }
            
            pin.coordinate.latitude = r.latitude
            pin.coordinate.longitude = r.longitude
            
            
            mapView.addAnnotation(pin)
            if (!mapView.annotationsInMapRect(self.mapView.visibleMapRect).contains(pin)){
                self.mapView.removeAnnotation(pin)
            }
        }
    }


    private func centerMapOnUser(){
        let lastUserLocation = AppData.sharedInstance.locationReader.getLastUserLocation()
        if ((lastUserLocation) != nil){
            let lastUserLocationCoord2d = CLLocationCoordinate2D(latitude: (lastUserLocation?.coordinate.latitude)!, longitude: (lastUserLocation?.coordinate.longitude)!)
            self.mapView.setCenterCoordinate(lastUserLocationCoord2d, animated: true)
        }
    }
    
    private func chooseLayer(){
        
        let layers = LayerAcR.all()
        
        for layer in layers{
            if layer.canBeUsedWithCurrentDelta(self.deltaCoeficient){
                self.currentLayer = layer.id - 1
                print("Current layer: "+self.currentLayer.description)
                deltaCoeficientLabel.text = "Lr: "+self.currentLayer.description
            }
        }
    }
    
    private func drawMapWithPins(){
        let layers = LayerAcR.all()
        self.drawMapWithPinsFromReads(layers[currentLayer].reads)
    }
    
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        if sender.on {
            AppData.sharedInstance.locationReader.startReading()
            self.recordLocationStatusView.backgroundColor = AppColors.viewGreenColor
        } else {
            AppData.sharedInstance.locationReader.stopReading()
            self.recordLocationStatusView.backgroundColor = AppColors.viewRedColor
        }
    }
    
    
}