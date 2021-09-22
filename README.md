# XYPaginat

一个简单的Swift版分页组件

1、初始化组件
let thisView = XYPaginationView(frame: self.view.frame)
        view.addSubview(thisView)
        
        //设置
        thisView.myConfiger.TitleOffset = CGPoint(x: 0, y: -10)
        thisView.myConfiger.Titles = ["生活","推荐","视频","历史","头条","社会","世界"]
        thisView.myConfiger.TitleWidth = 100
        thisView.myConfiger.SpaceWidth = 0
        thisView.myConfiger.DefaultPageIndex = 0
    
        
        //代理
        thisView.delegate = self
        
        //farm
        thisView.titleView.frame = CGRect(x: 0, y: 200, width: thisView.frame.width, height: 50)
        thisView.pageView.frame = CGRect(x: 0, y: 250, width: thisView.frame.width, height: 300)
        
        //初始化创建方法
        thisView.CreatView()
        
2、设置创建子页的代理

       extension ViewController:SetPageViewCellDelegate
       {
          func SetPageView(index: Int, childView: UIView) {
          }
       }

3、Swift Package

https://github.com/caoqyxy/XYPaginat.git
