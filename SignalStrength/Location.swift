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
    private var lastUserLocation:CLLocation?
    
    func getLastUserLocation()->CLLocation?{
        return self.lastUserLocation
    }
 
    func startReading(){
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func doesHaveFullCLAuthorization()->Bool{
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
            return true
        } else {
            return false
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let cellularInfoInstance = CellularInfo()
        let signalStrengthValue = SignalStrengthValue(pDBMValue: cellularInfoInstance.getSignalStrength()!)
        let read = Read(pID: AppData.sharedInstance.getReads().count, pLatitude: (self.locationManager.location?.coordinate.latitude)!, pLongitude: (self.locationManager.location?.coordinate.longitude)!, pSignalStrength: signalStrengthValue, pCarrierName: cellularInfoInstance.getCarrierName())
        AppData.sharedInstance.addRead(read)
        self.lastUserLocation = self.locationManager.location
    }
    
    func stopReading(){
        self.locationManager.stopUpdatingLocation()
    }
    
}