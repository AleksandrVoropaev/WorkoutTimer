//
//  AVScheduledTimersViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

#if !RX_NO_MODULE
    import RxSwift
    import RxCocoa
#endif

class AVScheduledTimersViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var removeTimerButton: UIButton!
    
    let disposeBag = DisposeBag()
    var model: AVObservableTimersArrayModel?

    var editingTableView: Bool = false    
    let estimatedRowHeight: CGFloat = 198

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "SELECT TIMER"
        
        let tableView = self.tableView
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = self.estimatedRowHeight
        
        self.setupRx()
    }
    
    func setupRx() {
        if let model = self.model, let tableView = self.tableView {
            tableView.register(UINib.init(nibName: "AVScheduledTimerTableViewCell",
                                          bundle: Bundle.main),
                               forCellReuseIdentifier: "AVScheduledTimerTableViewCell")
            
            model.timers.rx_elements()
                .observeOn(MainScheduler.instance)
                .map({ elements in
                    elements.filter({ (model: TimerModel) -> Bool in
                        return elements.last != model
                    })
                })
                .bindTo(tableView.rx.items) { (tableView, row, element) in
                    let cell = tableView.dequeueReusableCell(withIdentifier: "AVScheduledTimerTableViewCell") as! AVScheduledTimerTableViewCell
                    cell.model = model.timers[row + 1]
                    
                    return cell
                }.addDisposableTo(disposeBag)
            
            tableView.rx.itemSelected
                .subscribe { [unowned self] indexPathEvent in
                    if let indexPath = indexPathEvent.element {
                        let workoutTimerController = AVWorkoutTimerViewController()
                        workoutTimerController.model = model.timers[indexPath.row + 1]
                        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
                        self.navigationController?.pushViewController(workoutTimerController,
                                                                      animated: true)
                    }
                }.addDisposableTo(disposeBag)
            
            tableView.rx.itemDeleted
                .subscribe { indexPath in
                    if let index = indexPath.element?.row {
                        model.removeTimer(at: index + 1)
                    }
                }.addDisposableTo(disposeBag)
            
            tableView.rx.itemMoved
                .subscribe {
                    if let index = $0.element?.sourceIndex.row, let targetIndex = $0.element?.destinationIndex.row {
                        model.moveTimer(from: index + 1, to: targetIndex + 1)
                    }
                }.addDisposableTo(disposeBag)
            
            tableView.rx.setDelegate(self)
                .addDisposableTo(disposeBag)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onAddTimerButton(_ sender: Any) {
        let timerCreationController = AVScheduledTimerCreationViewController()
        timerCreationController.model = self.model
        self.navigationController?.pushViewController(timerCreationController, animated: true)
    }
    
    @IBAction func onRemoveTimerButton(_ sender: Any) {
        let editing = !self.editingTableView
        
        self.tableView.setEditing(editing, animated: true)
        let title = editing ? "OK" : "EDIT"
        self.removeTimerButton.setTitle(title, for: UIControlState.normal)
        
        self.editingTableView = editing
    }

}
