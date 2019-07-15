//
//  ViewController.swift
//  Text
//
//  Created by cccUser on 22/05/19.
//  Copyright © 2019 cccUser. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Translate_btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       navigationController?.navigationBar.tintColor = UIColor.white
        Translate_btn.layer.shadowColor = UIColor.lightGray.cgColor
        Translate_btn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        Translate_btn.layer.shadowOpacity = 2.0
        Translate_btn.layer.shadowRadius = 0.5
        Translate_btn.layer.masksToBounds = false
        Translate_btn.layer.cornerRadius = 4.0
        navigationController?.navigationBar.barTintColor = UIColor(red: 35/255, green: 51/255, blue: 159/255, alpha: 1)
        self.navigationItem.title = "Digi Translator"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        // Do any additional setup after loading the view, typically from a nib.
    }
}

