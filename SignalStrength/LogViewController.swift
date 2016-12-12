//
//  LogViewController.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 23/11/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import UIKit
import RealmSwift

/*
ViewController that controls the log screen
*/
class LogViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        let layer01 = LayerAcR.all().filter("id == 1")[0]
        
        print(layer01)
        
        let reads = layer01.reads
        
        print(reads)
      //  var text = "Number of reads: \(reads.count) \n \n"
      //  for r:Read in reads {
      //      text += r.toString() + "\n \n"
       // }
       // self.textView.text = text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        let alert = UIAlertController(title: "Memory Warning!", message: "From LogViewController", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}