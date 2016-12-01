
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var uiTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func sayHello(_ sender: AnyObject) {
        self.uiTitle.text = "Hello, World!"
    }
}

