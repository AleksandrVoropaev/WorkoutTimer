//
//  AVSceduledTimerCreationViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVScheduledTimerCreationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "ADD NEW TIMER"
        
        tableView.rowHeight = 196

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cls : AnyClass
        
        if indexPath.row == 1 {
            cls = AVExerciseCreationTableViewCell.self
        } else {
            cls = AVExerciseDetailsTableViewCell.self
        }
        
        return tableView.dequeueReusableCell(withClass: cls)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height : CGFloat
        if indexPath.row == 1 {
            height = 196
        } else {
            height = 80
        }
        
        return height
    }
}
