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
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolygonRenderer(overlay: overlay)
        var color = UIColor()
        let title = overlay.title!!
        switch title {
            case AppConstants.SIGNAL_VERY_BAD: color = AppColors.signalVeryBadColor
            case AppConstants.SIGNAL_BAD: color = AppColors.signalVeryBadColor
            case AppConstants.SIGNAL_REGULAR: color = AppColors.signalRegularColor
            case AppConstants.SIGNAL_GOOD: color = AppColors.signalGoodColor
            case AppConstants.SIGNAL_VERY_GOOD: color = AppColors.signalVeryGoodColor
            default:break
        }
        render.fillColor = color
        return render
    }
    //End of MapView Methods
    
    
    func update(){
        self.numberOfPinsLabel.text = "Pins: "+self.mapView.annotations.count.description
        //self.deltaCoeficient = self.mapView.region.span.latitudeDelta + self.mapView.region.span.longitudeDelta
        
        if (AppData.sharedInstance.locationReader.doesHaveFullCLAuthorization()){
            self.authorizationStatusLabel.text = "Authorized"
            self.authorizationStatusView.backgroundColor = AppColors.viewGreenColor
        } else {
            self.authorizationStatusLabel.text = "Not Authorized"
            self.authorizationStatusView.backgroundColor = AppColors.viewRedColor
        }

    }
    
    
    private func getReadsInVisibleMapRect()->[Read]{
        
        let layer = Layer.all().filter("id == \(self.currentLayer)").first!
        
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
        self.mapView.removeOverlays(self.mapView.overlays)
        for r:Read in pReads {
            self.makePolyline(r)
            
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
        
        //let layers = Layer.all()
       self.currentLayer = 0
        
        
        /*
        for layer in layers{
            if layer.canBeUsedWithCameraAltitude(self.mapView.camera.altitude){
                self.currentLayer = layer.id - 1
                print("Current layer: "+self.currentLayer.description)
                print("CA: "+self.mapView.camera.altitude.description)
                deltaCoeficientLabel.text = "Lr: "+self.currentLayer.description
            }
        } */
    }
    
    private func drawMapWithPins(){
        let layers = Layer.all()
        self.drawMapWithPinsFromReads(layers[currentLayer].reads)
    }
    
    func makePolyline(read:Read){
        let tr = CLLocationCoordinate2D(latitude: read.latitude, longitude: read.longitude)
        let tl = CLLocationCoordinate2D(latitude: read.latitude, longitude: (read.longitude - 0.002))
        let br = CLLocationCoordinate2D(latitude: (read.latitude - 0.002), longitude: read.longitude)
        let bl = CLLocationCoordinate2D(latitude: (read.latitude - 0.002), longitude: (read.longitude - 0.002))
        var coordinates = [br, tr, tl, bl]
        let square = MKPolygon(coordinates: &coordinates, count: 4)
        let signalQuality = SignalQuality.calculateSignalQuality(read.signalStrength)
        var color:String
        switch (signalQuality){
            case .verybad: color = AppConstants.SIGNAL_VERY_BAD
            case .bad: color = AppConstants.SIGNAL_BAD
            case .regular: color = AppConstants.SIGNAL_REGULAR
            case .good: color = AppConstants.SIGNAL_GOOD
            case .verygood: color = AppConstants.SIGNAL_VERY_GOOD
        }
        square.title = color
        self.mapView.addOverlay(square)
        
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