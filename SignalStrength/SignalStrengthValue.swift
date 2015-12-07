//
//  SignalStrengthValue.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 07/12/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

/*

Anything above -80 is good, and would be considered full bars
Anything below -110 is bad, and would be considered few bars

For example, a signal number of -105 is considerably worse than a signal of -70. You’ll generally find that anything approaching -105 or lower is fairly bad reception, 
while anything above -80 is usually good, and if you tap the number signal it’s usually shown as full bars. The full range of the signal numbers extends from -40 to -120, 
with -130 being a nearly impossible number to see because it means no reception, and -40 would be about the strength you’d get being right alongside a cell tower. 
Technically, the number goes all the way to -140, but you will almost never see that because it basically means there is no signal to speak of, and most users will see -120 
or -130 before it switches over to the “No Service” indicator instead.

Once you get the hang of reading the numbers, you’ll find it’s much more accurate, and it becomes easier to predict when you may drop a call or start to get a bad signal or connection, 
which creates the weird artifacts and sounds on phone calls, often before it starts to cut out or even drop completely. That typically starts happening around -110 or so, 
before dropping the connection or call completely if it hits -120 to -130.

*/


import Foundation

class SignalStrengthValue{
    var signalValue:Int
    var signalQuality:SignalQuality
    
    init(pSignalValue:Int){
        self.signalValue = pSignalValue
        self.signalQuality = SignalQuality.calculateSignalQuality(pSignalValue)
    }
    

    

}