//
//  quizViewController.swift
//  Yukitoru
//
//  Created by Maho Misumi on 2018/09/26.
//  Copyright © 2018年 Maho Misumi. All rights reserved.
//

import UIKit
import RealmSwift
import Spring

class quizViewController: UIViewController,UITextFieldDelegate {
    
    let SCREEN_SIZE = UIScreen.main.bounds.size

    @IBOutlet var photoImage: UIImageView!
    @IBOutlet weak var photoTitle: UITextField!
    
    //結果を表示させるラベル
    @IBOutlet var answer: UILabel!
    
    //正解数を数える
    var correctAnswer: Int = 0
    //回答した答えを格納する
    var writeAnswer: String = ""
    
    //問題文を格納する配列
    var quizArray = [RealmData]()
    
    var identifier: Int = 0
    
    let realm = try! Realm()

    var realmDataArray: Array<RealmData>!
    
    let realmData = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("アプリで表示されてるよ:\(Realm.Configuration.defaultConfiguration.fileURL!)")
        //一次的に問題をrealmDataArrayに格納する
        realmDataArray = realm.objects(RealmData.self).map{$0}
        print("quizで読み込まれたよ\(String(describing: realmDataArray))")
    
//        let toCheck = realm.objects(RealmData.self).map{$0}
//        print(toCheck[0].photoImageData)
        //問題をシャッフルしてquizArrayに格納する
        while (realmDataArray.count > 0){
            let index = Int(arc4random()) % realmDataArray.count
            quizArray.append(realmDataArray![index])
            realmDataArray.remove(at: index)
        }
        setPhotoAndTitle()
        photoTitle.delegate = self
        
    
        NotificationCenter.default.addObserver(self, selector: #selector(quizViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        //ここでUIKeyboardWillShowという名前の通知のイベントをオブザーバー登録をしている
        NotificationCenter.default.addObserver(self, selector: #selector(quizViewController.keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Viewをタップした時に起こる処理を描く関数
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //キーボードを閉じる処理
        view.endEditing(true)
    }
    

    
    //UIKeyboardWillShow通知を受けて、実行される関数
    @objc func keyboardWillShow(_ notification: NSNotification){
        
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.height
        photoTitle.frame.origin.y = SCREEN_SIZE.height - keyboardHeight - photoTitle.frame.height
        
    }
    
    
    //UIKeyboardWillShow通知を受けて、実行される関数
   @objc func keyboardWillHide(_ notification: NSNotification){
//        photoTitle.frame.origin.y = SCREEN_SIZE.height - photoTitle.frame.height
    }
    
    func setPhotoAndTitle() {
        
        //一時的にクイズを取り出す配列
        if quizArray != [] {
        
        //問題のイメージを表示
        photoImage.image = UIImage(data: quizArray[0].photoImageData)
        }
        
        //        let imageData = UIImage(data: realmDataArray[identifier].photoImageData)
        //        photoImage.image = imageData
        //        photoTitle.text = realmDataArray[identifier].title
    }
    
    
    @IBAction func answer(_ sender: Any) {
        
        //一時的にクイズを取り出す配列
     
        
        writeAnswer = photoTitle.text!
        
        func performSegueToResult(){
            performSegue(withIdentifier: "toResultView", sender: nil)
        }
//
        if writeAnswer == quizArray[0].title {
            correctAnswer = correctAnswer + 1
            answer.text = "正解"
        } else if writeAnswer != quizArray[0].title{
            answer.text = "不正解"
        }
        
        //解いた問題をquizArrayから取り除く
        quizArray.remove(at: 0)
        
        //解いた問題数の合計値があらかじめ設定していた問題数に達したら結果画面へ
        if quizArray.count == 0 {
            performSegueToResult()
        } else {
            setPhotoAndTitle()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.photoTitle.text = ""
        }
    }
    
    //セグエを準備（prepare）するときに呼ばれるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResultView" {
            let resultViewController = segue.destination as! resultViewController
            resultViewController.correctAnswer = self.correctAnswer
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
