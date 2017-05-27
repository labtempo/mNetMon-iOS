//
//  Layer.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 04/04/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation
import RealmSwift

class Layer: Object{
    
    dynamic var id:Int = 0
    dynamic var minCameraAltitude:Double = 0.0
    dynamic var maxCameraAltitude:Double = 0.0
    dynamic var precisionCoeficient:Double = 0.0
    let reads = List<Read>()
    
    func canBeUsedWithCameraAltitude(cameraAltitude:Double)->Bool{
        if (cameraAltitude >= self.minCameraAltitude && cameraAltitude < self.maxCameraAltitude){
            return true
        }
        
        return false
    }
    
    func addReadToThisLayer(pRead:Read, consolidate:Bool){
        let realm = try! Realm()

        var newRead = Read()
        newRead.latitude = pRead.latitude
        newRead.longitude = pRead.longitude
        newRead.signalStrength = pRead.signalStrength
        newRead.carrierName = pRead.carrierName
        newRead = applyPrecisionCoeficient(newRead)
        
        if (consolidate) {
            let index = self.searchInReads(newRead)
            if (index == -1){
                try! realm.write{
                    self.reads.append(newRead)
                }
            } else {
                let firstRead = self.reads[index]
                let newSignalStrengthValue = ( Double(firstRead.signalStrength) * (1 - AppConstants.ALPHA) ) + ( Double(newRead.signalStrength) * AppConstants.ALPHA )
                try! realm.write{
                    self.reads[index].signalStrength = newSignalStrengthValue
                }
            }
        } else {
            try! realm.write{
                self.reads.append(newRead)
            }
        }
    }
    
    private func applyPrecisionCoeficient(pRead:Read)->Read{
        
        let latitudeINT = (Int(pRead.latitude / self.precisionCoeficient))
        let qLatitude = Double(latitudeINT) * self.precisionCoeficient
        pRead.latitude = qLatitude
        
        let longitudeINT = (Int(pRead.longitude / self.precisionCoeficient))
        let qLongitude = Double(longitudeINT) * self.precisionCoeficient
        pRead.longitude = qLongitude
        
        return pRead
    }
    
    private func searchInReads(pRead:Read)->Int{
        for r:Read in self.reads {
            if (r.latitude == pRead.latitude && r.longitude == pRead.longitude){
                return self.reads.indexOf(r)!
            }
        }
        return -1
    }
    
    private static func calculateSuperiorLayers(){
        let firstLayer = Layer.filter("id = 1").first!
        let layers = Layer.all()
        for layer in layers{
            if (layer.id != 1) {
                layer.calculateLayer(firstLayer)
            }
        }
    }
    
    private func calculateLayer(firstLayer:Layer){
        let firstLayerReads = firstLayer.reads
        var currentLayerReads = [Read]()
        // applying precision coeficient
        for flRead in firstLayerReads{
            var read = Read()
            read.latitude = flRead.latitude
            read.longitude = flRead.longitude
            read.signalStrength = flRead.signalStrength
            read.carrierName = flRead.carrierName
            read.isSyncPending = false
            read = self.applyPrecisionCoeficient(read)
            currentLayerReads.append(read)
        }
        
        //merging duplicateds
        currentLayerReads = mergeDuplicatedReads(currentLayerReads)
        
        let realm = try! Realm()
        try! realm.write{
            self.reads.removeAll()
            for r in currentLayerReads{
                self.reads.append(r)
            }
        }
        
    }
    
    private func mergeDuplicatedReads(reads:[Read])->[Read]{
        var returningReads = [Read]()
        for r in reads{
            let duplicateds = findDuplicatedReads(r, reads: reads)
            if (duplicateds.count == 1){
                returningReads.append(r)
            } else {
                returningReads.append(mergeDuplicatedRead(duplicateds))
            }
        }
        return returningReads
    }
    
    
    
    private func mergeDuplicatedRead(duplicatedRead:[Read])->Read{
        var sum:Double = 0
        for d in duplicatedRead {
            sum = sum + d.signalStrength
        }
        let avg = sum / (Double(duplicatedRead.count))
        
        let first = duplicatedRead.first!
        
        let read = Read()
        read.latitude = first.latitude
        read.longitude = first.longitude
        read.signalStrength = avg
        read.carrierName = first.carrierName
        read.isSyncPending = false
        return read
    }
    
    private func findDuplicatedReads(currentRead:Read, reads:[Read])->[Read]{
        var duplicateds = [Read]()
        for r in reads{
            if (r.latitude == currentRead.latitude && r.longitude == currentRead.longitude){
                duplicateds.append(r)
            }
        }
        
        return duplicateds
    }
    
    
    /* Beginning of RealmSwift data manipulation Methods */
    static func all()->Results<Layer> {
        let realm = try! Realm()
        return realm.objects(Layer.self)
    }
    
    static func filter(query:String)->Results<Layer>{
        let realm = try! Realm()
        return realm.objects(Layer.self).filter(query)
    }
    
    static func addReadToAllLayers(pRead:Read){
        let firstLayer = Layer.filter("id = 1").first!
        firstLayer.addReadToThisLayer(pRead, consolidate: false)
        calculateSuperiorLayers()
    }
    
    /* End of RealmSwift data manipulation Methods */
    
    
}