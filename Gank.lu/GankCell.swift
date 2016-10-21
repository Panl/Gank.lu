//
//  GankCell.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/18.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import SwiftyJSON

class GankCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setGankViews(_ gank:Gank){
        typeLabel.text = gank.type
        descLabel.text = gank.desc
    }
    
}
