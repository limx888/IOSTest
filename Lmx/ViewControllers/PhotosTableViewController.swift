//
//  PhotosTableViewController.swift
//  Lmx
//
//  Created by Lmx on 2019/4/4.
//  Copyright © 2019 Lmx. All rights reserved.
//

import UIKit

class PhotosTableViewController: UITableViewController {
    fileprivate var photos = [Photo]()
    fileprivate var personalPhotos = [UIImage?]()
    fileprivate var profileImages = [UIImage?]()
    fileprivate var photoCache = NSCache<NSString, UIImage>()
    
    /* WebView播放视频 */
    @IBAction func LeftButton(_ sender: Any) {
        let webVC: WebViewController = WebViewController()
        webVC.modalPresentationStyle = .fullScreen //设置为全屏即可
        webVC.url = "http://vfx.mtime.cn/Video/2019/03/19/mp4/190319212559089721.mp4"
        webVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(webVC, animated: true)
    }
    
    /* SJVideoPlayer播放视频 */
    @IBAction func RightButton(_ sender: Any) {
        let videoPlayerView: SJVideoPlayerViewController = SJVideoPlayerViewController()
        videoPlayerView.modalPresentationStyle = .fullScreen //设置为全屏即可
        videoPlayerView.url = "http://1253131631.vod2.myqcloud.com/26f327f9vodgzp1253131631/f4c0c9e59031868222924048327/f0.mp4"
        videoPlayerView.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(videoPlayerView, animated: true)
    }
    
    private var loadingView: LoadingView! {
        didSet {
            loadingView.frame.origin = self.view.frame.origin
            loadingView.frame.size.width = self.view.frame.size.width
        }
    }
    
    lazy var feedRefreshControl: UIRefreshControl = {
        let feedRefreshControl = UIRefreshControl()
        feedRefreshControl.tintColor = UIColor.clear
        feedRefreshControl.addTarget(self, action: #selector(load(with:)), for: .valueChanged)
        
        self.loadingView = LoadingView()
        self.loadingView.frame.size.height = feedRefreshControl.frame.size.height
        
        feedRefreshControl.addSubview(self.loadingView)
        
        return feedRefreshControl
    }()
    
    fileprivate var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = localize(with: "Feature")
        tableView.estimatedRowHeight = 303
        tableView.rowHeight = UITableView.automaticDimension
        
        currentPage = 1
        tableView.refreshControl = feedRefreshControl
//        tableView.feedRefreshControl = feedRefreshControl
        load()
    }
    
    @objc func load(with page: Int = 1) {
        feedRefreshControl.beginRefreshing()
        
        let url = URL(string: Constants.Base.UnsplashAPI + Constants.Base.Curated)!
        
        if Token.getToken() != nil {
            NetworkService.request(url: url, method: NetworkService.HTTPMethod.GET,
                                   parameters: [
                                    Constants.Parameters.ClientID as Dictionary<String, AnyObject>,
                                    ["page": page as AnyObject]
            ], headers: ["Authorization": "Bearer " + Token.getToken()!]) { jsonData in
                
                OperationService.parseJsonWithPhotoData(jsonData as! [Dictionary<String, AnyObject>]) { photo in
                    self.photos.append(photo)
                    self.personalPhotos.append(nil)
                    self.profileImages.append(nil)
                }
                
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                    self.feedRefreshControl.endRefreshing()
                }
            }
        } else {
            NetworkService.request(url: url, method: NetworkService.HTTPMethod.GET,
                                   parameters: [
                                    Constants.Parameters.ClientID as Dictionary<String, AnyObject>,
                                    ["page": page as AnyObject]
            ]) { jsonData in
                OperationService.parseJsonWithPhotoData(jsonData as! [Dictionary<String, AnyObject>]) { photo in
                    self.photos.append(photo)
                    self.personalPhotos.append(nil)
                    self.profileImages.append(nil)
                }
                
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                    self.feedRefreshControl.endRefreshing()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.width * 0.7
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath) as! PhotoTableViewCell
//        cell.photoImageView.image = UIImage(named: "photo")
//        cell.userImageView.image = UIImage(named: "user")
//        cell.userLabel.text = "hippo_san"
//        cell.heartButton.setBackgroundImage(UIImage(named: "heart-outline"), for: .normal)
//        cell.heartCountLabel.text = "1142"
//        return cell
        let photo = photos[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Photo", for: indexPath) as! PhotoTableViewCell
        
        cell.photoImageView.image = nil
        cell.userImageView.image = nil
        
        if let photoURL = URL(string: photo.imageURL) {
            if let cachedImage = self.photoCache.object(forKey: photo.imageURL as NSString) {
                cell.photoImageView.image = cachedImage
            } else {
                NetworkService.image(with: photoURL) { image in
                    self.photoCache.setObject(image, forKey: photo.imageURL as NSString)
                    
                    self.personalPhotos[indexPath.row] = image
                    
                    if let updateCell = tableView.cellForRow(at: indexPath) as? PhotoTableViewCell {
                        updateCell.photoImageView.alpha = 0
                        
                        UIView.animate(withDuration: 0.3) {
                            updateCell.photoImageView.alpha = 1
                            updateCell.photoImageView.image = image
                        }
                        
                    }
                }
            }
        }
        
        if let profileURL = URL(string: photo.profileImageURL) {
            if let cachedImage = self.photoCache.object(forKey: photo.profileImageURL as NSString) {
                cell.userImageView.image = cachedImage
            } else {
                NetworkService.image(with: profileURL) { image in
                    self.photoCache.setObject(image, forKey: photo.profileImageURL as NSString)
                    
                    self.profileImages[indexPath.row] = image
                    
                    if let updateCell = tableView.cellForRow(at: indexPath) as? PhotoTableViewCell {
                        updateCell.userImageView.image = image
                    }
                }
            }
        }
        
        cell.userLabel.text = photo.name
        if photo.isLike {
            cell.heartButton.setBackgroundImage(UIImage(named: "heart-outline"), for: .normal)
        } else {
            cell.heartButton.setBackgroundImage(UIImage(named: "heart-liked"), for: .normal)
        }
        
        cell.heartCountLabel.text = "\(photo.heartCount)"
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ProfileSegue", sender: self)
    }
}
