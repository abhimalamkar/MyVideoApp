//
//  MenuBar.swift
//  VideoApp
//
//  Created by Abhijeet Malamkar on 2/12/17.
//  Copyright © 2017 abhijeetmalamkar. All rights reserved.
//

import UIKit

class MenuBar: UIView,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
   
    lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
       let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
       cv.backgroundColor = UIColor.purple
       cv.dataSource = self
       cv.delegate = self
       return cv
    }()
    
    let cellId = "cellId"
    let imageNames:[String] = ["home","trending","subscriptions","account"]
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        addSubview(collectionView)
        addConstrainsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstrainsWithFormat(format: "V:|[v0]|", views: collectionView)
    
        let selectedIndexPath = NSIndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: false, scrollPosition: .left)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        //cell.tintColor = UIColor.gray
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

class MenuCell: BaseCell {
    
    let imageView: UIImageView = {
         let iv = UIImageView()
         iv.image = UIImage(named: "image")?.withRenderingMode(.alwaysTemplate)
         iv.tintColor = UIColor.lightGray
         return iv
    }()
    
    override var isHighlighted: Bool{
        didSet{
            imageView.tintColor = isHighlighted ? UIColor.white : UIColor.lightGray
        }
    }
    
    override var isSelected: Bool{
        didSet{
            //change it to tint
            imageView.tintColor = isSelected ? UIColor.white : UIColor.lightGray
        }
    }
   
    override func setupViews() {
      super.setupViews()
        
        addSubview(imageView)
        
        //backgroundColor = UIColor.lightGray
        addConstrainsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstrainsWithFormat(format: "V:[v0(28)]", views: imageView)

        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
