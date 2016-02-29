//
//  ReadsLayers.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 29/02/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import Foundation

class ReadsLayers:NSObject, NSCoding{

    var readsLayer1:[Read]
    var readsLayer2:[Read]
    var readsLayer3:[Read]
    var readsLayer4:[Read]
    var readsLayer5:[Read]
    var readsLayer6:[Read]
    var readsLayer7:[Read]
    var readsLayer8:[Read]
    var readsLayer9:[Read]
    var readsLayer10:[Read]
    var readsLayer11:[Read]
    var readsLayer12:[Read]
    var readsLayer13:[Read]
    var readsLayer14:[Read]
    var readsLayer15:[Read]
    var readsLayer16:[Read]


    override init(){
        self.readsLayer1 = [Read]()
        self.readsLayer2 = [Read]()
        self.readsLayer3 = [Read]()
        self.readsLayer4 = [Read]()
        self.readsLayer5 = [Read]()
        self.readsLayer6 = [Read]()
        self.readsLayer7 = [Read]()
        self.readsLayer8 = [Read]()
        self.readsLayer9 = [Read]()
        self.readsLayer10 = [Read]()
        self.readsLayer11 = [Read]()
        self.readsLayer12 = [Read]()
        self.readsLayer13 = [Read]()
        self.readsLayer14 = [Read]()
        self.readsLayer15 = [Read]()
        self.readsLayer16 = [Read]()
    }
    
    
    //Beginning of NSCoding Methods
    required convenience init?(coder decoder: NSCoder) {
        
        guard let layer1 = decoder.decodeObjectForKey("layer1") as? [Read]
        else {return nil }

        guard let layer2 = decoder.decodeObjectForKey("layer2") as? [Read]
            else {return nil }
        
        guard let layer3 = decoder.decodeObjectForKey("layer3") as? [Read]
            else {return nil }

        guard let layer4 = decoder.decodeObjectForKey("layer4") as? [Read]
            else {return nil }
        
        guard let layer5 = decoder.decodeObjectForKey("layer5") as? [Read]
            else {return nil }
        
        guard let layer6 = decoder.decodeObjectForKey("layer6") as? [Read]
            else {return nil }
        
        guard let layer7 = decoder.decodeObjectForKey("layer7") as? [Read]
            else {return nil }
        
        guard let layer8 = decoder.decodeObjectForKey("layer8") as? [Read]
            else {return nil }
        
        guard let layer9 = decoder.decodeObjectForKey("layer9") as? [Read]
            else {return nil }
        
        guard let layer10 = decoder.decodeObjectForKey("layer10") as? [Read]
            else {return nil }
        
        guard let layer11 = decoder.decodeObjectForKey("layer11") as? [Read]
            else {return nil }
        
        guard let layer12 = decoder.decodeObjectForKey("layer12") as? [Read]
            else {return nil }
        
        guard let layer13 = decoder.decodeObjectForKey("layer13") as? [Read]
            else {return nil }
        
        guard let layer14 = decoder.decodeObjectForKey("layer14") as? [Read]
            else {return nil }
        
        guard let layer15 = decoder.decodeObjectForKey("layer15") as? [Read]
            else {return nil }
        
        guard let layer16 = decoder.decodeObjectForKey("layer16") as? [Read]
            else {return nil }
        
        
        
//        self.init(pID: dID, pLatitude:dLatitude, pLongitude:dLongitude, pSignalStrength: dSignalStrength, pCarrierName:dCarrierName)
    }
    
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.ID, forKey: "ID")

    }
    //End of NSCoding Methods
    
}