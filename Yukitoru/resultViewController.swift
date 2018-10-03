//
//  resultViewController.swift
//  Yukitoru
//
//  Created by Maho Misumi on 2018/09/26.
//  Copyright © 2018年 Maho Misumi. All rights reserved.
//

import UIKit
import RealmSwift

class resultViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var table: UITableView!
    @IBOutlet var label:UILabel!
    
    var correctAnswer: Int = 0

    let realm = try! Realm()
    
    var realmDataArray: Array<RealmData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.dataSource = self
        table.delegate = self
        label.text = String(correctAnswer)
        realmDataArray = realm.objects(RealmData.self).map{$0}
        
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
//        cell?.textLabel?.text = songNameArray[indexPath.row]
//        cell?.imageView?.image = UIImage(named: imageNameArray[indexPath.row])
        return cell!
    }
    
    //tableViewを触った時に動く
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("\(songNameArray[indexPath.row])が選ばれました")
        
//        let audioPath = URL(fileURLWithPath: Bundle.main.path(forResource: fileNameArray [indexPath.row],ofType:"mp3")!)
//        audioPlayer = try? AVAudioPlayer(contentsOf: audioPath)
//
//        audioPlayer.play()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realmDataArray.count
    }
}
