//
//  GirlCell.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/1/6.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit

struct GirlFlow {
    let updatedAt:String
    let who:String
    let publishedAt:String
    let objectId:String
    let used:Bool
    let type:String
    let createdAt:String
    let desc:String
    let url:String
}

class GirlCell: UITableViewCell {

    @IBOutlet weak var girlImageView: UIImageView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 5
        self.contentView.backgroundColor = UIColor.whiteColor()
        //self.contentView.layer.shadowColor = UIColor.grayColor().CGColor
        //self.contentView.layer.shadowOffset = CGSizeMake(4, 4)
        //self.contentView.layer.shadowOpacity = 0.8
        //self.contentView.layer.shadowRadius = 3
        self.girlImageView.layer.cornerRadius = 5
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
