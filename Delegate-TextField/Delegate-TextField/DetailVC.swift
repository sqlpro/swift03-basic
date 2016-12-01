//
//  DetailVC.swift
//  Delegate-TextField
//
//  Created by prologue on 2016. 8. 10..
//  Copyright © 2016년 SQLPRO. All rights reserved.
//

import UIKit

class DetailVC : UIViewController, UITextFieldDelegate {
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
    }
    
    @IBAction func check(_ sender: AnyObject) {
        print("Check!!")
        count += 1        
        self.msg.text = "\(self.count)"
    }
    
    @IBAction func confirm(_ sender:AnyObject) {
        // 텍스트 필드를 최초 응답자 객체에서 해제
        self.tf.resignFirstResponder()
    }
    
    @IBAction func input(_ sender: AnyObject) {
        // 텍스트 필드를 최초 응답자 객체로 지정
        self.tf.becomeFirstResponder()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBegingEditing execute!")
        return true
    }
}
