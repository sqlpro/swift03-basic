import UIKit

class FormViewController : UIViewController {
    
    @IBOutlet var email: UITextField! // 이메일 
    
    @IBOutlet var isUpdate: UISwitch! // 자동갱신 여부
    
    @IBOutlet var interval: UIStepper! // 갱신주기
    
    // Submit 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func onSubmit(_ sender: AnyObject) {
        /* // 16.3.1 직접 값을 주고받기에 해당하는 부분
        // ① 이전 화면을 presentingViewController 속성으로 읽어온 다음
        // ViewController 타입으로 캐스팅한다.
        let preVC = self.presentingViewController
        guard  let vc = preVC as? ViewController else {// ①
            return
        }
 
        // 값을 전달한다.
        vc.paramEmail = self.email.text
        vc.paramUpdate = self.isUpdate.isOn
        vc.paramInterval = self.interval.value
        */
        /*
        // 16.3.2 저장소를 사용하여 값을 주고 받기에 해당하는 부분
        // AppDelegate 객체의 인스턴스를 가져온다.
        let ad = UIApplication.shared().delegate as? AppDelegate // ①
        
        // 값을 저장한다
        ad?.paramEmail = self.email.text
        ad?.paramUpdate = self.isUpdate.isOn
        ad?.paramInterval = self.interval.value
        */
        
        // UserDefaults 객체를 사용하여 값을 주고 받기에 해당하는 부분 
        // UserDefault 객체의 인스턴스를 가져온다
        let userDefaults = UserDefaults.standard
        
        // 값을 저장한다.
        userDefaults.set(self.email.text, forKey: "email")
        userDefaults.set(self.isUpdate.isOn, forKey: "isUpdate")
        userDefaults.set(self.interval.value, forKey: "interval")
        
        // 이전 화면으로 복귀한다.
        self.presentingViewController?.dismiss(animated:true)
    }
}


