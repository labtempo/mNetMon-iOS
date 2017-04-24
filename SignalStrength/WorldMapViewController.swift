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

class WorldMapViewController: UIViewController, MKMapViewDelegate {
    
    var updateTimer = NSTimer()
    
    @IBOutlet weak var mapView: MKMapView!
    
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

        

    }
    
    //Beginning of MapView methods
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        generateRequest()
    }

    
    func generateRequest(){
        let topLeft = self.mapView.convertPoint(CGPointMake(0, 0), toCoordinateFromView: self.mapView)
        let pointBottomRight = CGPointMake(self.mapView.frame.size.width, self.mapView.frame.size.height)
        let bottomRight = self.mapView.convertPoint(pointBottomRight, toCoordinateFromView: self.mapView)
        let layer = LayerChooser.chooseLayer(self.mapView.camera.altitude)!
        print("####")
        print("top left:\(topLeft)")
        print("bottom right:\(bottomRight)")
        print("Layer: \(layer.id)")
        print("####")
        
    }
    
    
}