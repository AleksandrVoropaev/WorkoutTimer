//
//  AVExerciseCollectionViewCell.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/21/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVExerciseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    func setupViews() {
        self.addSubview(self.thumbnailImageView)
        self.addSubview(self.separatorView)
        self.addSubview(self.userProfileView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.subTitleTextView)
        
        self.addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: self.thumbnailImageView)
        self.addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: self.userProfileView)
        self.addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: self.thumbnailImageView, self.userProfileView, self.separatorView)
        self.addConstraintsWithFormat(format: "H:|[v0]|", views: self.separatorView)
        
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.thumbnailImageView, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 8))
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.userProfileView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 8))
        self.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.thumbnailImageView, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0))
        self.titleLabelHeightConstraint = NSLayoutConstraint(item: self.titleLabel, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 44)
        self.addConstraint(self.titleLabelHeightConstraint!)
        
        self.addConstraint(NSLayoutConstraint(item: self.subTitleTextView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: self.titleLabel, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 4))
        self.addConstraint(NSLayoutConstraint(item: self.subTitleTextView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: self.titleLabel, attribute: NSLayoutAttribute.left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.subTitleTextView, attribute: NSLayoutAttribute.right, relatedBy: NSLayoutRelation.equal, toItem: self.titleLabel, attribute: NSLayoutAttribute.right, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: self.subTitleTextView, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.height, multiplier: 1, constant: 30))
        
    }
    
    var video: AVYouTubeVideoModel? {
        didSet {
            self.titleLabel.text = video?.title
            
            if let thumbnailImageName = self.video?.thumbnailImage {
                self.thumbnailImageView.loadImageWithURLString(URLString: thumbnailImageName)
            }
            
            if let profileImageName = self.video?.channel?.thumbnailImage {
                self.userProfileView.loadImageWithURLString(URLString: profileImageName)
            }
            
            if let channelName = video?.channel?.name,
                let numberOfViews = video?.viewCount,
                let publicationDate = video?.publicationDate
            {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                
                self.subTitleTextView.text = "\(channelName) ·· \(formatter.string(for: numberOfViews)!) views ·· \(publicationDate)!)"
            }
            
            if let title = video?.title {
                let width = self.frame.width - 32 - 44 - 8
                let heigth = CGFloat(1000)
                let option = NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin)
                let size = CGSize(width: width, height: heigth)
                let estimatedRect = NSString(string: title).boundingRect(with: size,
                                                                         options: option,
                                                                         attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: UIFont.labelFontSize)],
                                                                         context: nil)
                if estimatedRect.size.height > 21 {
                    self.titleLabelHeightConstraint?.constant = 44
                } else {
                    self.titleLabelHeightConstraint?.constant = 20
                }
            }
        }
    }
    
    let thumbnailImageView: AVYouTubeImageView = {
        let imageView = AVYouTubeImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let separatorView: UIImageView = {
        let separator = UIImageView()
        separator.backgroundColor = UIColor.lightGray
        
        return separator
    }()
    
    let userProfileView: AVYouTubeImageView = {
        let profile = AVYouTubeImageView()
        profile.contentMode = UIViewContentMode.scaleAspectFill
        profile.layer.masksToBounds = true
        profile.layer.cornerRadius = 22
        
        return profile
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    let subTitleTextView: UITextView = {
        let subTitle = UITextView()
        subTitle.textColor = UIColor.lightGray
        subTitle.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 0)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.isEditable = false
        
        return subTitle
    }()
}
