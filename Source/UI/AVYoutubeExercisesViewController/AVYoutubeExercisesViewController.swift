//
//  AVExercisesViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit
import Alamofire

let youtubeSearchURLString = "https://www.googleapis.com/youtube/v3/search"
let youtubeVideosURLString = "https://www.googleapis.com/youtube/v3/videos"
let youtubeChannelsURLString = "https://www.googleapis.com/youtube/v3/channels"
let youtubeKey = "AIzaSyBX6boFzDlQ8R_0vG8waoar57wwHaKfzCc"
let collectionViewItemHeightFix = CGFloat(32 + 8 + 44 + 1 + 20)
let youtubeSearchString = "best tabata workout"

class AVYoutubeExercisesViewController: UICollectionViewController,
                                        UICollectionViewDelegateFlowLayout {
    
    var videos: [AVYouTubeVideoModel]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

//	MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getVideos()
        self.title = "WATCH EXERCISES"
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.isTranslucent = false
        navigationBar?.barTintColor = UIColor.RGB(red: 205, green: 32, blue: 31)
        navigationBar?.tintColor = UIColor.white
        navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        let collectionView = self.collectionView
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(AVExerciseCollectionViewCell.self,
                                 forCellWithReuseIdentifier: "cellID")
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)

        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.isTranslucent = true
        navigationBar?.barTintColor = UIColor.white
        navigationBar?.tintColor = UIColor.black
        navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.black]
    }
    
//	MARK: Private

    fileprivate func getVideos() {
        Alamofire.request(youtubeSearchURLString,
                          method: .get,
                          parameters: ["part":"snippet",
                                       "q":youtubeSearchString,
                                       "type":"video",
                                       "maxResults":10,
                                       "key":youtubeKey],
                          encoding: URLEncoding.default,
                          headers: nil).responseJSON { (response) in
                            if let JSON = response.result.value {
                                var videos = [AVYouTubeVideoModel]()
                                for video in (JSON as! [String: AnyObject])["items"] as! NSArray {
                                    let videoModel = AVYouTubeVideoModel()
                                    videoModel.id = (video as! NSDictionary).value(forKeyPath: "id.videoId") as! String?
                                    videoModel.title = (video as! NSDictionary).value(forKeyPath: "snippet.title") as! String?
                                    videoModel.videoDescription = (video as! NSDictionary).value(forKeyPath: "snippet.description") as! String?
                                    videoModel.thumbnailImage = (video as! NSDictionary).value(forKeyPath: "snippet.thumbnails.high.url") as! String?
                                    videoModel.publicationDate = (video as! NSDictionary).value(forKeyPath: "snippet.publishedAt") as! String?
                                    videoModel.channel = AVYouTubeChannel()
                                    videoModel.channel?.id = (video as! NSDictionary).value(forKeyPath: "snippet.channelId") as! String?
                                    self.getVideoDetailsWithVideoModel(model: videoModel)
                                    self.getChannelDetailsWithVideoModel(model: videoModel)
                                    videos.append(videoModel)
                                }
                                
                                self.videos = videos
                            }
        }
    }
    
    fileprivate func getVideoDetailsWithVideoModel(model: AVYouTubeVideoModel) {
        if let videoId = model.id {
            Alamofire.request(youtubeVideosURLString,
                              method: .get,
                              parameters: ["part":"statistics",
                                           "id":videoId,
                                           "key":youtubeKey],
                              encoding: URLEncoding.default,
                              headers: nil).responseJSON { (response) in
                                if let JSON = response.result.value {
                                    for video in (JSON as! [String: AnyObject])["items"] as! NSArray {
                                        if let stringViewCount = (video as! NSDictionary).value(forKeyPath: "statistics.viewCount") as! String? {
                                            model.viewCount = Int(stringViewCount)
                                        }
                                    }
                                }
            }
        }
    }
    
    fileprivate func getChannelDetailsWithVideoModel(model: AVYouTubeVideoModel) {
        if let channelId = model.channel?.id {
            Alamofire.request(youtubeChannelsURLString,
                              method: .get,
                              parameters: ["part":"snippet",
                                           "id":channelId,
                                           "key":youtubeKey],
                              encoding: URLEncoding.default,
                              headers: nil).responseJSON { (response) in
                                if let JSON = response.result.value {
                                    for channel in (JSON as! [String: AnyObject])["items"] as! NSArray {
                                        model.channel?.name = (channel as! NSDictionary).value(forKeyPath: "snippet.title") as! String?
                                        model.channel?.thumbnailImage = (channel as! NSDictionary).value(forKeyPath: "snippet.thumbnails.high.url") as! String?
                                    }
                                }
            }
        }
    }
    
//	MARK: UICollectionView

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
        
        return CGSize.init(width: self.view.frame.width,
                           height: height + collectionViewItemHeightFix)
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
