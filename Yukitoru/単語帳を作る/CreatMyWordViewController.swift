//
//  CreatMyWordViewController.swift
//  Yukitoru
//
//  Created by Maho Misumi on 2018/10/07.
//  Copyright © 2018年 Maho Misumi. All rights reserved.
//

import UIKit
import RealmSwift

class CreatMyWordViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var wordListNameTextField: UITextField!
    
    let realm = try! Realm()
    
    var realmDataArray: Array<RealmData>!
    let imageAndTitle = RealmData()
    
    var wordList: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        //一次的に問題をrealmDataArrayに格納する
        realmDataArray = realm.objects(RealmData.self).map{$0}
        wordListNameTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func save(_ sender: Any) {
        wordList = (wordListNameTextField.text)!
        imageAndTitle.wordListName = wordList
        print("新しく登録した単語帳の名前は\(imageAndTitle.wordListName)です")
        
        try! realm.write{
            realm.add(imageAndTitle)
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        wordListNameTextField.resignFirstResponder()
        return true
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
