//
//  SyncViewController.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 06/11/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import UIKit

class SyncViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var serverAddressLabel: UITextField!

    @IBOutlet weak var statusUiView: UITextView!
    
    @IBOutlet weak var statusTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serverAddressLabel.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    func configuraStatusNaoSincronizando(){
        self.statusUiView.backgroundColor = UIColor.redColor()
        self.statusTextView.text = "Não está sincronizando"
    }
    
    
    func configuraStatusSincronizando(){
        self.statusUiView.backgroundColor = UIColor.greenColor()
        self.statusTextView.text = "Está sincronizando"
    }
    
    func findServer(){
        print("passou 2")
        Synchronizer.sharedInstance.findServer(serverAddressLabel.text!)
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print("passou 1")
        findServer()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //dismiss keyboard on return button
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //Dismiss keyboard when a tap is recognized
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
