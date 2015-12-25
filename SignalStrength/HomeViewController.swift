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
    @IBOutlet weak var recordLocationStatusView: UIView!
    
    @IBOutlet weak var authorizationStatusLabel: UILabel!
    @IBOutlet weak var authorizationStatusView: UIView!
    
    
    var updateTimer = NSTimer()
    
    
    override func viewWillAppear(animated: Bool) {
        self.recordLocationSwitch.on = AppData.sharedInstance.getIsCurrentlyReading()
        self.update()
        for r:Read in AppData.sharedInstance.getReads() {
            print("iterating loop")
            let pin = MKPointAnnotation()
            pin.title = "Here!"
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
        self.mapView.delegate = self
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
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}

