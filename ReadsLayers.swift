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
    
    
    init(l1:[Read], l2:[Read], l3:[Read], l4:[Read], l5:[Read], l6:[Read], l7:[Read], l8:[Read], l9:[Read], l10:[Read], l11:[Read], l12:[Read], l13:[Read], l14:[Read], l15:[Read], l16:[Read]){
        
        self.readsLayer1 = l1
        self.readsLayer2 = l2
        self.readsLayer3 = l3
        self.readsLayer4 = l4
        self.readsLayer5 = l5
        self.readsLayer6 = l6
        self.readsLayer7 = l7
        self.readsLayer8 = l8
        self.readsLayer9 = l9
        self.readsLayer10 = l10
        self.readsLayer11 = l11
        self.readsLayer12 = l12
        self.readsLayer13 = l13
        self.readsLayer14 = l14
        self.readsLayer15 = l15
        self.readsLayer16 = l16
    
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
        
        self.init(l1:layer1, l2:layer2, l3:layer3, l4:layer4, l5:layer5, l6:layer6, l7:layer7, l8:layer8, l9:layer9, l10:layer10, l11:layer11, l12:layer12, l13:layer13, l14:layer14, l15:layer15, l16:layer16)
    }
    
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.readsLayer1, forKey: "layer1")
        coder.encodeObject(self.readsLayer2, forKey: "layer2")
        coder.encodeObject(self.readsLayer3, forKey: "layer3")
        coder.encodeObject(self.readsLayer4, forKey: "layer4")
        coder.encodeObject(self.readsLayer5, forKey: "layer5")
        coder.encodeObject(self.readsLayer6, forKey: "layer6")
        coder.encodeObject(self.readsLayer7, forKey: "layer7")
        coder.encodeObject(self.readsLayer8, forKey: "layer8")
        coder.encodeObject(self.readsLayer9, forKey: "layer9")
        coder.encodeObject(self.readsLayer10, forKey: "layer10")
        coder.encodeObject(self.readsLayer11, forKey: "layer11")
        coder.encodeObject(self.readsLayer12, forKey: "layer12")
        coder.encodeObject(self.readsLayer13, forKey: "layer13")
        coder.encodeObject(self.readsLayer14, forKey: "layer14")
        coder.encodeObject(self.readsLayer15, forKey: "layer15")
        coder.encodeObject(self.readsLayer16, forKey: "layer16")

    }
    //End of NSCoding Methods
    
}