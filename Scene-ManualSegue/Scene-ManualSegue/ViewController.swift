
import UIKit

class ViewController: UIViewController {

    @IBAction func wind(_ sender: AnyObject) {
        
        // 세그웨이를 실행한다
        self.performSegue(withIdentifier:"ManualWind", sender: self)
    }
}

