//
//  Location.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 07/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import CoreLocation

class LocationReader:NSObject, CLLocationManagerDelegate{
    
    static let sharedInstance = LocationReader()
    
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
        self.locationManager.allowsBackgroundLocationUpdates = true
        print ("LocationReader Starts")
    }
    
    func stopReading(){
        self.locationManager.stopUpdatingLocation()
        print ("LocationReader Stops")
    }
    
    
    func doesHaveFullCLAuthorization()->Bool{
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.AuthorizedAlways){
            return true
        } else {
            return false
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print ("~ LOCATION UPDATE ~")
        let signalStrengthInDBM = CellularInfo().getSignalStrengthInDbm()
        if (signalStrengthInDBM != nil){
            let read = Read()
            read.latitude = (self.locationManager.location?.coordinate.latitude)!
            read.longitude = (self.locationManager.location?.coordinate.longitude)!
            read.signalStrength = SignalConverter.DBMtoASU(signalStrengthInDBM!)
            read.carrierName = CellularInfo().getCarrierName()
            Layer.addReadToAllLayers(read)
        } else {
            AlertController.presentAlert("Error", message: "Cannot read your signal strength")
        }
        self.lastUserLocation = self.locationManager.location
    }
    
}