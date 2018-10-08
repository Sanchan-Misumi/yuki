//
//  ViewController.swift
//  Yukitoru
//
//  Created by Maho Misumi on 2018/09/26.
//  Copyright © 2018年 Maho Misumi. All rights reserved.
//

import UIKit
import Spring
class ViewController: UIViewController {

    @IBOutlet var bigButtom: SpringButton!
    @IBOutlet var smallButtom: SpringButton!
    @IBOutlet var label: SpringLabel!
    @IBOutlet var label0: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        smallButtom.animation = "fadeInUp"
        smallButtom.curve = "easeInOut"
        smallButtom.duration = 5.0
        smallButtom.animate()
        
        label.animation = "fadeInUp"
        label.curve = "easeInOut"
        label.duration = 5.0
        label.animate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8){
            self.label0.text = "解く"
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        smallButtom.animation = "fadeInUp"
        smallButtom.curve = "easeInOut"
        smallButtom.duration = 10.0
        smallButtom.animate()
        
        smallButtom.animation = "shake"
        smallButtom.curve = "easeInOut"
        smallButtom.duration = 10.0
        smallButtom.animate()
        
        label.animation = "fadeInUp"
        label.curve = "easeInOut"
        label.duration = 10.0
        label.animate()
        
        label.animation = "shake"
        label.curve = "easeInOut"
        label.duration = 10.0
        label.animate()
    }
    func performSegueToQuiz(){
        performSegue(withIdentifier: "toQuizViewController", sender: nil)
    }
    
    @IBAction func bigButtom1(){
        bigButtom.animation = "shake"
        bigButtom.curve = "easeInOut"
        bigButtom.duration = 1.0
        bigButtom.animate()
    }
    
    @IBAction func smallButtom2(){
        smallButtom.animation = "shake"
        smallButtom.curve = "easeInOut"
        smallButtom.duration = 1.0
        smallButtom.animate()
        performSegueToQuiz()
    }

    //セグエを準備（prepare）するときに呼ばれるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toQuizViewController" {
          
            
        }
    }


}

