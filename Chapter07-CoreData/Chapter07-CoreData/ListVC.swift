//
//  ListVC.swift
//  Chapter07-CoreData
//
//  Created by Byunsangjin on 17/10/2018.
//  Copyright © 2018 Byunsangjin. All rights reserved.
//

import UIKit
import CoreData

class ListVC : UITableViewController {
    // 데이터 소스 역할을 할 배열 변수
    lazy var list : [NSManagedObject] = {
        return self.fetch()
    }()
    
    
    // 데이터를 읽어올 메소드
    func fetch() -> [NSManagedObject] {
        // 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        // 요청 객체 생성
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Board")
        
        // 정렬 속성 설정
        let sort = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        // 데이터 가져오기
        let result = try! context.fetch(fetchRequest)
        return result
    }
    
    
    
    // 데이터를 저장할 메소드
    func save(title : String, contents : String) -> Bool {
        // 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        // 관리 객체 생성 & 값을 설정
        let object = NSEntityDescription.insertNewObject(forEntityName: "Board", into: context)
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        // Log 관리 객체 생성 및 어트리뷰트에 값 대입
        let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
        logObject.regdate = Date()
        logObject.type = LogType.create.rawValue
        
        // 게시글 객체의 logs 속성에 새로 생성된 로그 객체 추가
        (object as! BoardMO).addToLogs(logObject)
        
        // 영구 저장소에 커밋되고 나면 list 프로퍼티에 추가한다.
        do {
            try context.save()
            // self.list.append(object)
            self.list.insert(object, at: 0)
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    
    
    func delete(object : NSManagedObject) -> Bool {
        // 앱 델리게이트 객체 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        // 컨텍스트로부터 해당 객체 삭제
        context.delete(object)
        
        // 영구 저장소에 커밋한다.
        do {
            try context.save()
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    
    // 데이터 저장 버튼에 대한 액션 메소드
    @objc func add(_ sender : Any) {
        let alert = UIAlertController(title: "게시글 등록", message: nil, preferredStyle: .alert)
        
        // 입력 필드 추가(이름 & 전화번호)
        alert.addTextField() { $0.placeholder = "제목" }
        alert.addTextField() { $0.placeholder = "내용" }
        
        // 버튼 추가 (Cancel & Save)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { (_) in
            guard let title = alert.textFields?.first?.text, let contents = alert.textFields?.last?.text else {
                return
            }
            
            // 값을 저장하고, 성공이면 테이블 뷰를 리로드 한다.
            if self.save(title: title, contents: contents) == true {
                self.tableView.reloadData()
            }
        })
        
        self.present(alert, animated: false)
    }
    
    
    
    func edit(object : NSManagedObject, title : String, contents : String) -> Bool {
        // 앱 델리게이트 참조
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        // 관리 객체 컨텍스트 참조
        let context = appDelegate.persistentContainer.viewContext
        
        // 관리 객체 값 수정
        object.setValue(title, forKey: "title")
        object.setValue(contents, forKey: "contents")
        object.setValue(Date(), forKey: "regdate")
        
        // Log 관리 객체 생성 및 어트리뷰트에 값 대입
        let logObject = NSEntityDescription.insertNewObject(forEntityName: "Log", into: context) as! LogMO
        logObject.regdate = Date()
        logObject.type = LogType.edit.rawValue
        
        // 게시글 객체의 logs 속성에 새로 생성된 로그 객체 추가
        (object as! BoardMO).addToLogs(logObject)
        
        // 영구 저장소에 저장
        do {
            try context.save()
            self.list = self.fetch() // 수정하는 경우에도 맨 위로 올라와야 하므로 list 배열을 갱신한다.
            return true
        } catch {
            context.rollback()
            return false
        }
    }
    
    
    
    // 화면 및 로직 초기화 메소드
    override func viewDidLoad() {
        let addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add(_:)))
        self.navigationItem.rightBarButtonItem = addBtn
    }
    
    
    
    override func tableView(_ tv: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    
    
    override func tableView(_ tv: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 해당 데이터 가져오기
        let record = self.list[indexPath.row]
        let title = record.value(forKey: "title") as? String
        let contents = record.value(forKey: "contents") as? String
        
        // 셀을 생성하고 값을 대입한다.
        let cell = tv.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = title
        cell.detailTextLabel?.text = contents
        
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let object = self.list[indexPath.row] // 삭제할 대상 객체
        
        if self.delete(object: object) {
            // 코어 데이터에서 삭제되고 나면 배열 목록과 테이블 뷰의 행도 삭제한다.
            self.list.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 행에 해당하는 데이터 가져오기
        let object = self.list[indexPath.row]
        let title = object.value(forKey: "title") as? String
        let contents = object.value(forKey: "contents") as? String
        
        let alert = UIAlertController(title: "게시글 수정", message: nil, preferredStyle: .alert)
        
        // 입력 필드 추가(기존 값 입력)
        alert.addTextField() { $0.text = title }
        alert.addTextField() { $0.text = contents }
        
        // 버튼 추가(Cancel & Save)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default) { (_) in
            guard let title = alert.textFields?.first?.text, let contents = alert.textFields?.last?.text else {
                return
            }
            
            // 값을 수정하는 메소드를 호출하고, 그 결과가 성공이면 뷰를 리로드한다.
            if self.edit(object: object, title: title, contents: contents) == true {
                // self.tableView.reloadData()
                
                // 셀의 내용을 직접 수정한다.
                let cell = self.tableView.cellForRow(at: indexPath)
                cell?.textLabel?.text = title
                cell?.detailTextLabel?.text = contents
                
                // 수정된 셀을 첫 번째 행으로 이동시킨다.
                let firstIndexPath = IndexPath(item: 0, section: 0)
                self.tableView.moveRow(at: indexPath, to: firstIndexPath)
            }
        })
        
        self.present(alert, animated: false)
    }
    
    
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let object = self.list[indexPath.row]
        let uvc = self.storyboard?.instantiateViewController(withIdentifier: "LogVC") as! LogVC
        uvc.board = object as! BoardMO
        
        self.show(uvc, sender: self)
    }
}
