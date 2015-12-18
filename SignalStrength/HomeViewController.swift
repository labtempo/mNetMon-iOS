//
//  ViewController.swift
//  Location
//
//  Created by Henrique do Prado Linhares on 09/10/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var recordLocationSwitch: UISwitch!
    
    @IBOutlet weak var authorizationStatusLabel: UILabel!
    
    
    var updateTimer = NSTimer()
    
    
    override func viewWillAppear(animated: Bool) {
        for r:Read in AppData.sharedInstance.getReads() {
            let pin = MyPointAnnotation(pSignalQuality: r.signalStrength.signalQuality)
            pin.coordinate.latitude = r.latitude
            pin.coordinate.latitude = r.longitude
            mapView.addAnnotation(pin)
        }
        self.updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "update", userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.updateTimer.invalidate()
    }
    
    
    func update(){
        if (Location.sharedInstance.doesHaveFullCLAuthorization()){
            self.authorizationStatusLabel.text = "Authorized"
        } else {
            self.authorizationStatusLabel.text = "Not Authorized"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func switchValueChanged(sender: UISwitch) {
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}

