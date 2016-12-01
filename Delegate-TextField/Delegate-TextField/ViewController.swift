import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var msg: UILabel!

    @IBOutlet var tf: UITextField!
    
    var count = 0
    
    override func viewDidLoad() {
        /**
         * 입력값 속성 설정
         */
        self.tf.placeholder = "값을 입력하세요" // 안내메세지 
        self.tf.keyboardType = UIKeyboardType.alphabet // 키보드 타입 영문자 패드로
        self.tf.keyboardAppearance = UIKeyboardAppearance.dark // 키보드 스타일 어둡게
        self.tf.returnKeyType = UIReturnKeyType.join // 리턴키 타입은 "Join"
        self.tf.enablesReturnKeyAutomatically = true // 리턴키 자동 활성화 "On"
        self.tf.clearButtonMode = UITextFieldViewMode.always // 내부에 클리어 버튼 표시
        self.tf.clearsOnBeginEditing = true // 편집 시작시 기존 내용 삭제
        
        /**
         * 스타일 설정
         */
        // 테두리 스타일 - 직선
        self.tf.borderStyle = UITextBorderStyle.line
        
        // 배경색상
        self.tf.backgroundColor = UIColor(white:0.87, alpha:1.0)
        
        // 수직 방향 텍스트 배열 위치 - 가운데
        tf.contentVerticalAlignment = UIControlContentVerticalAlignment.center
        
        // 수평방향 텍스트 배열 위치 - 가운데
        self.tf.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        
        // 테두리 색상 - 회색
        self.tf.layer.borderColor = UIColor.darkGray.cgColor
        
        // 테두리 두께 - 1.0 픽셀
        self.tf.layer.borderWidth = 2.0
        
        // 텍스트 필드를 최초 응답자로
        //self.tf.becomeFirstResponder()
        
        // 델리게이트 지정
        self.tf.delegate = self
    }
    
    @IBAction func up(_ sender:AnyObject) {
        self.tf.becomeFirstResponder()
    }
    
    @IBAction func down(_ sender:AnyObject ) {
        self.tf.resignFirstResponder()
    }
    
    @IBAction func confirm(_ sender:AnyObject) {
        // 텍스트 필드를 최초 응답자 객체에서 해제
        self.tf.resignFirstResponder()
    }
    
    @IBAction func input(_ sender: AnyObject) {
        // 텍스트 필드를 최초 응답자 객체로 지정 
        self.tf.becomeFirstResponder()
    }
    
    // 텍스트필드의 편집을 시작할 때 실행
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 시작됩니다.")
        return true // false를 리턴하면 편집되지 않는다.
    }
    
    // 텍스트 필드의 편집이 시작된 후 실행
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("텍스트 필드의 편집이 시작되었습니다.")
    }
    
    // 텍스트 필드의 내용이 삭제될 때 실행
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 내용이 삭제됩니다.")
        return true // false를 리턴하면 삭제되지 않는다.
    }
    
    // 텍스트 필드의 내용이 변경될 때 실행
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("텍스트 필드의 내용이 \(string)으로 변경됩니다")
        if Int(string) == nil { // 입력된 값이 숫자가 아니라면 true를 리턴
            if (textField.text?.characters.count)! + string.characters.count > 10 {
                return false
            } else {
                return true
            }
        } else { // 입력된 값이 숫자라면 false를 리턴
            return false
        }
    }
    
    // 텍스트 필드의 리턴키가 눌러졌을 때 실행
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("텍스트 필드의 리턴키가 눌러졌습니다")
        return true
    }
    
    // 텍스트 필드 편집이 종료될 때 실행
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("텍스트 필드의 편집이 종료됩니다.")
        return true // false를 리턴하면 편집이 종료되지 않는다.
    }
    
    // 텍스트 필드의 편집이 종료되었을 때 실행
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("텍스트 필드의 편집이 종료되었습니다.")
    }
    

}


















