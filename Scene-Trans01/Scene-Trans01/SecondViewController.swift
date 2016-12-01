
import UIKit

class SecondViewController : UIViewController {
    
    @IBAction func dismiss(_ sender: AnyObject) {
        self.presentingViewController?.dismiss(animated: true)
    }
}
