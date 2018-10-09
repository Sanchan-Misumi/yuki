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
import AVFoundation

class quizViewController: UIViewController,UITextFieldDelegate {
    
    let SCREEN_SIZE = UIScreen.main.bounds.size
    var audioPlayer1: AVAudioPlayer!

    @IBOutlet var photoImage: UIImageView!
    @IBOutlet var photoTitle: UITextField!
    @IBOutlet var answerImage: UIImageView!
    @IBOutlet var springImage: SpringImageView!
    
    //結果を表示させるラベル
    @IBOutlet var label: UILabel!
    
    //正解数を数える
    var correctAnswer: Int = 0
    //回答した答えを格納する
    var writeAnswer: String = ""
    //textFieldの元々の位置を保存しておく
    var originHeight: CGFloat = 0.0
    
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
        
        //imageViewの角を丸くするコード
        photoImage.layer.cornerRadius = photoImage.frame.size.width * 0.1
        photoImage.clipsToBounds = true
        //photoTitleの角を丸くするコード
//        photoTitle.layer.cornerRadius = photoTitle.frame.size.width * 0.1
//        photoTitle.clipsToBounds = true
//
        originHeight =  photoTitle.frame.origin.y
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //Viewをタップした時に起こる処理を描く関数
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //キーボードを閉じる処理
        view.endEditing(true)
        photoTitle.frame.origin.y = originHeight
    }
    

    
    //UIKeyboardWillShow通知を受けて、実行される関数
    @objc func keyboardWillShow(_ notification: NSNotification){
        
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.height
        photoTitle.frame.origin.y = SCREEN_SIZE.height - keyboardHeight - photoTitle.frame.height
        self.photoTitle.textColor = UIColor.black
    }
    
    
    //UIKeyboardWillShow通知を受けて、実行される関数
   @objc func keyboardWillHide(_ notification: NSNotification){
    photoTitle.frame.origin.y = originHeight
    self.photoTitle.textColor = UIColor.black
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
            answerImage.image = UIImage(named: "true.png")
            self.photoTitle.textColor = UIColor.black
            
            setAudioPlayer(soundName : "Quiz-Correct_Answer02-2", type : "mp3")
            audioPlayer1.play()
            
            springImage.animation = "fadeInUp"
            springImage.curve = "easeInOut"
            springImage.duration = 1.0
            springImage.animate()
        
        } else if writeAnswer != quizArray[0].title{
            answerImage.image = UIImage(named:"false.png")
            setAudioPlayer(soundName : "Quiz-Wrong_Buzzer02-1", type : "mp3")
            audioPlayer1.play()
            self.photoTitle.text = self.quizArray[0].title
            self.photoTitle.textColor = UIColor.red
            springImage.animation = "fadeInUp"
            springImage.curve = "easeInOut"
            springImage.duration = 1.0
            springImage.animate()
        }
        
        //解いた問題をquizArrayから取り除く
        quizArray.remove(at: 0)
        
        //解いた問題数の合計値があらかじめ設定していた問題数に達したら結果画面へ
        if quizArray.count == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
            performSegueToResult()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
            self.setPhotoAndTitle()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
        
                self.photoTitle.text = ""
            self.answerImage.image = nil

        }
        label.text = String(correctAnswer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
          photoTitle.frame.origin.y = originHeight
        self.photoTitle.textColor = UIColor.black
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
    
    //音楽ファイルを読み込む
    func setAudioPlayer(soundName : String, type : String){
        
        let soundFilePeth = Bundle.main.path(forResource:soundName, ofType: type)!
        let fileURL = URL(fileURLWithPath: soundFilePeth)
        
        do{
            audioPlayer1 = try AVAudioPlayer(contentsOf: fileURL)
        } catch {
            print("音楽ファイルが読み込めませんでした")
        }
    


}
}
