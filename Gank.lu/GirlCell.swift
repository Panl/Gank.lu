//
//  GirlCell.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/1/6.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit

struct GirlFlow {
    let avatar:String
    let image:String
    let nickName:String
    let userName:String
    let content:String
    let created_at:String
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
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
