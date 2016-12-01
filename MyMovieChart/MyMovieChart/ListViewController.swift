import UIKit
class ListViewController : UITableViewController {
    
    // 현재까지 읽어온 데이터의 페이지 정보
    var page = 1
    
    // 테이블 뷰를 구성할 리스트 데이터
    lazy var list : [MovieVO] = {
        var datalist = [MovieVO]()
        return datalist
    }()
    
    // 더보기 버튼
    @IBOutlet var moreBtn: UIButton!
    
    // 더보기 버튼을 눌렀을 때 호출되는 메소드
    @IBAction func more(_ sender: AnyObject) {
        // 현재 페이지 값에 1을 추가한다.
        self.page += 1
        
        // 영화차트 API를 호출한다.
        self.callMovieAPI()
        
        // 데이터를 다시 읽어오도록 테이블 뷰를 갱신한다.
        self.tableView.reloadData()
    }
    
    // 뷰가 처음 메모리에 로드될 때 호출되는 메소드
    override func viewDidLoad( ) {
        
        // 영화차트 API를 호출한다.
        self.callMovieAPI( )
    }
    
    // 영화 차트 API를 호출해주는 메소드
    func callMovieAPI() {
        
        // ① 호핀 API 호출을 위한 URI를 생성
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(self.page)&count=30&genreId=&order=releasedateasc"
        let apiURI : URL! = URL(string: url)
        
        // ② REST API를 호출
        let apidata = try! Data(contentsOf: apiURI)
        
        // ③ 데이터 전송 결과를 로그로 출력 (반드시 필요한 코드는 아님)
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? "데이터가 없습니다"
        NSLog("API Result=\( log )")
        
        // ④ JSON 객체를 파싱하여 NSDictionary 객체로 변환
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            // ⑤ 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            // ⑥ Iterator 처리를 하면서 API 데이터를 MovieVO 객체에 저장한다.
            for row in movie {
                
                // 순회 상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary
                
                // 테이블 뷰 리스트를 구성할 데이터 형식
                let mvo = MovieVO( )
                
                // movie 배열의 각 데이터를 mvo 상수의 속성에 대입
                mvo.title       = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail   = r["thumbnailImage"] as? String
                mvo.detail      = r["linkUrl"] as? String
                mvo.rating      = ((r["ratingAverage"] as! NSString).doubleValue)
                
                // 웹상에 있는 이미지를 읽어와 UIImage 객체로 생성
                let url: URL! = URL(string: mvo.thumbnail!)
                let imageData = try! Data(contentsOf: url)
                mvo.thumbnailImage = UIImage(data:imageData)
                
                // list 배열에 추가
                self.list.append(mvo)
            }
            
            // ⑦ 전체 데이터 카운트를 얻는다.
            let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue
            
            // ⑧ totalCount가 읽어온 데이터 크기와 같거나 클 경우 더보기 버튼을 막는다.
            if (self.list.count >= totalCount) {
                self.moreBtn.isHidden = true
            }

        } catch {
            NSLog("Parse Error!!")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽어온다.
        let row = self.list[indexPath.row]
        
        // 로그 출력
        NSLog("호출된 행번호 : \(indexPath.row), 제목:\(row.title!)")
        
        // as! UITableViewCell => as! MovieCell 로 캐스팅 타입 변경
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        // 데이터 소스에 저장된 값을 각 아울렛 변수에 할당
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"
       
        // 수정) 비동기 방식으로 섬네일 이미지를 읽어옴
        DispatchQueue.main.async(execute: {
            NSLog("비동기 방식으로 실행되는 부분입니다")
            cell.thumbnail.image = self.getThumbnailImage(indexPath.row)
        })
        
        NSLog("메소드 실행을 종료하고 셀을 리턴합니다.")
        
        // 셀 객체를 반환
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다")
    }
    
    // 섬네일 이미지를 제공하는 메소드
    func getThumbnailImage(_ index : Int) -> UIImage {
        // 인자값으로 받은 인덱스를 기반으로 해당하는 배열 데이터를 읽어옴
        let mvo = self.list[index]
        
        // 메모이제이션 처리 : 저장된 이미지가 있을 경우 이를 반환하고, 없을 경우 내려받아 저장한 후 반환함
        if let savedImage = mvo.thumbnailImage {
            return savedImage
        } else {
            let url: URL! = URL(string: mvo.thumbnail!)
            let imageData = try! Data(contentsOf: url)
            mvo.thumbnailImage = UIImage(data:imageData) // UIImage 객체를 생성하여 MovieVO 객체에 우선 저장함
            
            return mvo.thumbnailImage! // 저장된 이미지를 반환
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 실행된 세그웨이의 식별자가 segue_detail"이라면
        if segue.identifier == "segue_detail" {
            // sender 인자를 캐스팅하여 테이블 셀 객체로 변환한다.
            let cell = sender as! MovieCell
            
            // 첫번째 인자값을 이용하여 사용자가 몇번째 행을 선택했는지 확인한다.
            let path = self.tableView.indexPath(for: cell)
            
            // API 영화 데이터 배열 중에서 선택된 행에 대한 데이터를 추출한다.
            let movieinfo = self.list[path!.row]
            
            // 행 정보를 통해 선택된 영화 데이터를 찾은 다음, 목적지 뷰 컨트롤러의 mvo 변수에 대입한다.
            let detailVC = segue.destination as? DetailViewController
            detailVC?.mvo = movieinfo
        }
    }
    
    
}
