//
//  Location.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 07/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import CoreLocation

class Location:NSObject, CLLocationManagerDelegate{
    
    static let sharedInstance = Location()

    private let locationManager = CLLocationManager()
 
    func startReading(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func doesHaveCLAuthorization()->Bool{
        return true
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let cellularInfoInstance = CellularInfo()
        // read.init() FIX ME
        let read = Read(pID: AppData.sharedInstance.reads.count, pLocation: self.locationManager.location! , pSignalStrength: Float(cellularInfoInstance.getSignalStrength()!), pCarrierName: cellularInfoInstance.getCarrierName())
        AppData.sharedInstance.reads.append(read)
        AppDAO.sharedInstance.saveAppData()
    }
    
    
    func stopReading(){
    
    }
    
    
}