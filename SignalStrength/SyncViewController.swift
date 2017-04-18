//
//  SyncViewController.swift
//  SignalStrength
//
//  Created by Henrique do Prado Linhares on 06/11/16.
//  Copyright © 2016 Henrique do Prado Linhares. All rights reserved.
//

import UIKit
import RealmSwift

class SyncViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var serverAddressLabel: UITextField!
    @IBOutlet weak var statusUiView: UITextView!
    @IBOutlet weak var statusTextView: UITextView!
    @IBOutlet weak var pendingReadsLabel: UILabel!
    @IBOutlet weak var syncButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var syncConsole: UITextView!
    
    var updateTimer = NSTimer()
    
    
    // BEGIN UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.serverAddressLabel.delegate = self
        self.configuraStatusNaoSincronizando()
        self.activityIndicator.hidden = true
        self.syncConsole.text = ""
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
        /*
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        self.printString("Tentando conectar com servidor \(self.serverAddressLabel.text!)")
        Synchronizer.sharedInstance.findServer(serverAddressLabel.text!){ (success, servername) in
            if success{
                self.printString("Conectado com sucesso!")
                self.configuraStatusProntoParaSincronizar()
            } else {
                self.printString("Servidor não encontrado.")
                self.configuraStatusNaoSincronizando()
            }
        }*/
    }
    
    func syncronize(){
        let pendingReads = Layer.filter("id = 1").first!.reads.filter("isSyncPending = true")
        let address = self.serverAddressLabel.text!
        for r:Read in pendingReads{
            Synchronizer.sharedInstance.syncRead(r, address: address){ (success) in
                if (success){
                    self.printString("Leitura enviada sucesso!")
                    self.setReadAsSyncronized(r)
                } else {
                    self.printString("Erro ao enviar leitura!")
                }
            }
        }
        self.configuraStatusProntoParaSincronizar()
        self.printString("Sincronização finalizada.")
    }
    
    func setReadAsSyncronized(read:Read){
        let realm = try! Realm()
        try! realm.write{
            read.isSyncPending = false
        }
    }
    
    
    @IBAction func syncButtonAct(sender: AnyObject) {
        self.configuraStatusSincronizando()
        self.activityIndicator.hidden = false
        self.activityIndicator.startAnimating()
        self.printString("Iniciando sincronização")
        self.syncronize()
    }
    
    
    func textFieldDidEndEditing(textField: UITextField) {
        if (self.serverAddressLabel.text != ""){
            findServer()
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func printString(str:String!){
        self.syncConsole.text = self.syncConsole.text + "\(str!)\n"
        let bottomOffset = CGPointMake(0, self.syncConsole.contentSize.height - self.syncConsole.bounds.size.height)
        self.syncConsole.setContentOffset(bottomOffset, animated: false)
            
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
