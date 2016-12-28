//
//  AVScheduledTimersViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AVScheduledTimersViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource*/ {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removeTimerButton: UIButton!
    
    var model: AVTimerArrayModel?
    var editingTableView: Bool = false
    
    //try observable
    let disposeBag = DisposeBag()
    var observableModel = AVObservableTimersArrayModel()
    
    
    let estimatedRowHeight: CGFloat = 198

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "SELECT TIMER"
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = self.estimatedRowHeight
        
        
        //try observable
        self.observableModel.load()
        
        tableView.register(UINib.init(nibName: "AVScheduledTimerTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "AVScheduledTimerTableViewCell")
        
        self.observableModel.timers.rx_elements()
            .observeOn(MainScheduler.instance)
            .bindTo(tableView.rx.items) { (tableView, row, element) in
                if row == 0 {
                    let cell = UITableViewCell()
//                    cell.rowHeight = 0
                    
                    return cell
                }
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "AVScheduledTimerTableViewCell") as! AVScheduledTimerTableViewCell
                
//                cell.label.text = "\(element.name) \(element.warmapTime) \(element.coolDownTime)"
                cell.model = self.observableModel.timers[row]

                
                return cell
            }
            .addDisposableTo(disposeBag)
        //----=--=-==--==-=-=-=-=-=-=-=-=-=---

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        if let model = self.model {
//            model.load()
//            
//            self.tableView.reloadData()
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let model = self.model {
//            return model.count() - 1
//        }
//        
//        return 0
//    }
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withClass: AVScheduledTimerTableViewCell.self) as! AVScheduledTimerTableViewCell
//        if let model = self.model {
//            cell.model = model.object(at: indexPath.row + 1) as? TimerModel
//        }
//        
//        return cell
//    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let workoutTimerController = AVWorkoutTimerViewController()
//        workoutTimerController.model = (self.tableView.cellForRow(at: indexPath) as! AVScheduledTimerTableViewCell).model
//        self.tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
//        self.navigationController?.pushViewController(workoutTimerController, animated: true)
//    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCellEditingStyle.delete {
//            if let model = self.model {
//                model.delete(timer:model.object(at: indexPath.row + 1) as! TimerModel)
//                
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    @IBAction func onAddTimerButton(_ sender: Any) {
        let timerCreationController = AVScheduledTimerCreationViewController()
//        timerCreationController.model = self.model
        timerCreationController.model = self.observableModel
        self.navigationController?.pushViewController(timerCreationController, animated: true)
    }
    
    @IBAction func onRemoveTimerButton(_ sender: Any) {
        let editing = !self.editingTableView
        
        self.tableView.setEditing(editing, animated: true)
        let title = editing ? "OK" : "REMOVE"
        self.removeTimerButton.setTitle(title, for: UIControlState.normal)
        
        self.editingTableView = editing
    }

}
