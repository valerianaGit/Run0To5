//
//  ViewController.swift
//  Run0To5
//
//  Created by Valeria Duran on 5/17/19.
//  Copyright © 2019 Valeria Duran. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: - Properties
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var playView: UIView!
    @IBOutlet weak var pauseView: UIView!
    @IBOutlet weak var mainControlView: UIView!
    @IBOutlet weak var runTextField: UITextField!
    @IBOutlet weak var walkTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
   func setupViews() {
    //round corners
    topView.layer.cornerRadius = 10
    bottomView.layer.cornerRadius = 10
    
    //Build Circles out of square views
    mainControlView.layer.cornerRadius = 130
    playView.layer.cornerRadius = 50
    pauseView.layer.cornerRadius = 50
    
    
    
    }


}

