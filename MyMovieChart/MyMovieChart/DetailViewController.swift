import UIKit

class DetailViewController : UIViewController, UIWebViewDelegate {

    @IBOutlet var wv: UIWebView!
    
    // 목록 화면에서 전달하는 영화 정보를 받을 변수
    var mvo : MovieVO!
    
    // 로딩 상태를 표시할 인디케이터 뷰
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        
        NSLog("linkurl = \(self.mvo?.detail), title=\(self.mvo?.title)")
        
        // 내비게이션 바의 타이틀에 영화명을 출력한다.
        let navibar = self.navigationItem
        navibar.title = self.mvo?.title

        if let url = self.mvo?.detail {
            if let urlObj = URL(string: url) {
                let req = URLRequest(url:urlObj)
                self.wv.loadRequest(req)
            } else { // URL 형식이 잘못되었을 경우에 대한 예외처리
                
                // 경고창 형식으로 오류 메시지를 표시해준다.
                let alert = UIAlertController(title: "오류",
                                              message: "잘못된 URL입니다",
                                              preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "확인", style: .cancel) {
                    (_) in
                    // 이전 페이지로 되돌려보낸다.
                    _ = self.navigationController?.popViewController(animated: true)
                }
                
                alert.addAction(cancelAction)
                self.present(alert, animated: false, completion: nil)
            }
        } else { // URL 값이 전달되지 않았을 경우에 대한 예외처리
            
            // 경고창 형식으로 오류 메시지를 표시해준다.
            let alert = UIAlertController(title: "오류",
                                          message: "필수 파라미터가 누락되었습니다.",
                                          preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel) {
                (_) in
                // 이전 페이지로 되돌려보낸다.
                _ = self.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(cancelAction)
            self.present(alert, animated: false, completion: nil)
        }
    }
    
    // 웹 뷰가 웹페이지를 로드하기 시작할 때
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.spinner.startAnimating() // 인디케이터 뷰의 애니메이션을 실행
    }
    
    // 웹 뷰가 웹페이지 로드를 완료했을 때
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.spinner.stopAnimating( ) // 인디케이터 뷰의 애니메이션을 중지
    }
    
    // 웹 뷰가 웹페이지 로드를 실패했을 때
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        self.spinner.stopAnimating( ) // 인디케이터 뷰의 애니메이션을 중지
        
        // 경고창 형식으로 오류 메시지를 표시해준다.
        let alert = UIAlertController(title: "오류",
                                      message: "상세페이지를 읽어오지 못했습니다",
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "확인", style: .cancel) {
            (_) in
            // 이전 페이지로 되돌려보낸다.
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(cancelAction)
        self.present(alert, animated: false, completion: nil)
        
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
}
