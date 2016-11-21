//
//  AVExercisesViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit
import Alamofire

class AVYoutubeExercisesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [AVYouTubeVideoModel]? {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    func getVideos() {
        Alamofire.request("https://www.googleapis.com/youtube/v3/search",
                          method: .get,
                          parameters: ["part":"snippet",
                                       "q":"tabata workout",
                                       "type":"video",
                                       "maxResults":10,
                                       "key":"AIzaSyBX6boFzDlQ8R_0vG8waoar57wwHaKfzCc"],
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response) in
                            if let JSON = response.result.value {
//                                print(JSON)
                                var videos = [AVYouTubeVideoModel]()
                                for video in (JSON as! [String: AnyObject])["items"] as! NSArray {
                                    let videoObject = AVYouTubeVideoModel()
                                    videoObject.id = (video as! NSDictionary).value(forKeyPath: "id.videoId") as! String?
                                    videoObject.title = (video as! NSDictionary).value(forKeyPath: "snippet.title") as! String?
                                    videoObject.videoDecription = (video as! NSDictionary).value(forKeyPath: "snippet.description") as! String?
                                    videoObject.thumbnailImage = (video as! NSDictionary).value(forKeyPath: "snippet.thumbnails.high.url") as! String?
                                    videoObject.publicationDate = (video as! NSDictionary).value(forKeyPath: "snippet.publishedAt") as! String?
                                    self.getVideoDetailsWithVideoModel(model: videoObject)
                                    
                                    videoObject.channel = AVYouTubeChannel()
                                    videoObject.channel?.id = (video as! NSDictionary).value(forKeyPath: "snippet.channelId") as! String?
                                    self.getChannelDetailsWithVideoModel(model: videoObject)
                                    videos.append(videoObject)
                                }
                                
                                self.videos = videos
                            }
        }
    }
    
    func getVideoDetailsWithVideoModel(model: AVYouTubeVideoModel) {
        if let videoId = model.id {
            Alamofire.request("https://www.googleapis.com/youtube/v3/videos",
                              method: .get,
                              parameters: ["part":"statistics",
                                           "id":videoId,
                                           "key":"AIzaSyBX6boFzDlQ8R_0vG8waoar57wwHaKfzCc"],
                              encoding: URLEncoding.default,
                              headers: nil).responseJSON { (response) in
                                if let JSON = response.result.value {
//                                    print(JSON)
                                    for video in (JSON as! [String: AnyObject])["items"] as! NSArray {
                                        let stringViewCount = (video as! NSDictionary).value(forKeyPath: "statistics.viewCount") as! String?
                                        model.viewCount = Int(stringViewCount!)
                                    }
                                }
            }
        }
    }
    
    func getChannelDetailsWithVideoModel(model: AVYouTubeVideoModel) {
        if let channelId = model.channel?.id {
            Alamofire.request("https://www.googleapis.com/youtube/v3/channels",
                              method: .get,
                              parameters: ["part":"snippet",
                                           "id":channelId,
                                           "key":"AIzaSyBX6boFzDlQ8R_0vG8waoar57wwHaKfzCc"],
                              encoding: URLEncoding.default,
                              headers: nil).responseJSON { (response) in
                                if let JSON = response.result.value {
//                                    print(JSON)
                                    for channel in (JSON as! [String: AnyObject])["items"] as! NSArray {
                                        model.channel?.name = (channel as! NSDictionary).value(forKeyPath: "snippet.title") as! String?
                                        model.channel?.thumbnailImage = (channel as! NSDictionary).value(forKeyPath: "snippet.thumbnails.high.url") as! String?
                                    }
                                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getVideos()

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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoDetailsViewController = AVYouTubeVideoDetailsViewController()
        videoDetailsViewController.video = self.videos?[indexPath.item]
        
        self.navigationController?.pushViewController(videoDetailsViewController, animated: true)
    }
}
