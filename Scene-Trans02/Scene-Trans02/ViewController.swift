
import UIKit

class ViewController: UIViewController {
    
    @IBAction func moveByNavy(_ sender: AnyObject) {
        // 두번째 뷰 컨트롤러 인스턴스를 가져온다.
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return
        }
        // 화면을 전환한다.
        self.navigationController?.pushViewController(uvc, animated: true)
    }
    
    @IBAction func movePresent(_ sender: AnyObject) {
        // 두번째 뷰 컨트롤러 인스턴스를 가져온다.
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "SecondVC") else {
            return
        }
        // 화면을 전환한다.
        self.present(uvc, animated: true)
    }
}

