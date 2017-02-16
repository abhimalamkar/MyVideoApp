//
//  VideoCell.swift
//  VideoApp
//
//  Created by Abhijeet Malamkar on 2/12/17.
//  Copyright © 2017 abhijeetmalamkar. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    
    override init(frame :CGRect){
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell{
    
    var video: Video? {
        didSet{
            
            titleLabel.text = video?.title
            
            setupThumbnailImage()
            
            setupProfileImage()
            
            /*
             if let thumbnailImageName = video?.thumbnailImage {
               thumbnailImageView.image = UIImage(named: thumbnailImageName)
            }else { thumbnailImageView.backgroundColor = UIColor.lightGray }  
             */
            /*
            if let profileImageName = video?.channel?.profileImageName {
                userProfileImageView.image = UIImage(named: profileImageName)
            }
            */
            if let channelName = video?.channel?.name ,let numberOfView = video?.numberOfView {
                
                let numberFormater = NumberFormatter()
                numberFormater.numberStyle = .decimal
                
                let bulletPoint: String = "\u{2022}"
                let subTitleText = "\(channelName) \(bulletPoint) \(numberFormater.string(from: numberOfView)!)"
                subtitleTextView.text = subTitleText
            }
            
            //measure the title text
            if let videoTitle = video?.title {
                
                //let size = CGSize(width: frame.width-16-44-8-16, height: 1000)
                //let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                //let nsString = NSString(string: videoTitle)
                let estimatedRect = heightForLabel(text: videoTitle, font: titleLabel.font, width: frame.width-16-44-8-16)
                    //nsString.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)//(with: size, options: option, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                
                if estimatedRect > 25 {
                    titleLabelHieghtConstraint?.constant = 44
                }else{
                    titleLabelHieghtConstraint?.constant = 20
                }
            }
            
        }
    }
    
    func setupThumbnailImage(){
        if let thumnailImageUrl = video?.thumbnailImage {
            thumbnailImageView.loadImageUsingUrl(urlStr: thumnailImageUrl)
        }
    }
    
    func setupProfileImage(){
      if let profileImageUrl = video?.channel?.profileImageName {
            userProfileImageView.loadImageUsingUrl(urlStr: profileImageUrl)
        }
    }
    
    func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
        
    }
    
    let thumbnailImageView: CustonImageView = {
        let imageVIew = CustonImageView()
        // imageVIew.backgroundColor = UIColor.lightGray
        //imageVIew.image = video.thu
        imageVIew.contentMode = .scaleAspectFill
        imageVIew.clipsToBounds = true
        return imageVIew
    }()
    
    let detailBackground:UIView = {
       let view = UIView()
       view.backgroundColor = UIColor.lightGray
       return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        //label.text = video.title
        //label.backgroundColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let view = UITextView()
        //view.backgroundColor = UIColor.gray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        view.textColor = UIColor.lightGray
        return view
    }()
    
    let userProfileImageView: CustonImageView = {
        let imageVIew = CustonImageView()
        imageVIew.backgroundColor = UIColor.gray
        imageVIew.contentMode = .scaleAspectFill
        imageVIew.clipsToBounds = true
        imageVIew.layer.cornerRadius = 22
        imageVIew.layer.masksToBounds = true
        return imageVIew
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    
    var titleLabelHieghtConstraint: NSLayoutConstraint?
    
    override func setupViews(){
        
        //adding image view
        addSubview(thumbnailImageView)
        //seperator lines
        addSubview(seperatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        addSubview(detailBackground)
        
        //setting contraints for image view
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailImageView]))
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]-16-[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": thumbnailImageView]))
        
        //setting contraints for seperator view
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": seperatorView]))
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(1)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": seperatorView]))
        
        
        addConstrainsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        //addConstrainsWithFormat(format: "V:|-16-[v0]-16-[v1(1)]|", views: thumbnailImageView,seperatorView)
        addConstrainsWithFormat(format: "H:|[v0]|", views: seperatorView)
        
        //userprofile imageview
        addConstrainsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView,userProfileImageView,seperatorView)
        addConstrainsWithFormat(format: "H:|-16-[v0(44)]|", views: userProfileImageView)
        
        //addConstrainsWithFormat(format: "V:|-16-[v0]-16-[v1(1)]|", views: thumbnailImageView,seperatorView)
        //addConstrainsWithFormat(format: "H:|-16-[v0(44)]|", views: userProfileImageView)

        //top contsraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        titleLabelHieghtConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20)
        addConstraint(titleLabelHieghtConstraint!)
        
        //addConstrainsWithFormat(format: "V:[v0(20)]", views: titleLabel)
        //addConstrainsWithFormat(format: "V:|[v0]|", views: titleLabel)
        
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
        
        
    }
    
}


