//
//  BeautyCell.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/25.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit

class BeautyCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var beautyImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
