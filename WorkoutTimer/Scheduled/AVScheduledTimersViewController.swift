//
//  AVScheduledTimersViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVScheduledTimersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removeTimerButton: UIButton!
    
    var model: AVTimerArrayModel?
    var editingTableView: Bool = false
    
    let estimatedRowHeight: CGFloat = 198

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "SELECT TIMER"
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = self.estimatedRowHeight
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let model = self.model {
            model.load()
            
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let model = self.model {
            return model.count() - 1
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: AVScheduledTimerTableViewCell.self) as! AVScheduledTimerTableViewCell
        if let model = self.model {
            cell.model = model.object(at: indexPath.row + 1) as? TimerModel
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workoutTimerController = AVWorkoutTimerViewController()
        workoutTimerController.model = (self.tableView.cellForRow(at: indexPath) as! AVScheduledTimerTableViewCell).model
        self.tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        self.navigationController?.pushViewController(workoutTimerController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            if let model = self.model {
                model.delete(timer:model.object(at: indexPath.row + 1) as! TimerModel)
                
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func onAddTimerButton(_ sender: Any) {
        let timerCreationController = AVScheduledTimerCreationViewController()
        timerCreationController.model = self.model
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
