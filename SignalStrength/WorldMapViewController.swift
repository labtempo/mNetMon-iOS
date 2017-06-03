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
import Foundation
import SwiftyJSON

class WorldMapViewController: UIViewController, MKMapViewDelegate {
    
    var updateTimer = NSTimer()
    
    @IBOutlet weak var mapView: MKMapView!
    
    var reads = [Read]()
    
    var currentLayer:Layer?
    
    override func viewWillAppear(animated: Bool) {
        if !Server.exists() {
            AlertController.presentAlert("Not connected to server", message: "Please, connect to a server")
        }
        self.updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(WorldMapViewController.update), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.updateTimer.invalidate()
    }
    
    override func viewDidLoad() {
    }
    
    func update(){
        drawMap()
    }
    
    private func drawMap(){
        if (self.currentLayer != nil){
            self.drawMapWithPinsFromReads(self.reads)
        }
    }
    
    private func drawMapWithPinsFromReads(pReads:[Read]){
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.mapView.removeOverlays(self.mapView.overlays)
        for r:Read in pReads {
            self.makePolyline(r)
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
    
    
    //Beginning of MapView methods
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        self.currentLayer = LayerChooser.chooseLayer(self.mapView.camera.altitude)
        getReadsForMap()
    }

    
    func getReadsForMap(){
        let topLeft = self.mapView.convertPoint(CGPointMake(0, 0), toCoordinateFromView: self.mapView)
        let pointBottomRight = CGPointMake(self.mapView.frame.size.width, self.mapView.frame.size.height)
        let bottomRight = self.mapView.convertPoint(pointBottomRight, toCoordinateFromView: self.mapView)
        let layer = LayerChooser.chooseLayer(self.mapView.camera.altitude)!
        ReadService.requestReadsInArea(topLeft, bottomRight: bottomRight, layerId: layer.id) { (success, json) in
            if (success){
                self.reads.removeAll()
                for (_, subJson):(String, JSON) in json{
                    let r = Read()
                    r.latitude = subJson["latitude"].doubleValue
                    r.longitude = subJson["longitude"].doubleValue
                    r.signalStrength = subJson["signalStrength"].doubleValue
                    self.reads.append(r)
                }
            } else {
                print ("Error")
            }
        }
    }
    
    
}