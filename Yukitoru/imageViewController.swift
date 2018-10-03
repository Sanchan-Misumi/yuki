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

class imageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet var textField: UITextField!
    
    
    // デフォルトのファイルを利用する初期化
    let realm = try! Realm()
    let imageAndTitle = RealmData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        // Do any additional setup after loading the view.
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
//        let imageData: Data = UIImage.jpegData(compressionQuality:photoImage.image!, 1)
        
        imageAndTitle.photoImageData = imageData
        imageAndTitle.title = textField.text!
        
        print(imageAndTitle)
        try! realm.write{
            realm.add(imageAndTitle)
        }
        
        self.dismiss(animated: true, completion: nil)
        
        
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

}

