//
//  OriginalTabBarController.swift
//  Yukitoru
//
//  Created by Maho Misumi on 2018/10/07.
//  Copyright © 2018年 Maho Misumi. All rights reserved.
//

import UIKit

class OriginalTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let colorKey = UIColor(red: 0.97, green: 0.94, blue: 0.61, alpha: 1.0)
        let secondColorKey = UIColor(red: 0.67, green: 0.85, blue: 0.83, alpha: 1.0)
     
//        //バーの背景色を変えたい
//        UITabBar.appearance().backgroundColor = colorKey
        //アイコンの色を変えたい
        UITabBar.appearance().tintColor = secondColorKey
        //背景画像を適応したい
//        let firstImage = UIImage(named: "あお.png")
//        UITabBar.appearance().
        // Do any additional setup after loading the view.
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
