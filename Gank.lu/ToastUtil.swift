//
//  ToastUtil.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/2/18.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import Foundation
import MBProgressHUD

class ToastUtil {
    static func showTextToast(_ view:UIView,toastStr:String){
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
      hud.mode = MBProgressHUDMode.text
    }
}
