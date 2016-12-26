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
    @IBOutlet weak var pendingReadsLabel: UILabel!
    @IBOutlet weak var syncButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var updateTimer = NSTimer()
    
    
    // BEGIN UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serverAddressLabel.delegate = self
        self.configuraStatusNaoSincronizando()
        self.activityIndicator.hidden = true
    }
    
    //Beginning of ViewController methods
    override func viewWillAppear(animated: Bool) {
        self.update()
        self.updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(SyncViewController.update), userInfo: nil, repeats: true)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.updateTimer.invalidate()
    }
    
    
    // END UIViewController Methods
    
    func update(){
        let firstLayerReads = Layer.filter("id = 1").first!
        let numOfPendingSyncReads = firstLayerReads.reads.filter("isSyncPending = true").count
        self.pendingReadsLabel.text = "\(numOfPendingSyncReads) Leituras pendentes"
    }
    
    
    func configuraStatusNaoSincronizando(){
        self.statusUiView.backgroundColor = UIColor.redColor()
        self.statusTextView.text = "Não está sincronizando"
        self.syncButton.enabled = false
        self.activityIndicator.hidden = true
        self.activityIndicator.stopAnimating()
        
    }
    
    
    func configuraStatusProntoParaSincronizar(){
        self.statusUiView.backgroundColor = UIColor.orangeColor()
        self.statusTextView.text = "Pronto para sincronizar"
        self.syncButton.enabled = true
        self.activityIndicator.hidden = true
        self.activityIndicator.stopAnimating()
        
    }
    
    
    func configuraStatusSincronizando(){
        self.statusUiView.backgroundColor = UIColor.greenColor()
        self.statusTextView.text = "Está sincronizando"
        self.syncButton.enabled = false
    }
    
    func findServer(){
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        
        Synchronizer.sharedInstance.findServer(serverAddressLabel.text!){ (success, servername) in
            if success{
                let alertController = UIAlertController(title: "Sucesso", message:"Conectado ao servidor \(servername!).", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                self.configuraStatusProntoParaSincronizar()
            } else {
                let alertController = UIAlertController(title: "Erro", message:"Não foi possível localizar o servidor.", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                self.configuraStatusNaoSincronizando()
            }
        }

  
    }
    
    
    @IBAction func syncButtonAct(sender: AnyObject) {
        self.configuraStatusSincronizando()
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        print("Começar a sincronizar")
        Synchronizer.sharedInstance.startSync()
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
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

}
