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
        //todo
        let nePoint = CGPointMake(self.mapView.bounds.origin.x + self.mapView.bounds.size.width, self.mapView.bounds.origin.y)
        let swPoint = CGPointMake(self.mapView.bounds.origin.x, self.mapView.bounds.origin.y + self.mapView.bounds.size.height)
        print("NE: \(nePoint)")
        print("SW: \(swPoint)")
    }
    
    
    
}