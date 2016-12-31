//
//  AVTabataTimerViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVTabataTimerViewController: UIViewController, AVCellsFill {
    
    @IBOutlet weak var startButton: UIButton!
    
    var model: AVObservableTimersArrayModel?
    var tabataTimerModel: TimerModel?
    
    var timerSettingsContainerView = UIView()
    
    var warmupTimerField: AVTimerSettingsFieldView?
    var setsTimerField: AVTimerSettingsFieldView?
    var intervalsTimerField: AVTimerSettingsFieldView?
    var workTimerField: AVTimerSettingsFieldView?
    var restTimerField: AVTimerSettingsFieldView?
    var coolDownTimerField: AVTimerSettingsFieldView?
    
//	MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "SET UP TIMER"

        if let model = self.model {
            if model.timers.count == 0 {
                TimerModel.setupTestTabataTimer()
            }
            
            let tabataTimerModel = model.timers[0]
            self.setTimerSettingsContainerView()
            self.setupTimerSettings(timerModel: tabataTimerModel)
            self.tabataTimerModel = tabataTimerModel
        }
    }

//	MARK: Private

    fileprivate func setTimerSettingsContainerView() {
        if let view = self.view {
            let timerSettingsContainerView = self.timerSettingsContainerView
            view.addSubview(timerSettingsContainerView)
            timerSettingsContainerView.translatesAutoresizingMaskIntoConstraints = false
            let leftViewConstraint = NSLayoutConstraint(item: timerSettingsContainerView, 
                                                        attribute: NSLayoutAttribute.left,
                                                        relatedBy: NSLayoutRelation.equal,
                                                        toItem: view,
                                                        attribute: NSLayoutAttribute.leftMargin,
                                                        multiplier: 1.0,
                                                        constant: 0)
            let rightViewConstraint = NSLayoutConstraint(item: timerSettingsContainerView,
                                                         attribute: NSLayoutAttribute.right,
                                                         relatedBy: NSLayoutRelation.equal,
                                                         toItem: view,
                                                         attribute: NSLayoutAttribute.rightMargin,
                                                         multiplier: 1.0,
                                                         constant: 0)
            let heightViewContsraint = NSLayoutConstraint(item: timerSettingsContainerView,
                                                          attribute: NSLayoutAttribute.height,
                                                          relatedBy: NSLayoutRelation.equal,
                                                          toItem: nil,
                                                          attribute: NSLayoutAttribute.height,
                                                          multiplier: 1.0,
                                                          constant: 357)
            let centerYViewConstraint = NSLayoutConstraint(item: timerSettingsContainerView,
                                                           attribute: NSLayoutAttribute.centerY,
                                                           relatedBy: NSLayoutRelation.equal,
                                                           toItem: view,
                                                           attribute: NSLayoutAttribute.centerY,
                                                           multiplier: 1.0,
                                                           constant: 0)
            view.addConstraints([leftViewConstraint, rightViewConstraint, heightViewContsraint, centerYViewConstraint])
        }
    }
    
    fileprivate func setupTimerSettings(timerModel: TimerModel) {
        self.warmupTimerField = self.timerField(title: "WARMUP",
                                                indication: self.secondsToTimeString(seconds: Int(timerModel.warmupTime)),
                                                selectorTitle: "onWarmup",
                                                previousField: nil,
                                                isOnTop: true)
        self.setsTimerField = self.timerField(title: "SETS",
                                              indication: String(timerModel.setsCount),
                                              selectorTitle: "onSets",
                                              previousField: warmupTimerField,
                                              isOnTop: false)
        self.workTimerField = self.timerField(title: "WORK",
                                              indication: self.secondsToTimeString(seconds: Int((timerModel.exercises?.firstObject as! ExerciseModel).duration)),
                                              selectorTitle: "onWork",
                                              previousField: setsTimerField,
                                              isOnTop: false)
        self.restTimerField = self.timerField(title: "REST",
                                              indication: self.secondsToTimeString(seconds: Int(timerModel.exerciseRestTime)),
                                              selectorTitle: "onRest",
                                              previousField: workTimerField,
                                              isOnTop: false)
        self.coolDownTimerField = self.timerField(title: "COOL DOWN",
                                                  indication: self.secondsToTimeString(seconds: Int(timerModel.coolDownTime)),
                                                  selectorTitle: "onCoolDown",
                                                  previousField: restTimerField,
                                                  isOnTop: false)
    }
    
    fileprivate func timerField(title: String,
                    indication: String,
                    selectorTitle: String,
                    previousField: AVTimerSettingsFieldView?,
                    isOnTop: Bool) -> AVTimerSettingsFieldView {
        let timerField = UINib.object(withClass: AVTimerSettingsFieldView.self) as! AVTimerSettingsFieldView
        timerField.titleLabel.text = title
        timerField.indicationLabel.text = indication
        timerField.minusButton.addTarget(self,
                                         action: NSSelectorFromString(selectorTitle + "MinusButton:"),
                                         for: UIControlEvents.touchUpInside)
        timerField.plusButton.addTarget(self,
                                        action: NSSelectorFromString(selectorTitle + "PlusButton:"),
                                        for: UIControlEvents.touchUpInside)
        let timerSettingsContainerView = self.timerSettingsContainerView
        timerSettingsContainerView.addSubview(timerField)
        timerField.translatesAutoresizingMaskIntoConstraints = false
        let topTestViewConstraint: NSLayoutConstraint
        let heightTestViewContsraint = NSLayoutConstraint(item: timerField,
                                                          attribute: NSLayoutAttribute.height,
                                                          relatedBy: NSLayoutRelation.equal,
                                                          toItem: nil,
                                                          attribute: NSLayoutAttribute.height,
                                                          multiplier: 1.0,
                                                          constant: 65)
        let widthTestViewContsraint = NSLayoutConstraint(item: timerField,
                                                         attribute: NSLayoutAttribute.width,
                                                         relatedBy: NSLayoutRelation.equal,
                                                         toItem: nil,
                                                         attribute: NSLayoutAttribute.width,
                                                         multiplier: 1.0,
                                                         constant: 188)
        let centerXTestViewConstraint = NSLayoutConstraint(item: timerField,
                                                           attribute: NSLayoutAttribute.centerX,
                                                           relatedBy: NSLayoutRelation.equal,
                                                           toItem: timerSettingsContainerView,
                                                           attribute: NSLayoutAttribute.centerX,
                                                           multiplier: 1.0,
                                                           constant: 0)
        topTestViewConstraint = NSLayoutConstraint(item: timerField,
                                                   attribute: NSLayoutAttribute.top,
                                                   relatedBy: NSLayoutRelation.equal,
                                                   toItem: isOnTop ? timerSettingsContainerView : previousField,
                                                   attribute: isOnTop ? .top : .bottom,
                                                   multiplier: 1.0,
                                                   constant: isOnTop ? 0 : 8)
        self.view.addConstraints([topTestViewConstraint, heightTestViewContsraint, widthTestViewContsraint, centerXTestViewConstraint])
        
        return timerField
    }

//	MARK: Interface Handling
    
    @IBAction func onWarmupMinusButton(_ sender: Any) {
        self.tabataTimerModel?.warmupTime = Int64(self.manageWarmupTimerField(function: -))
    }
    
    @IBAction func onWarmupPlusButton(_ sender: Any) {
        self.tabataTimerModel?.warmupTime = Int64(self.manageWarmupTimerField(function: +))
    }
    
    fileprivate func manageWarmupTimerField(function:(Int, Int) -> Int) -> Int {
        if let tabataTimerModel = self.tabataTimerModel,
            let label = self.warmupTimerField?.indicationLabel
        {
            return self.timeLabelChangeWithFunction(oldValue: Int(tabataTimerModel.warmupTime),
                                                    function: function,
                                                    label: label)
        }
        
        return 0
    }
    
    @IBAction func onSetsMinusButton(_ sender: Any) {
        if let setsCount = self.tabataTimerModel?.setsCount, setsCount > 1 {
            self.tabataTimerModel?.setsCount = Int16(self.manageSetsTimerField(function: -))
        }
    }
    
    @IBAction func onSetsPlusButton(_ sender: Any) {
        self.tabataTimerModel?.setsCount = Int16(self.manageSetsTimerField(function: +))
    }
    
    fileprivate func manageSetsTimerField(function:(Int, Int) -> Int) -> Int {
        if let tabataTimerModel = self.tabataTimerModel,
            let label = self.setsTimerField?.indicationLabel
        {
            return self.countLabelChangeWithFunction(oldValue: Int(tabataTimerModel.setsCount),
                                                     function: function,
                                                     label: label)
        }
        
        return 1
    }

    @IBAction func onWorkMinusButton(_ sender: Any) {
        (self.tabataTimerModel?.exercises?.array[0] as! ExerciseModel).duration = Int16(self.manageWorkTimerField(function: -))
    }
    
    @IBAction func onWorkPlusButton(_ sender: Any) {
        (self.tabataTimerModel?.exercises?.array[0] as! ExerciseModel).duration = Int16(self.manageWorkTimerField(function: +))
    }
    
    fileprivate func manageWorkTimerField(function:(Int, Int) -> Int) -> Int {
        if let tabataTimerModel = self.tabataTimerModel,
            let label = self.workTimerField?.indicationLabel
        {
            let exercise = tabataTimerModel.exercises?.array[0] as! ExerciseModel
            
            return self.timeLabelChangeWithFunction(oldValue: Int(exercise.duration),
                                                    function: function,
                                                    label: label)
        }
        
        return 0
    }

    @IBAction func onRestMinusButton(_ sender: Any) {
        let restTime = self.manageRestTimerField(function: -)
        let tabataTimerModel = self.tabataTimerModel
        tabataTimerModel?.exerciseRestTime = Int16(restTime)
        tabataTimerModel?.setRestTime = Int16(restTime)
    }
    
    @IBAction func onRestPlusButton(_ sender: Any) {
        let restTime = self.manageRestTimerField(function: +)
        let tabataTimerModel = self.tabataTimerModel
        tabataTimerModel?.exerciseRestTime = Int16(restTime)
        tabataTimerModel?.setRestTime = Int16(restTime)
    }
    
    fileprivate func manageRestTimerField(function:(Int, Int) -> Int) -> Int {
        if let exerciseRestTime = self.tabataTimerModel?.exerciseRestTime,
            let label = self.restTimerField?.indicationLabel
        {
            return self.timeLabelChangeWithFunction(oldValue: Int(exerciseRestTime),
                                                    function: function,
                                                    label: label)
        }
        
        return 0
    }
    
    @IBAction func onCoolDownMinusButton(_ sender: Any) {
        self.tabataTimerModel?.coolDownTime = Int16(self.manageCoolDownTimerField(function: -))
    }
    
    @IBAction func onCoolDownPlusButton(_ sender: Any) {
        self.tabataTimerModel?.coolDownTime = Int16(self.manageCoolDownTimerField(function: +))
    }
    
    fileprivate func manageCoolDownTimerField(function:(Int, Int) -> Int) -> Int {
        if let tabataTimerModel = self.tabataTimerModel,
            let label = self.coolDownTimerField?.indicationLabel
        {
            return self.timeLabelChangeWithFunction(oldValue: Int(tabataTimerModel.coolDownTime),
                                                    function: function,
                                                    label: label)
        }
        return 0
    }
    
    @IBAction func onStartButton(_ sender: Any) {
        let workoutTimerController = AVWorkoutTimerViewController()
        workoutTimerController.model = self.tabataTimerModel
        self.navigationController?.pushViewController(workoutTimerController, animated: true)
    }

}
