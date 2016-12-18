//
//  NextViewController.swift
//  Gank.lu
//
//  Created by FIND.ME on 16/1/6.
//  Copyright © 2016年 smartalker. All rights reserved.
//

import UIKit
import SwiftyJSON
import MBProgressHUD
import SafariServices

class GankViewController: UIViewController ,GankHttpDelegate{

    @IBOutlet weak var tableView: UITableView!
    var topImageHeight:CGFloat = 220
    var girl:GirlFlow?
    var topImageView:UIImageView!
    var gankData:[Gank] = []
    var hud:MBProgressHUD?
    let gankCell = "gankCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        initGankHttp()
    }
    
    @IBAction func refreshGank(_ sender: AnyObject) {
        showProgress()
        let date = DateUtil.stringToDate((girl?.publishedAt)!)
        let components = DateUtil.componentsFromDate(date)
        GankHttp.shareInstance.fetchGankDataAtYear(components.year!, month: components.month!, day: components.day!)
    }
    func initTableView(){
        topImageHeight = self.view.bounds.width * 0.65
        topImageView = UIImageView(frame: CGRect(x: 0, y: -topImageHeight, width: self.view.bounds.width, height: topImageHeight))
        topImageView.kf.setImage(with: (URL(string: (girl?.url)!)!))
        topImageView.contentMode = .scaleAspectFill
        topImageView.clipsToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(topImageHeight, 0, 30, 0)
        tableView.addSubview(topImageView)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 180
        let date = DateUtil.stringToDate((girl?.publishedAt)!)
        self.navigationItem.title = DateUtil.dateToString(date, dateFormat: "yyyy/MM/dd")
    }
    
    func initGankHttp(){
        let date = DateUtil.stringToDate((girl?.publishedAt)!)
        let components = DateUtil.componentsFromDate(date)
        GankHttp.shareInstance.delegate = self
        GankHttp.shareInstance.fetchGankDataAtYear(components.year!, month: components.month!, day: components.day!)
        showProgress()
    }
    func showProgress(){
        hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud!.labelText = "loading..."
        hud!.dimBackground = true
    }
    func gankDataReceived(_ json: AnyObject) {
        debugPrint(json)
        hud?.hide(true)
        let resultJosn = JSON(json)
        refreshData(resultJosn)
    }

    func refreshData(_ json:JSON){
        gankData.removeAll()
        let categorys = json["category"].array
        let result = json["results"]
        for category in categorys!{
            if category.stringValue == "福利"{
                continue
            }
            let ganks = result[category.stringValue].array
            for gank in ganks!{
                gankData.append(Gank(item: gank))
            }
        }
        tableView.reloadData()
        
    }
    
    func gankFetchFailed() {
        hud?.hide(true)
        ToastUtil.showTextToast(self.view,toastStr: "数据加载失败...")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension GankViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gankData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: gankCell,for:indexPath) as! GankCell
        cell.setGankViews(gankData[(indexPath as NSIndexPath).row])
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gankUrl = gankData[(indexPath as NSIndexPath).row].url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlFragmentAllowed)!
        print(gankUrl)
        let SFSafari = SFSafariViewController(url: URL(string:gankUrl)!, entersReaderIfAvailable: true)
        self.present(SFSafari, animated: true, completion: nil)
    }
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < -topImageHeight{
            topImageView.frame.origin.y = offsetY
            topImageView.frame.size.height = -offsetY
        }
        
    }
    
}
