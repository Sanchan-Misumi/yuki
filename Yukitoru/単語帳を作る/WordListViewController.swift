//
//  WordListViewController.swift
//  Yukitoru
//
//  Created by Maho Misumi on 2018/10/07.
//  Copyright © 2018年 Maho Misumi. All rights reserved.
//

import UIKit
import RealmSwift
class WordListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    let realm = try! Realm()
    
    var realmDataArray: Array<RealmData>!
    let imageAndTitle = RealmData()

    @IBOutlet var table: UITableView!{
        didSet{
            table.dataSource = self
            table.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

          realmDataArray = realm.objects(RealmData.self).map{$0}
        // Do any additional setup after loading the view.
    }
    
    //tableViewの数を指定するコード
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return realmDataArray.count
    }
    
    //tableViewに表示させるものを指定するコード
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = realmDataArray[indexPath.row].title
        
        return cell!
    }
    //tableViewを触った時に動くコード
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //delete機能をつけるためのコード
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == .delete {
                    realmDataArray.remove(at: indexPath.row)
                    table.deleteRows(at: [indexPath], with: .fade)
                }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
