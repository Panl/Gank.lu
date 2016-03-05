//
//  BeautyCell.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/25.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import Kingfisher

class BeautyCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var beautyImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        cardView.layer.cornerRadius = 5
        cardView.layer.masksToBounds = true
        
    }
    
    func setCellViews(girlFlow:GirlFlow){
        self.beautyImageView.backgroundColor = UIColor.randomColor()
        self.beautyImageView.kf_setImageWithURL(NSURL(string: girlFlow.url)!)
        self.nickNameLabel.text = girlFlow.who
        let date = DateUtil.stringToDate(girlFlow.publishedAt)
        self.timeLabel.text = DateUtil.dateToString(date, dateFormat: "yyyy年MM月dd日")
        self.descLabel.text = girlFlow.desc
    }
    
    func addGirlAction(indexPath:NSIndexPath,target:AnyObject,action:Selector){
        beautyImageView.userInteractionEnabled = true
        beautyImageView.tag = indexPath.row
        let tap = UITapGestureRecognizer(target: target, action: action)
        beautyImageView.addGestureRecognizer(tap)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UIColor{
    static func randomColor()->UIColor{
        let red = CGFloat(arc4random_uniform(255))
        let green = CGFloat(arc4random_uniform(255))
        let blue = CGFloat(arc4random_uniform(255))
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 0.8)
    }
}
