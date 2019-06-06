//
//  ViewController.swift
//  Run0To5
//
//  Created by Valeria Duran on 5/17/19.
//  Copyright © 2019 Valeria Duran. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    //MARK: - Properties
    @IBOutlet weak var playView: UIView! //start counting down - when someone presses play, it starts 5 minute warm up walk, then the intervals they posted , between run-walk, then ends with 5 minute walk
    @IBOutlet weak var pauseView: UIView! //
    @IBOutlet weak var mainControlView: UIView!
    @IBOutlet weak var runTextField: UITextField!
    @IBOutlet weak var walkTextField: UITextField!
    @IBOutlet weak var timerLabel: UILabel! //update this with the timer,  -  create timer , update it with values chosen from intervals
    @IBOutlet weak var runPauseLabel: UILabel! //just update whether run/walk
    @IBOutlet weak var totalIntervalsToRun: UILabel! //follow which interval we are on
    let runPicker = UIPickerView()
    let walkPicker = UIPickerView()
    var selectedRunIntervals = 3
    var selectedWalkIntervals = NSInteger()
    var selectedworkoutLength = NSInteger()
   
    //MARK:  Data Sources - picker views
    let runPickerIntervals = [[1, 1.5, 2, 3, 5, 6, 8, 10, 12, 15, 20, 25, 30], [1, 1.5, 2]]
    let trekRowTitles = ["RUN minutes", "WALK minutes"]
    let totalWorkoutLengthArray = [30, 45, 60, 90, 120]
    
    //MARK: Timer
    var timer = Timer()
    var alarm = AVAudioPlayer()
    var walkInterval = 2 //walkPicker[0].chosenitem .ceiling SELECTEDWALK/RUNINTERVAL
    var runInterval = 3 //walkPicker[1].chosenitem .ceiling
    var lengthOfWorkout = 10
    var totalNumberOfIntervals = 8 //  totalWorkoutPicker / (walk + run ) .ceiling
    var currentInterval = 0
    var time = 0
    enum IntervalType {
        case Run
        case Walk
    }
    let intervals: [IntervalType] = [.Run, .Walk]
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupPlayAndPauseButtons()
        runTextField.delegate = self
        walkTextField.delegate = self
        soundAlarm()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addTitlesToEachPickerComponent()
    }
   
   func setupViews() {
    mainControlView.layer.cornerRadius = 130
    //mainControlView.layer.borderColor = (UIColor.white as! CGColor)
    playView.layer.cornerRadius = 50
    pauseView.layer.cornerRadius = 50
    walkTextField.layer.cornerRadius = 10
    runTextField.layer.cornerRadius = 10
   // mainControlView.layer.borderWidth = 5
    playView.layer.borderWidth = 5
    pauseView.layer.borderWidth = 5
    walkTextField.layer.borderWidth = 5
    runTextField.layer.borderWidth = 5
   // mainControlView.layer.borderColor = UIColor.red.cgColor
    buildPickerViews()
    addToolBarToPickerViews()
 }
    
    //MARK: - TIMER Methods
    func soundAlarm() {
        do {
            alarm = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "alarm", ofType: "mp3")!))
            alarm.prepareToPlay()
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSession.Category.playback)
            } catch {
                print(error)
            }
        } catch {
            print("Couldn't play alarm\(error)")
        }
    }
    //MARK: - Play and Pause buttons methods
    func setupPlayAndPauseButtons() {
        let playTap = UITapGestureRecognizer(target: self, action: #selector(handlePlayTap))
        let pauseTap = UITapGestureRecognizer(target: self, action: #selector(handlePauseTap))
        playView.addGestureRecognizer(playTap)
        pauseView.addGestureRecognizer(pauseTap)
    }
    
    @objc func handlePlayTap() {
        print("tapped play")
       // playPauseBehavior()
       startTimer()
        
    }
    @objc func handlePauseTap() {
        print("pause was tapped")
        if timer.isValid {
            timer.invalidate()
        }
           }
    
 
    func startTimer() {
        time = runInterval //currentInterval
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runningTimer),userInfo: nil, repeats: true)
    }
    
    @objc func runningTimer() {
        time -= 1
        timerLabel.text = String("\(time) seconds")
        
        if time <= 0 {
            timer.invalidate()
        }
        //timerLabel.text = String(currentInterval)
//        if time > 0 && intervals[currentInterval] == .Run {
//            runPauseLabel.text = "RUN"
//            time -= 1
//        } else if time <= 0 && intervals[currentInterval] == .Walk {
//            runPauseLabel.text = "Walk"
//            startNextInterval()
//        } else {
//            runPauseLabel.text = "Walk"
//            time -= 1
//        }
        perform(#selector(ViewController.updateUI), with: nil, afterDelay: 0.0)
    }
    
    @objc func updateUI() {
        
    }
    
    @objc func startNextInterval() {
//        print("current interval : \(currentInterval)")
//        if currentInterval < intervals.count {
//            if intervals[currentInterval] == .Pomodoro {
//                timeRemaining = tomatoTimer
//                let tomatoes = (currentInterval + 2) / 2
//                print("\(tomatoes) tomatoes")
//                updateTomatoes()
//            } else if intervals[currentInterval] == .RestBreak {
//                timeRemaining = breakTimer
//            } else if intervals[currentInterval] == .LongBreak {
//                timeRemaining = longBreakTimer
//            }
//            currentInterval += 1
//        } else {
//            currentInterval = 0
//        }
    }
    func playPauseBehavior() {
        if timer.isValid {
            // playButton.setTitle("Resume", for: .normal)
            //resetBarButton.isEnabled = true
            // handleCircleCompletionTap()
            handlePauseTap()
        } else {
            startTimer()
        }
    }
    
    //MARK: - TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        walkTextField.resignFirstResponder()
        runTextField.resignFirstResponder()
        
    }
    
    //MARK: - Picker view building methods
    func buildPickerViews() {
        walkPicker.delegate = self
        runPicker.delegate = self
        walkPicker.dataSource = self
        runPicker.dataSource = self
        runTextField.inputView = runPicker
        walkTextField.inputView = walkPicker
        runTextField.tintColor = .clear //clear textfield cursor
        walkTextField.tintColor = .clear
        walkPicker.selectRow(2, inComponent: 0, animated: true)
    }
    
    func addToolBarToPickerViews() {
        let runToolBar = UIToolbar()
        let walkToolBar = UIToolbar()
        runToolBar.barStyle = .default
        walkToolBar.barStyle = .default
        runToolBar.isTranslucent = true
        walkToolBar.isTranslucent = true
        let runTitleButton = UIBarButtonItem(title: "Minute Intervals to Run", style: .plain, target: self, action: #selector(donePressed))
        let walkTitleButton = UIBarButtonItem(title: "Total Length of Workout", style: .plain, target: self, action: #selector(donePressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        runToolBar.setItems([spaceButton, runTitleButton, spaceButton], animated: true)
        walkToolBar.setItems([spaceButton, walkTitleButton, spaceButton], animated: true)
        runToolBar.isUserInteractionEnabled = true
        walkToolBar.isUserInteractionEnabled = true
        runToolBar.sizeToFit()
        walkToolBar.sizeToFit()
        runTextField.inputAccessoryView = runToolBar
        walkTextField.inputAccessoryView = walkToolBar
    }
    func addTitlesToEachPickerComponent() {
        let labelWidth = runPicker.frame.width / CGFloat(runPicker.numberOfComponents) - 112
        for index in 0..<trekRowTitles.count {
            let label: UILabel = UILabel.init(frame: CGRect(x: runPicker.frame.origin.x + labelWidth * CGFloat(index), y: 0, width: labelWidth, height: 20))
            label.text = trekRowTitles[index]
            label.textAlignment = .center
            runPicker.addSubview(label)    }
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    
    //MARK: - Pickerview delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if runTextField.isFirstResponder {
            return trekRowTitles.count
        } else {
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if runTextField.isFirstResponder {
            return runPickerIntervals[component].count
        } else {
           return totalWorkoutLengthArray.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if runTextField.isFirstResponder {
            return String(runPickerIntervals[component][row])
        } else {
            return String(totalWorkoutLengthArray[row])
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if runTextField.isFirstResponder {
            let run = runPickerIntervals[0][selectedRunIntervals]
            let walk = runPickerIntervals[1][selectedWalkIntervals]
            selectedRunIntervals = pickerView.selectedRow(inComponent: 0)
             selectedWalkIntervals = pickerView.selectedRow(inComponent: 1)
            runTextField.text = "\(run) run \(walk) walk"
            runInterval = Int(run) * 60
            walkInterval = Int(walk) * 60
           
        } else {
            selectedworkoutLength = pickerView.selectedRow(inComponent: 0)
            walkTextField.text = "\(totalWorkoutLengthArray[selectedworkoutLength]) minutes"
            lengthOfWorkout = totalWorkoutLengthArray[row]
        }
    }
   
}

