//
//  NewsTableViewCell.swift
//  NewsPOC
//
//  Created by Manjunath Kaliwal on 6/17/19.
//  Copyright © 2019 Manjunath Kaliwal. All rights reserved.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet var thumbImageView: UIImageView?
    @IBOutlet var titleLabel: UILabel?
    @IBOutlet var subtitleLabel: UILabel?
    @IBOutlet var dateLabel: UILabel?
    @IBOutlet var ac: UIActivityIndicatorView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Set CornerRadius with Border and color
        self.thumbImageView?.thumbimage()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configureCell(newsInfo: News){
        
        self.ac?.startAnimating()
        if let title = newsInfo.title ,let subtitle = newsInfo.abstract, let datetitle = newsInfo.updated_date{
            titleLabel?.text = title
            subtitleLabel?.text = subtitle
            
            dateLabel?.text = "🗓 " + Utilities.splitstring(withstring: datetitle)
            
        }
        if let media = newsInfo.multimedia?.first {
            
            if  let metadata = media.url{
                self.thumbImageView?.image = UIImage(named: DetailView.PlaceholderImageName)
                
                thumbImageView?.sd_setImage(with:URL(string: metadata), completed:{ [weak self] (image, error, cache, url) in
                    
                    guard let strongSelf = self else {
                        return
                    }
                    
                    strongSelf.ac?.stopAnimating()
                    strongSelf.ac?.hidesWhenStopped = true
                    if let imgobj = image {
                        strongSelf.thumbImageView?.image = imgobj
                    } else {
                        print("didn't load image")
                    }
                })
                
            }else{
                self.ac?.stopAnimating()
                self.ac?.hidesWhenStopped = true
            }
        }
    }
}

extension UIImageView{
   
    func thumbimage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
}
