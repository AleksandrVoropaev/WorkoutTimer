//
//  AVYouTubeVideoDetailsViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/21/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVYouTubeVideoDetailsViewController: UIViewController, UIWebViewDelegate {
    
    var webViewHeightConstraint: NSLayoutConstraint?
    var subTitleTextViewHeightConstraint: NSLayoutConstraint?
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    let webView: UIWebView = {
        let webView = UIWebView()
        webView.scrollView.isScrollEnabled = false
        webView.contentMode = UIViewContentMode.scaleAspectFit
        webView.clipsToBounds = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true

        return scrollView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    var subTitleTextView: UITextView = {
        let subTitle = UITextView()
        subTitle.textColor = UIColor.lightGray
        subTitle.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 0)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.isEditable = false
        
        return subTitle
    }()
    
    var video: AVYouTubeVideoModel?
    
//	MARK: Initializations and Deallocations

    deinit {
        self.subTitleTextView.removeObserver(self, forKeyPath: "contentSize")
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupViews()
    }
    
//	MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.subTitleTextView.addObserver(self,
                                          forKeyPath: "contentSize",
                                          options:NSKeyValueObservingOptions.new,
                                          context: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.isTranslucent = false
        navigationBar?.barTintColor = UIColor.RGB(red: 205, green: 32, blue: 31)
        navigationBar?.tintColor = UIColor.white
        navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let video = self.video {
            let width = self.view.bounds.size.width
            let height = width / 16 * 9
            
            self.webViewHeightConstraint?.constant = height
            self.scrollView.contentSize.width = width

            if let id = video.id {
                let embedString = "<html><head><style type=\"text/css\">body {background-color: transparent;color: white;}</style></head><body style=\"margin:0\"><iframe frameBorder=\"0\" height=\"\(height)\" width=\"\(width)\" src=\"http://www.youtube.com/embed/\(id)?showinfo=0&modestbranding=1&frameborder=0&rel=0\"></iframe></body></html>"
                self.webView.loadHTMLString(embedString, baseURL: nil)
            }
            
            if let titleText = video.title {
                let labelWidth = self.view.frame.width - 32
                let labelHeigth = CGFloat(1000)
                let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
                let labelSize = CGSize(width: labelWidth, height: labelHeigth)
                let estimatedRect = NSString(string: titleText).boundingRect(with: labelSize,
                                                                             options: option,
                                                                             attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: UIFont.labelFontSize)],
                                                                             context: nil)
                self.titleLabelHeightConstraint?.constant = estimatedRect.size.height + 8
            }
            
            self.titleLabel.text = video.title
            self.subTitleTextView.text = video.videoDescription
        }
    }
    
    fileprivate func setupViews() {
        self.view.addSubview(self.webView)
        self.view.addSubview(self.scrollView)

        self.view.addConstraint(NSLayoutConstraint(item: self.webView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.webView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.webView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0))
        
        self.webViewHeightConstraint = NSLayoutConstraint(item: self.webView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 0)
        self.view.addConstraint(self.webViewHeightConstraint!)
        
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.webView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.scrollView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0))
        
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.subTitleTextView)
        
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.scrollView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 16))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.scrollView, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 16))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -32))
        self.titleLabelHeightConstraint = NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 44)
        self.scrollView.addConstraint(self.titleLabelHeightConstraint!)

        self.scrollView.addConstraint(NSLayoutConstraint(item: self.subTitleTextView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.titleLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 8))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.subTitleTextView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.scrollView, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 16))
        self.scrollView.addConstraint(NSLayoutConstraint(item: self.subTitleTextView, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: self.scrollView, attribute: NSLayoutAttribute.width, multiplier: 1, constant: -32))
        self.subTitleTextViewHeightConstraint = NSLayoutConstraint(item: self.subTitleTextView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 44)
        self.scrollView.addConstraint(self.subTitleTextViewHeightConstraint!)
    }
    
//	MARK: Observation

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.subTitleTextViewHeightConstraint?.constant = subTitleTextView.contentSize.height
    }
    
}
