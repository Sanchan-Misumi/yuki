//
//  imageViewController.swift
//  Yukitoru
//
//  Created by Maho Misumi on 2018/09/26.
//  Copyright © 2018年 Maho Misumi. All rights reserved.
//

import UIKit
import Spring
import RealmSwift
import Firebase
//import FirebaseDatabase
//import FirebaseStorage

class OneWordViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
    
    let SCREEN_SIZE = UIScreen.main.bounds.size
    var originHeight: CGFloat = 0.0
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var pickerView: UIPickerView!
    //インスタンス変数
    //    var fireBase: DatabaseReference!
    
    
    // デフォルトのファイルを利用する初期化
    let realm = try! Realm()
    let imageAndTitle = RealmData()
    var wordListArray: Array<RealmWords>!
    var onlyWordArray = [RealmWords]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        //インスタンスを作成
        //        fireBase = Database.database().reference()
        
        NotificationCenter.default.addObserver(self, selector: #selector(quizViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        //ここでUIKeyboardWillShowという名前の通知のイベントをオブザーバー登録をしている
        NotificationCenter.default.addObserver(self, selector: #selector(quizViewController.keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        originHeight =  textField.frame.origin.y
    
        wordListArray = realm.objects(RealmWords.self).map{$0}
        print("pickercontrollerで呼ばれるはずのwordListArrayには\(String(describing: wordListArray))が入っています")
//        onlyWordArray = wordListArray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        wordListArray = realm.objects(RealmWords.self).map{$0}
        self.loadView()
    }
    //UIKeyboardWillShow通知を受けて、実行される関数
    @objc func keyboardWillShow(_ notification: NSNotification){
        
        let keyboardHeight = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.height
    
        textField.frame.origin.y = SCREEN_SIZE.height - keyboardHeight - textField.frame.height
        
    }
    
    
    //UIKeyboardWillShow通知を受けて、実行される関数
    @objc func keyboardWillHide(_ notification: NSNotification){
        textField.frame.origin.y = originHeight
    }
    
    
    @IBAction func useCamera(_ sender: Any) {
        //カメラが使えるかの確認
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.delegate = self
            picker.allowsEditing = true
            
            present(picker, animated: true,completion: nil)
        }else{
            print("error")
        }
        
    }
    
    @IBAction func savePhoto(_ sender: Any) {
        let imageData: Data = (photoImage.image)!.jpegData(compressionQuality: 1)!
        
        imageAndTitle.photoImageData = imageData
        imageAndTitle.title = textField.text!
        
        print(imageAndTitle)
        try! realm.write{
            realm.add(imageAndTitle)
        }
        
        self.dismiss(animated: true, completion: nil)
        
        fileupload(deta: imageData)
        
        textField.text = ""
        photoImage.image = nil

    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let _image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            photoImage.image = _image
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func openAlbum(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            present(picker, animated: true,completion: nil)
        }
    }
    
    //ここから下では、キーボードをしまったりしているよ
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        imageAndTitle.title = textField.text!
        
        self.view.endEditing(true)
    }
    
    //firebaseを使うためのメソッド
    func fileupload(deta: Data){
        //画像のアップロード
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        //データを保存
        let reference = storageRef.child("images/" + "1" + ".jpg")
        reference.putData(deta, metadata: nil, completion: { metaData, error in
            print(metaData as Any)
            print(error as Any)
            
        })
    }
    
    //UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return wordListArray.count
    }
    
//    UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return wordListArray[row].word
    }
    
//    UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        imageAndTitle.wordListName = wordListArray[row].word
    }
    
    
    //
}

