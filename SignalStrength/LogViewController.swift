//
//  LogViewController.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 23/11/15.
//  Copyright © 2015 Henrique do Prado Linhares. All rights reserved.
//

import UIKit

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
        var text = "Number of reads: \(AppData.sharedInstance.getReads().count) \n \n"
        for r:Read in AppData.sharedInstance.getReads() {
            text += r.toString() + "\n \n"
        }
        self.textView.text = text
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        let alert = UIAlertController(title: "Memory Warning!", message: "From LogViewController", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}