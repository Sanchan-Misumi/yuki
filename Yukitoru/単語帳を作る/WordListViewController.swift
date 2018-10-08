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
    var wordName: String!
    let imageAndTitle = RealmData()
    var allArray = [String(),Data()] as [Any]
    var titleArray = [String()]
    var imageArray = [Data()]

    @IBOutlet var table: UITableView!{
        didSet{
            table.dataSource = self
            table.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         realmDataArray = realm.objects(RealmData.self).map{$0}
        for i in realmDataArray {
        if wordName == imageAndTitle.wordListName{
//            allArray.append(contentsOf: "\(imageAndTitle.title)","\(imageAndTitle.photoImageData)")
            titleArray.append(imageAndTitle.title)
            imageArray.append(imageAndTitle.photoImageData)
            print("wordListViewControllerでwordNameに入っているのは\(String(describing: wordName))です")
            print("wordListViewControllerでtitleArrayに入っているのは\(titleArray)です")
            print("wordListViewControllerでimageArrayに入っているのは\(imageArray)です")
//            allArray.append(contentsOf: [(imageAndTitle.title),(imageAndTitle.photoImageData)])
        }
        }

        
        // Do any additional setup after loading the view.
         
    }
    
    //tableViewの数を指定するコード
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return titleArray.count
    }
    
    //tableViewに表示させるものを指定するコード
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = titleArray[indexPath.row]
        
        return cell!
    }
    //tableViewを触った時に動くコード
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //delete機能をつけるためのコード
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == .delete {
                    titleArray.remove(at: indexPath.row)
                    imageArray.remove(at: indexPath.row)
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
