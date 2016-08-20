# Gank.lu
[English](README-EN.md)
>**gank.io iOS客户端**  
>本项目用于记录iOS开发的学习过程。跟着[Kevin](https://github.com/kevinzhow)大神的视频学习。  
>[给女朋友的iOS开发教程](http://www.bilibili.com/video/av2953140/)

- Android版本的客户端请移步[Gank.io](https://github.com/Panl/Gank.io)
- 作者的学习经历已经写成了一篇文章 [一个android程序猿的iOS学习之路](https://panl.github.io/2016/03/02/android-to-ios/)

![](screenshots/appIcon.png)

#### 项目截图
![](screenshots/gank_ios_1.png)
![](screenshots/gank_ios_2.png)
![](screenshots/gank_ios_3.png)
![](screenshots/gank_ios_4.png)
![](screenshots/gank_ios_5.png)
![](screenshots/gank_ios_6.png)

##### 前期准备
- Swift 2.1基本语法
- Xcode 的基本操作
- iOS 开发的基本流程


##### 第一阶段
- UITableView，NavigationController，MainStoryBoard的使用（2016.1.3）
- 自定义UITableViewCell（2016.1.7）
- 安装CocoaPods(坑爹啊，感觉能不能安装好完全看人品啊，各种出错，也可能是阿里的镜像网站大姨妈了)，学会CocoaPods的简单使用，配置好[Alamofire](https://github.com/Alamofire/Alamofire)[一个用Swift编写的网络请求库]（2016.1.9）  
- 使用[SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)解析数据，[Kingfisher](https://github.com/onevcat/Kingfisher)展示图片(2016.2.3)

##### 第二阶段
- 使用swift调用[MJRefresh](https://github.com/CoderMJLee/MJRefresh)库实现下拉刷新和上拉加载更多(2016.2.15)  
- 使用swift调用[MBProgressHUD](https://github.com/jdg/MBProgressHUD)库实现网络耗时操作的提示视图(2016.2.18)
- 使用 **SFSafariViewController** 显示网页(2016.2.19)

##### 第三阶段
- 使用[AFDateHelper](https://github.com/melvitax/AFDateHelper)进行日期处理(2016.2.26)
- 使用[PagingMenuController](https://github.com/kitasuke/PagingMenuController)实现类似Android上面ViewPager的效果，实现分类浏览干货功能(2016.2.26)
- 使用UIScrollView和UIImageView相结合实现了图片的缩放效果(2016.2.26)

当然还有一些细节问题，花费了很多时间，作为学习swift以及iOS开发的练手项目，到此就基本完成了，由于是新手，项目中难免有许多纰漏，欢迎批评指正。

**当然这个项目会一直维护的，为了进一步学习，将来会添加各种炫酷的动画效果，敬请期待。。。**

---------
##### 2.28日更新
- 去掉无用代码
- 添加.ignore文件忽略Pods文件夹

##### TODO
- post gank


##### 贡献者
- [DianQK](https://github.com/DianQK)

##### 注意
由于我集成了 Firebase ，Google 的 App 分析工具，所以会有文件没有放在版本控制力，在 Podfile 里删除 ```
Pod 'Firebase'
``` 即可。


### LICENSE
Gank.lu is released under the GPL v3 license. See [LICENSE](LICENSE) for details.
