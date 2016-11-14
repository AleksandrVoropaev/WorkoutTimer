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
    
    var timerSettingsContainerView = UIView()
    var tabataTimerModel = AVScheduledTimerModel(name: "Tabata", warmupTime: 30, setsCount: 8, setsRestTime: 0, restTime: 10, coolDownTime: 30)
    func addExercise() {
        self.tabataTimerModel.addExercise(exerciseName: "Work", exerciseDuration: 20)
    }
    
    var warmupTimerField: AVTimerSettingsFieldView?
    var setsTimerField: AVTimerSettingsFieldView?
    var intervalsTimerField: AVTimerSettingsFieldView?
    var workTimerField: AVTimerSettingsFieldView?
    var restTimerField: AVTimerSettingsFieldView?
    var coolDownTimerField: AVTimerSettingsFieldView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "SET UP TIMER"
        
        self.addExercise()
        
        self.setTimerSettingsContainerView()
        
        self.warmupTimerField = self.timerField(title: "WARMUP",
                                               indication: "00:30",
                                               selectorTitle: "onWarmup",
                                               previousField: nil,
                                               isOnTop: true)
        self.setsTimerField = self.timerField(title: "SETS",
                                             indication: "8",
                                             selectorTitle: "onSets",
                                             previousField: warmupTimerField,
                                             isOnTop: false)
        self.workTimerField = self.timerField(title: "WORK",
                                             indication: "00:20",
                                             selectorTitle: "onWork",
                                             previousField: setsTimerField,
                                             isOnTop: false)
        self.restTimerField = self.timerField(title: "REST",
                                             indication: "00:10",
                                             selectorTitle: "onRest",
                                             previousField: workTimerField,
                                             isOnTop: false)
        self.coolDownTimerField = self.timerField(title: "COOL DOWN",
                                                 indication: "00:30",
                                                 selectorTitle: "onCoolDown",
                                                 previousField: restTimerField,
                                                 isOnTop: false)
    }
    
    func setTimerSettingsContainerView() {
        timerSettingsContainerView.backgroundColor = UIColor.lightGray
        self.view.addSubview(timerSettingsContainerView)
        timerSettingsContainerView.translatesAutoresizingMaskIntoConstraints = false
        let leftViewConstraint = NSLayoutConstraint(item: timerSettingsContainerView, 
                                                    attribute: NSLayoutAttribute.left,
                                                    relatedBy: NSLayoutRelation.equal,
                                                    toItem: self.view,
                                                    attribute: NSLayoutAttribute.leftMargin,
                                                    multiplier: 1.0,
                                                    constant: 0)
        let rightViewConstraint = NSLayoutConstraint(item: timerSettingsContainerView,
                                                     attribute: NSLayoutAttribute.right,
                                                     relatedBy: NSLayoutRelation.equal,
                                                     toItem: self.view,
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
                                                       toItem: self.view,
                                                       attribute: NSLayoutAttribute.centerY,
                                                       multiplier: 1.0,
                                                       constant: 0)
        self.view.addConstraints([leftViewConstraint, rightViewConstraint, heightViewContsraint, centerYViewConstraint])
    }
    
    func timerField(title: String, indication: String, selectorTitle: String, previousField: AVTimerSettingsFieldView?, isOnTop: Bool) -> AVTimerSettingsFieldView {
        let timerField = UINib.object(withClass: AVTimerSettingsFieldView.self) as! AVTimerSettingsFieldView
        timerField.titleLabel.text = title
        timerField.indicationLabel.text = indication
        timerField.minusButton.addTarget(self,
                                         action: NSSelectorFromString(selectorTitle + "MinusButton:"),
                                         for: UIControlEvents.touchUpInside)
        timerField.plusButton.addTarget(self,
                                        action: NSSelectorFromString(selectorTitle + "PlusButton:"),
                                        for: UIControlEvents.touchUpInside)
        self.timerSettingsContainerView.addSubview(timerField)
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
        if isOnTop {
            topTestViewConstraint = NSLayoutConstraint(item: timerField,
                                                       attribute: NSLayoutAttribute.top,
                                                       relatedBy: NSLayoutRelation.equal,
                                                       toItem: timerSettingsContainerView,
                                                       attribute: NSLayoutAttribute.top,
                                                       multiplier: 1.0,
                                                       constant: 0)
        } else {
            topTestViewConstraint = NSLayoutConstraint(item: timerField,
                                                       attribute: NSLayoutAttribute.top,
                                                       relatedBy: NSLayoutRelation.equal,
                                                       toItem: previousField,
                                                       attribute: NSLayoutAttribute.bottom,
                                                       multiplier: 1.0,
                                                       constant: 8)
        }

        self.view.addConstraints([topTestViewConstraint, heightTestViewContsraint, widthTestViewContsraint, centerXTestViewConstraint])
        
        return timerField
    }
    
    @IBAction func onWarmupMinusButton(_ sender: Any) {
        self.tabataTimerModel.warmupTime = self.manageWarmupTimerField(function: -)
    }
    
    @IBAction func onWarmupPlusButton(_ sender: Any) {
        self.tabataTimerModel.warmupTime = self.manageWarmupTimerField(function: +)
    }
    
    func manageWarmupTimerField(function:(Int, Int) -> Int) -> Int {
        return self.timeLabelChangeWithFunction(oldValue: self.tabataTimerModel.warmupTime, function: function, label: (self.warmupTimerField?.indicationLabel)!)
    }
    
    @IBAction func onSetsMinusButton(_ sender: Any) {
        self.tabataTimerModel.setsCount = self.manageSetsTimerField(function: -)
    }
    
    @IBAction func onSetsPlusButton(_ sender: Any) {
        self.tabataTimerModel.setsCount = self.manageSetsTimerField(function: +)
    }
    
    func manageSetsTimerField(function:(Int, Int) -> Int) -> Int {
        return self.countLabelChangeWithFunction(oldValue: self.tabataTimerModel.setsCount, function: function, label: (self.setsTimerField?.indicationLabel)!)
    }

    @IBAction func onWorkMinusButton(_ sender: Any) {
        self.tabataTimerModel.exercises[0].exerciseDuration = self.manageWorkTimerField(function: -)
    }
    
    @IBAction func onWorkPlusButton(_ sender: Any) {
        self.tabataTimerModel.exercises[0].exerciseDuration = self.manageWorkTimerField(function: +)
    }
    
    func manageWorkTimerField(function:(Int, Int) -> Int) -> Int {
        return self.timeLabelChangeWithFunction(oldValue: self.tabataTimerModel.exercises[0].exerciseDuration, function: function, label: (self.workTimerField?.indicationLabel)!)
    }

    @IBAction func onRestMinusButton(_ sender: Any) {
        self.tabataTimerModel.exerciseRestTime = self.manageRestTimerField(function: -)
    }
    
    @IBAction func onRestPlusButton(_ sender: Any) {
        self.tabataTimerModel.exerciseRestTime = self.manageRestTimerField(function: +)
    }
    
    func manageRestTimerField(function:(Int, Int) -> Int) -> Int {
        return self.timeLabelChangeWithFunction(oldValue: self.tabataTimerModel.exerciseRestTime, function: function, label: (self.restTimerField?.indicationLabel)!)
    }
    
    @IBAction func onCoolDownMinusButton(_ sender: Any) {
        self.tabataTimerModel.coolDownTime = self.manageCoolDownTimerField(function: -)
    }
    
    @IBAction func onCoolDownPlusButton(_ sender: Any) {
        self.tabataTimerModel.coolDownTime = self.manageCoolDownTimerField(function: +)
    }
    
    func manageCoolDownTimerField(function:(Int, Int) -> Int) -> Int {
        return self.timeLabelChangeWithFunction(oldValue: self.tabataTimerModel.coolDownTime, function: function, label: (self.coolDownTimerField?.indicationLabel)!)
    }
    
    @IBAction func onStartButton(_ sender: Any) {
        let workoutTimerController = AVWorkoutTimerViewController()
        workoutTimerController.model = self.tabataTimerModel
        self.navigationController?.pushViewController(workoutTimerController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
