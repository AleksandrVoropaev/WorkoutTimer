//
//  AVExercisesViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVYoutubeExercisesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
//    var videos: [AVYouTubeVideoModel] = {
//        var tiestoChannel = AVYouTubeChannel()
//        tiestoChannel.name = "officialtiesto"
//        tiestoChannel.profileImageName = "tiesto_profile_2"
//        
//        
//        var firstVideo = AVYouTubeVideoModel()
//        firstVideo.title = "Tiësto - Live @ Tomorrowland 2016"
//        firstVideo.thumbnailImageName = "tiesto_cover"
//        firstVideo.channel = tiestoChannel
//        firstVideo.numberOfViews = 747030
//        
//        var secondVideo = AVYouTubeVideoModel()
//        secondVideo.title = "ClubLife by Tiësto Podcast 500 - First Hour"
//        secondVideo.thumbnailImageName = "tiesto_cover_2"
//        secondVideo.channel = tiestoChannel
//        secondVideo.numberOfViews = 30046
//        
//        return [firstVideo, secondVideo]
//    }()
    var videos: [AVYouTubeVideoModel]?
    
    func fetchVideos() {
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url as! URL) { (data, response, error) in
            if error != nil {
                print(error as Any)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                print(json)
                self.videos = [AVYouTubeVideoModel]()
                
                for dictionary in json as! [[String: AnyObject]] {
                    let video = AVYouTubeVideoModel()
                    video.title = dictionary["title"] as! String?
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as! String?
                    video.numberOfViews = dictionary["number_of_views"] as! NSNumber?

                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
                    let channel = AVYouTubeChannel()
                    channel.name = channelDictionary["name"] as! String?
                    channel.profileImageName = channelDictionary["profile_image_name"] as! String?
                    
                    video.channel = channel
                    self.videos?.append(video)
                }
                
                self.collectionView?.reloadData()
            } catch let jsonError {
                print(jsonError)
            }
            
            let string = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            print(string as Any)
        }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.fetchVideos()

        self.title = "WATCH EXERCISES"
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.RGB(red: 205, green: 32, blue: 31)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        self.collectionView?.backgroundColor = UIColor.white
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent

        self.collectionView?.register(AVExerciseCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.black]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if let count = self.videos?.count {
//            return count
//        }
//        
//        return 0
        
        return self.videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! AVExerciseCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.video = self.videos?[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.frame.width - 32) / 16 * 9
        
        return CGSize.init(width: self.view.frame.width, height: height + 32 + 8 + 44 + 1 + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class AVExerciseCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            
//            self.setupThumbnailImage()
            if let thumbnailImageName = self.video?.thumbnailImageName {
                self.thumbnailImageView.loadImageWithURLString(URLString: thumbnailImageName)
            }
            
//            if let imageName = video?.thumbnailImageName {
//                self.thumbnailImageView.image = UIImage(named: imageName)
//            }

//            self.setupProfileImageName()
            
            if let profileImageName = video?.channel?.profileImageName {
                self.userProfileView.loadImageWithURLString(URLString: profileImageName)
            }

            
//            if let profileImageName = video?.channel?.profileImageName {
//                self.userProfileView.image = UIImage(named: profileImageName)
//            }

            if let channelName = video?.channel?.name,
                let numberOfViews = video?.numberOfViews
//                let uploadDate = video?.uploadDate
            {
                let formatter = NumberFormatter()
                formatter.numberStyle = .decimal
                self.subTitleTextView.text = "\(channelName) ·· \(formatter.string(from: numberOfViews)!) views ·· uploadDate"
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
    
//    func setupThumbnailImage() {
//        if let thumbnailImageURL = self.video?.thumbnailImageName {
//            let url = NSURL(string: thumbnailImageURL)
//            URLSession.shared.dataTask(with: url as! URL, completionHandler: { (data, respones, error) in
//                if error != nil {
//                    print(error as Any)
//                    
//                    return
//                }
//                
//                DispatchQueue.main.async {
//                    self.thumbnailImageView.image = UIImage(data: data!)
//                }
//            }).resume()
//        }
//    }
//    
//    func setupProfileImageName() {
//        if let profileImageNameURL = self.video?.channel?.profileImageName {
//            let url = NSURL(string: profileImageNameURL)
//            URLSession.shared.dataTask(with: url as! URL, completionHandler: { (data, respones, error) in
//                if error != nil {
//                    print(error as Any)
//                    
//                    return
//                }
//                
//                DispatchQueue.main.async {
//                    self.userProfileView.image = UIImage(data: data!)
//                }
//            }).resume()
//        }
//    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tiesto_cover")
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let separatorView: UIImageView = {
        let separator = UIImageView()
        separator.backgroundColor = UIColor.lightGray

        return separator
    }()
    
    let userProfileView: UIImageView = {
        let profile = UIImageView()
        profile.image = UIImage(named: "tiesto_profile")
        profile.layer.cornerRadius = 22
        profile.layer.masksToBounds = true
        profile.contentMode = UIViewContentMode.scaleAspectFill

        return profile
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tiësto - Live @ Tomorrowland 2016"
        label.numberOfLines = 2

        return label
    }()
    
    let subTitleTextView: UITextView = {
        let subTitle = UITextView()
        subTitle.text = "Watch Tiësto's entire performance from Tomorrowland 2016."
        subTitle.textColor = UIColor.lightGray
        subTitle.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 0)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        
        return subTitle
    }()
}
