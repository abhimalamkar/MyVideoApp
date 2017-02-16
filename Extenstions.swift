//
//  Extenstions.swift
//  VideoApp
//
//  Created by Abhijeet Malamkar on 2/12/17.
//  Copyright © 2017 abhijeetmalamkar. All rights reserved.
//

import UIKit

extension UIView {
    func addConstrainsWithFormat(format:String,views: UIView...){
        
        var viewsDictionary = [String:UIView]()
        for (index,view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
}

var imageCache:NSCache<AnyObject,AnyObject> = NSCache()

class CustonImageView: UIImageView {
    
    var imageUrlString:String?
    
    func loadImageUsingUrl(urlStr : String){
        
        imageUrlString = urlStr
        
        let url = URL(string: urlStr)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlStr as AnyObject){
           self.image = imageFromCache as? UIImage
        }else {
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
            }else {
                DispatchQueue.main.async {
                    let image = UIImage(data: data!)
                    if self.imageUrlString == urlStr{
                        self.image = image
                    }
                    imageCache.setObject(image!, forKey: urlStr as AnyObject)
                }
            }
        })
        task.resume()
        
        }
    }
}


//

extension NSAttributedString {
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.height
    }
    
    func widthWithConstrainedHeight(height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return boundingBox.width
    }
}


extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
