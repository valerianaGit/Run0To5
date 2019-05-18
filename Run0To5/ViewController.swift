//
//  ViewController.swift
//  Run0To5
//
//  Created by Valeria Duran on 5/17/19.
//  Copyright © 2019 Valeria Duran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK: - Properties
    @IBOutlet weak var playView: UIView! //add gesture recognizer..start counting down
    @IBOutlet weak var pauseView: UIView! //add gesture recognizer - pause activity
    @IBOutlet weak var mainControlView: UIView!
    @IBOutlet weak var runTextField: UITextField! //make into pickerview
    @IBOutlet weak var walkTextField: UITextField! //make into pickerview
    @IBOutlet weak var timerLabel: UILabel! //update this with the timer
    @IBOutlet weak var runPauseLabel: UILabel! //just update whether run/walk
    //MARK: - Data Sources
    let runPickerIntervals = [1, 1.5, 2, 3, 5, 6, 8, 10, 12, 15, 20, 25, 30, 40, 50, 60]
    let walkPickerIntervals = [1, 1.5, 2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
   func setupViews() {
    //Build Circles out of square views
    mainControlView.layer.cornerRadius = 130
    playView.layer.cornerRadius = 50
    pauseView.layer.cornerRadius = 50
    //build pickerviews
    let runPicker = UIPickerView()
    let walkPicker = UIPickerView()
    walkPicker.delegate = self
    runPicker.delegate = self
    runTextField.inputView = runPicker
    walkTextField.inputView = walkPicker
    //add tool bar
    let runToolBar = UIToolbar()
    let walkToolBar = UIToolbar()
    runToolBar.barStyle = .default
    walkToolBar.barStyle = .default
    runToolBar.isTranslucent = true
    walkToolBar.isTranslucent = true
   // let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(donePressed))
    let runTitleButton = UIBarButtonItem(title: "Minute Intervals to Run", style: .plain, target: self, action: #selector(donePressed))
    let walkTitleButton = UIBarButtonItem(title: "Minute Intervals to Walk", style: .plain, target: self, action: #selector(donePressed))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    runToolBar.setItems([spaceButton, runTitleButton, spaceButton], animated: true)
    walkToolBar.setItems([spaceButton, walkTitleButton, spaceButton], animated: true)
    runToolBar.isUserInteractionEnabled = true
    walkToolBar.isUserInteractionEnabled = true
    runToolBar.sizeToFit()
    walkToolBar.sizeToFit()
    //runTextField.delegate = self
    runTextField.inputAccessoryView = runToolBar
    walkTextField.inputAccessoryView = walkToolBar
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    
    //MARK: - Pickerview delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if runTextField.isFirstResponder {
            return runPickerIntervals.count
        } else /*if walkTextField.isFirstResponder */{
           return walkPickerIntervals.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if runTextField.isFirstResponder {
            return String(runPickerIntervals[row])
        } else /*if walkTextField.isFirstResponder */{
            return String(walkPickerIntervals[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if runTextField.isFirstResponder {
            runTextField.text = String(runPickerIntervals[row])
        } else /*if walkTextField.isFirstResponder */{
             walkTextField.text = String(walkPickerIntervals[row])
        }
    }
    
}

