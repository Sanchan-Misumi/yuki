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
    let onlyWord = RealmWords()
    
    var wordList: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //一次的に問題をrealmDataArrayに格納する
        wordListNameTextField.delegate = self
   
    }
    
    @IBAction func save(_ sender: Any) {
        if wordListNameTextField.text != ""{
        wordList = (wordListNameTextField.text)!
       onlyWord.word = wordList
        print("新しく登録した単語帳の名前は\(onlyWord.word)です")
        
        try! realm.write{
            realm.add(onlyWord)
        }
        }
        navigationController?.popViewController(animated: Bool.init())
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
