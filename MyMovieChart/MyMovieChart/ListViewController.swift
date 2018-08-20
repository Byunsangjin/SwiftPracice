//
//  ListViewController.swift
//  MyMovieChart
//
//  Created by sjbyun on 2018. 8. 7..
//  Copyright © 2018년 Byunsangjin. All rights reserved.
//

import UIKit
class ListViewController: UITableViewController {
    // 테이블 뷰를 구성할 리스트 데이터
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        
        return datalist
    }()
    var page = 1
    @IBOutlet var moreBtn: UIButton!
    
    
    override func viewDidLoad() {
        self.callMovieAPI()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽어온다
        let row = self.list[indexPath.row]
        
        // 로그 출력
        //NSLog("제목:\(row.title!), 호출된 행번호:\(indexPath.row)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! MovieCell
        
        // 데이터 소스에 저장된 값을 각 아울렛 변수에 할당
        cell.title?.text = row.title
        cell.desc?.text = row.description
        cell.opendate?.text = row.opendate
        cell.rating?.text = "\(row.rating!)"

        
//--------------------------------------------------------------------------------------- 기존 썸네일을 받는 방법
//        //  섬네일 경로를 인자값으로 하는 URL 객체를 생성
//        let url: URL! = URL(string: row.thumbnail!)
//
//        // 이미지를 읽어와 Data 객체에 저장
//        let imageData = try! Data(contentsOf: url)
//
//        // UIImage 객체를 생성하여 아울렛 변수의 image 속성에 대입
//        cell.thumbnail.image = UIImage(data:imageData)
        
//        // 이미지 객체를 대입한다
//        cell.thumbnail.image = row.thumbnailImage
        
        // 수정) 비동기 ㅅ방식으로 섬네일 이미지를 읽어옴
        DispatchQueue.main.async (execute: {
            cell.thumbnail.image = self.getThumbnailImage(indexPath.row)
        })
        
        // 구성될 셀을 반환함
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            NSLog("선택된 행은 \(indexPath.row) 번째 행입니다.")
    }
    
    @IBAction func more(_ sender: Any) {
        // 현재 페이지 값에 1을 추가한다
        self.page += 1
        
        // 영화차트 API를 호출한다.
        self.callMovieAPI()
        
        // 데이터를 다시 읽어오도록 테이블 뷰를 갱신한다.
        self.tableView.reloadData()
    }
    
    func callMovieAPI() {
        // 호핀 API 호출을 위한 URI를 생성
        let url = "http://swiftapi.rubypaper.co.kr:2029/hoppin/movies?version=1&page=\(self.page)&count=30&genreId=&order=releasedateasc"
        let apiURI: URL! = URL(string: url)
        
        // REST API를 호출
        let apidata = try! Data(contentsOf: apiURI)
        
        // 데이터 전송 결과를 로그로 출력 (반드시 필요한 코드는 아님)
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? "데이터가 없습니다"
        NSLog("API Result=\( log )")
        
        // JSON 객체를 파싱하여 NSDictionary 객체로 받음
        do{
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            // 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
            let hoppin = apiDictionary["hoppin"] as! NSDictionary
            let movies = hoppin["movies"] as! NSDictionary
            let movie = movies["movie"] as! NSArray
            
            // Iterator(순회) 처리를 하면서 API 데이터를 MovieVO 객체에 저장한다.
            for row in movie {
                // 순회 상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary
                
                // 테이블 뷰 리스트를 구성할 데이터 형식
                let mvo = MovieVO()
                
                // movie 배열의 각 데이터를 mvo 상수의 속성에 대입
                mvo.title = r["title"] as? String
                mvo.description = r["genreNames"] as? String
                mvo.thumbnail = r["thumbnailImage"] as? String
                mvo.detail = r["linkUrl"] as? String
                mvo.rating = ((r["ratingAverage"] as! NSString).doubleValue)
                
                let url: URL! = URL(string: mvo.thumbnail!)
                let imageData = try! Data(contentsOf: url)
                mvo.thumbnailImage = UIImage(data:imageData)
                
                self.list.append(mvo)
            }
            
            // 전체 데이터 카운트를 얻는다.
            let totalCount = (hoppin["totalCount"] as? NSString)!.integerValue
            
            // totalCount가 읽어온 데이터 크기와 같거나 클 경우 더보기 버튼을 막는다.
            if self.list.count >= totalCount {
                self.moreBtn.isHidden = true
                
                let alert = UIAlertController(title: "알림", message: "마지막 페이지 입니다.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                
                alert.addAction(ok)
                
                self.present(alert, animated: false)
            }
        } catch {
            NSLog("Parse Error!")
        }
        
    }
    
    func getThumbnailImage(_ index: Int) -> UIImage {
        // 인자값으로 받은 인덱스를 기반으로 해당하는 배열 데이터를 읽어옴
        let mvo = self.list[index]
        
        // 메모이제이션 : 저장된 이미지가 있으면 그것을 반환하고, 없을 경우 내려받아 저장한 후 반환
        if let savedImage = mvo.thumbnailImage {
            return savedImage
        } else {
            let url: URL! = URL(string: mvo.thumbnail!)
            let imageData = try! Data(contentsOf: url)
            mvo.thumbnailImage = UIImage(data: imageData) // UIImage를 MovieVO 객체에 우선 저장
            
            return mvo.thumbnailImage!
        }
    }
}

extension ListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 실행된 세그웨이의 식별자가 "segue_detail"이라면
        if segue.identifier == "segue_detail" {
            // 사용자가 클릭한 행을 찾아낸다.
            let path = self.tableView.indexPath(for: sender as! MovieCell)
            
            // 행 정보를 통해 선택된 영화 데이터를 찾은 다음, 목적지 뷰 컨트롤러의 mvo 변수에 대입한다.
            let detailVC = segue.destination as? DetailViewController
            detailVC?.mvo = self.list[path!.row]
        }
    }
}
