import UIKit
import MapKit
import RealmSwift

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var recordSignalSwitch: UISwitch!
    
    @IBOutlet weak var authorizationStatusLabel: UILabel!
    @IBOutlet weak var authorizationStatusView: UIView!
    
    @IBOutlet weak var serverAddressLabel: UILabel!
    
    @IBOutlet weak var syncReadsButton: UIButton!
    
    
    var updateTimer = NSTimer()
    
    override func viewWillAppear(animated: Bool) {
        self.update()
        self.updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(SettingsViewController.update), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.updateTimer.invalidate()
    }
    
    override func viewDidLoad() {
        
    }
    @IBAction func logsButtonAct(sender: AnyObject) {
        self.performSegueWithIdentifier("view-logs", sender: sender)
    }
    
    @IBAction func recordSignalSwitchChanged(sender: UISwitch) {
        if (sender.on){
            LocationReader.sharedInstance.startReading()
        } else {
            LocationReader.sharedInstance.stopReading()
        }
    }
    
    func update(){
        if (LocationReader.sharedInstance.doesHaveFullCLAuthorization()){
            self.authorizationStatusLabel.text = "Authorized"
            self.authorizationStatusView.backgroundColor = AppColors.viewGreenColor
        } else {
            self.authorizationStatusLabel.text = "Unauthorized"
            self.authorizationStatusView.backgroundColor = AppColors.viewRedColor
        }
        
        if (Server.exists()){
            self.serverAddressLabel.text = Server.getServer()?.address
            self.syncReadsButton.enabled = true
        } else {
            self.serverAddressLabel.text = ""
            self.syncReadsButton.enabled = false
        }

    }
    
    
    @IBAction func configureServerAct(sender: UIButton) {
        self.performSegueWithIdentifier("setup-server", sender: sender)
    }
    
    @IBAction func syncButtonAct(sender: UIButton) {
        self.performSegueWithIdentifier("sync", sender: sender)
    }
    
    
    
}