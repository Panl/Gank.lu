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
    static func showTextToast(view:UIView,toastStr:String){
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        hud.mode = MBProgressHUDMode.Text
        hud.labelText = toastStr
        hud.hide(true, afterDelay: 2.0)
    }
}