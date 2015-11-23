//
//  ViewController.swift
//  Location
//
//  Created by Henrique do Prado Linhares on 09/10/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import CoreTelephony

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    
    let locationManager = CLLocationManager()
   
    let netInfo = CTTelephonyNetworkInfo()
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var recordLocationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        
        let operadora = self.netInfo.subscriberCellularProvider
        

    }
    
    
    @IBAction func switchValueChanged(sender: UISwitch) {
        if (recordLocationSwitch.on){
            self.locationManager.startUpdatingLocation()
        } else {
            self.locationManager.stopUpdatingLocation()
        }
    }
    
    
    /*
    func getSignalStrength(){
        let app = UIApplication.sharedApplication()
        let subViews = app.valueForKey("statusBar")?.valueForKey("foregroundView")?.subviews
        var dataNetworkItemView:NSObject
        
        for var subview in subViews!{
            if (subview.isKindOfClass(NSClassFromString("UIStatusBarSignalStrengthItemView")!)){
            dataNetworkItemView = subview
            var signal = dataNetworkItemView.valueForKey("signalStrengthRaw") as! Int
              //  sinalLabel.text = "Sinal: "+signal.description
            }
        }
    }*/
    
    


    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let read = Read(pID: AppData.sharedInstance.reads.count, pLocation: self.locationManager.location! , pSignalStrength: 0)
        AppData.sharedInstance.reads.append(read)
        
        print("reading..")
        print(read.toString())
        AppDAO.sharedInstance.saveAppData()
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    
    
    
}

