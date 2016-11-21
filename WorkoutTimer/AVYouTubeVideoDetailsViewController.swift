//
//  AVYouTubeVideoDetailsViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/21/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVYouTubeVideoDetailsViewController: UIViewController {
    
//    @IBOutlet weak var webView: UIWebView!

    let webView: UIWebView = {
        let webView = UIWebView()
        webView.backgroundColor = UIColor.red

        return webView
    }()
    
    
    var video: AVYouTubeVideoModel?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.RGB(red: 205, green: 32, blue: 31)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let id = self.video?.id {
            let width = self.view.frame.size.width
            let height = width / 16 * 9
            let embedString = "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" height=\"" + String(describing: height) + "\" width=\"" + String(describing: width) + "\" src=\"http://www.youtube.com/embed/" + id + "?showinfo=0&modestbranding=1&frameborder=0&rel=0\"></iframe></body></html>"
            self.webView.loadHTMLString(embedString, baseURL: nil)
        }
    }
    
    func setupViews() {
        self.view.addSubview(self.webView)
        
        self.view.addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: self.webView)
        self.view.addConstraintsWithFormat(format: "V:|-0-[v0(300)]", views: self.webView)
        
    }

}
