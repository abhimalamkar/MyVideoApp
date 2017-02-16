//
//  ViewController.swift
//  VideoApp
//
//  Created by Abhijeet Malamkar on 2/11/17.
//  Copyright © 2017 abhijeetmalamkar. All rights reserved.
//

import UIKit

//added uicollection view controller for collection
class HomeViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{

    /*var videos:[Video] = {
        var channel = Channel()
        channel.name = "DownBoost"
        channel.profileImageName = "profile"
        
        var video = Video()
        video.title = "Abhijeet Malamkar"
        video.thumbnailImage = "thumbnailImage"
        video.channel = channel
        video.numberOfView = 2131231432413543
        
        var video1 = Video()
        video1.title = "Abhijeet Malamkar sadasdasd asdas d  asd asd as"
        video1.thumbnailImage = "thumbnailImage"
        video1.channel = channel
        video1.numberOfView = 2131231432413543
        
        var video2 = Video()
        video2.title = "Abhijeet Malamkar"
        video2.thumbnailImage = "thumbnailImage"
        video2.channel = channel
        video2.numberOfView = 2131231432413543

        return [video,video1,video2]
    }()*/
    
     var videos:[Video]?
    
    func fetchVideos() {
       // let config = URLSessionConfiguration.default // Session Configuration
       // let session = URLSession(configuration: config) // Load configuration into Session
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")!
        //let url = URL(string: "http://127.0.0.1:8000/stock/?format=json")!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
              print(error as Any)
                return
            }else {
                if let content = data
                {
                    do{
                        let json =  try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        print(json)
                        
                        self.videos = [Video]()
                        
                        for dictionary in json as! [[String:AnyObject]] {
                            
                            let video = Video()
                            video.title = dictionary["title"] as? String
                            video.thumbnailImage = dictionary["thumbnail_image_name"] as? String
                            video.numberOfView = dictionary["number_of_views"] as? NSNumber
                            let channelDictionary = dictionary["channel"] as? [String:AnyObject]
                            
                            let channel = Channel()
                            channel.profileImageName = channelDictionary?["profile_image_name"] as? String
                            channel.name = channelDictionary?["name"] as? String
                            
                            video.channel = channel
                            
                            self.videos?.append(video)
                            
                       }
                        DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                        }
                        
                       } catch let jsonError {
                       print(jsonError)
                    }
                }
            }
            
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
       
      //navigation item
      navigationItem.title = "Home"
      navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width-32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        navigationItem.titleView = titleLabel
        
        //collection view does not comes with a color so define it
         collectionView?.backgroundColor = UIColor.white
        
         collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupNavBarButtons(){
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        let moreButton = UIBarButtonItem(image: UIImage(named:"nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
     navigationItem.rightBarButtonItems = [moreButton,searchBarButtonItem]
        
    }
    
    func handleSearch(){
    print("search")
    }
    
    let settingsLauncher = SettingsLauncher()
    
    func handleMore() {
       settingsLauncher.showSettings()
    }
        
    let menuBar:MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstrainsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstrainsWithFormat(format: "V:|[v0(50)]|", views: menuBar)

    }
    
    //
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }

    //returns a cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    //for creation of collection
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //setting the size of cell object
        let height = (view.frame.width - 32) * 9 / 16 + 16 + 80
        return CGSize(width: view.frame.width, height: height)
    }
    
    //for line spacing between objects
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

