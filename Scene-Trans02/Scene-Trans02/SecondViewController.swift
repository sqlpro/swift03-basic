
import UIKit

class SecondViewController : UIViewController {
    
    @IBAction func back(_ sender:AnyObject) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @IBAction func back2(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
}






