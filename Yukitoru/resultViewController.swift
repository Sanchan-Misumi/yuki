//
//  resultViewController.swift
//  Yukitoru
//
//  Created by Maho Misumi on 2018/09/26.
//  Copyright © 2018年 Maho Misumi. All rights reserved.
//

import UIKit
import RealmSwift
import Spring


class resultViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var table: UITableView!{
        didSet{
            table.dataSource = self
            table.delegate = self
        }
    }
    @IBOutlet var label:UILabel!
    
    var correctAnswer: Int = 0

    let realm = try! Realm()
    
    var realmDataArray: Results<RealmData>!
    let imageAndTitle = RealmData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(imageAndTitle.title)
        label.text = String(correctAnswer)
        realmDataArray = realm.objects(RealmData.self)
        print("resultViewでのrelmDataArrayに入っているのは\(String(describing: realmDataArray))")
    }
    
//tableViewに表示させるものを指定するコード
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = realmDataArray[indexPath.row].title
        
//        cell?.imageView?.image = UIImage(data: realmDataArray.photoImageData)
        return cell!
    }
    
    //tableViewを触った時に動く
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }

    //tableViewの数を指定するコード
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmDataArray.count
    }
    
    //delete機能をつけるためのコード
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            realmDataArray.remove(at: indexPath.row)
//            table.deleteRows(at: [indexPath], with: .fade)
//        }
        
    }
}
