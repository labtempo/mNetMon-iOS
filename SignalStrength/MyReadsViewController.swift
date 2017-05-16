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
class MyReadsViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var layerLabel: UILabel!
    
    var deltaCoeficient:Double = 1
    
    var currentLayer:Layer?
    
    var updateTimer = NSTimer()
    
    
    //Beginning of ViewController methods
    override func viewWillAppear(animated: Bool) {
        self.update()
        self.centerMapOnUser()
        self.updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(MyReadsViewController.update), userInfo: nil, repeats: true)
    
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.updateTimer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        AlertController.presentAlert("Memory Warning", message: "From My Reads")
    }
    //End of ViewController methods
    
    
    //Beginning of MapView methods
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.chooseLayer()
        self.drawMapWithPins()
    }
    
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        self.chooseLayer()
    }
    
    
    //MKMapViewDelegate Method - Renderer For Overlay
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
        }
    }


    private func centerMapOnUser(){
        let lastUserLocation = LocationReader.sharedInstance.getLastUserLocation()
        if ((lastUserLocation) != nil){
            let lastUserLocationCoord2d = CLLocationCoordinate2D(latitude: (lastUserLocation?.coordinate.latitude)!, longitude: (lastUserLocation?.coordinate.longitude)!)
            self.mapView.setCenterCoordinate(lastUserLocationCoord2d, animated: true)
        }
    }
    
    private func chooseLayer(){
        self.currentLayer = LayerChooser.chooseLayer(self.mapView.camera.altitude)!
        self.layerLabel.text = "Layer \(self.currentLayer!.id)"
    }
    
    private func drawMapWithPins(){
        if (self.currentLayer != nil){
            self.drawMapWithPinsFromReads(self.currentLayer!.reads)
        }
    }
    
    func makePolyline(read:Read){
        let coeficient = self.currentLayer!.precisionCoeficient
        let tr = CLLocationCoordinate2D(latitude: read.latitude, longitude: read.longitude)
        let tl = CLLocationCoordinate2D(latitude: read.latitude, longitude: (read.longitude - coeficient))
        let br = CLLocationCoordinate2D(latitude: (read.latitude - coeficient), longitude: read.longitude)
        let bl = CLLocationCoordinate2D(latitude: (read.latitude - coeficient), longitude: (read.longitude - coeficient))
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
    
    
}