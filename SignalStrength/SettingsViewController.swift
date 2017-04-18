import UIKit
import MapKit
import RealmSwift

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var recordSignalSwitch: UISwitch!
    
    @IBOutlet weak var authorizationStatusLabel: UILabel!
    @IBOutlet weak var authorizationStatusView: UIView!
    
    var updateTimer = NSTimer()
    
    override func viewWillAppear(animated: Bool) {
        self.updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(SettingsViewController.update), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.updateTimer.invalidate()
    }
    
    override func viewDidLoad() {
        
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
    
    }
    
    
}