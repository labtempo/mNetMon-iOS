//
//  ViewController.swift
//  Location
//
//  Created by Henrique do Prado Linhares on 09/10/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import UIKit
import MapKit

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var recordLocationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        for r:Read in AppData.sharedInstance.reads {
            let pin = MKPointAnnotation()
            pin.coordinate = r.location.coordinate
            pin.title = r.ID.description
            self.mapView.addAnnotation(pin)
        }
    }
    
    @IBAction func switchValueChanged(sender: UISwitch) {
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}

