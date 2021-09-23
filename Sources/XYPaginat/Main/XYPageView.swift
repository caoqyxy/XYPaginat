//
//  XYPageView.swift
//  XYPagination
//
//  Created by 1 on 2021/9/18.
//

import Foundation
import UIKit

public class XYPageView: UIView {
    
    var AllPages:[UIView] = []
    var pageScrollView:UIScrollView!
    var thisConfiger:Configer!
    weak var delegate:PageViewDelegate!
    var PageInitBools:[Bool] = []
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    func CreatPageView(config: Configer) {
        if(config.Titles.count>0){
            thisConfiger = config
            self.layoutIfNeeded()
            pageScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            
            pageScrollView.showsHorizontalScrollIndicator = false
            pageScrollView.bounces = false
            pageScrollView.isDirectionalLockEnabled = true
            pageScrollView.isPagingEnabled = true;
            pageScrollView.delegate = self
            let count = CGFloat(config.Titles.count)
            let AllWidth = count * self.frame.width
            self.addSubview(pageScrollView)

            
            pageScrollView.contentSize = CGSize(width: AllWidth, height: pageScrollView.frame.height)
            for i in 0..<config.Titles.count{
                let uiv = UIView(frame: CGRect(x: CGFloat(i) * self.frame.width, y: 0, width: self.frame.width, height: self.frame.height))
                uiv.backgroundColor = UIColor.white
                pageScrollView.addSubview(uiv)
                AllPages.append(uiv)
                PageInitBools.append(false)
            }
            DefaultValue(index: config.DefaultPageIndex)
        }
    }
    
    func DefaultValue(index:Int)  {
        pageScrollView.contentOffset = CGPoint( x: CGFloat(index) * self.frame.width , y: 0)
        InitView(index: index)
    }
    
    func SetPageValue(index:Int) {
        UIView.animate(withDuration: 0.3) { [self] in
           pageScrollView.contentOffset = CGPoint( x: CGFloat(index) * self.frame.width , y: 0)
                 }
    }
    
    func InitView(index:Int){
        if PageInitBools[index]{
            return
        }else{
            PageInitBools[index] = true
            delegate.SetView(index: index, childView: AllPages[index])
        }
    }
}

extension XYPageView:UIScrollViewDelegate{
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round((scrollView.contentOffset.x)/scrollView.frame.size.width)
        delegate.MovePage(pageIndex: Int(page))
        InitView(index: Int(page))
        }
}

protocol PageViewDelegate:NSObjectProtocol {
    func MovePage(pageIndex:Int)
    func SetView(index: Int, childView:UIView)
}

extension UIColor {
    //返回随机颜色
    open class var randomColor:UIColor{
        get
        {
            let red = CGFloat(arc4random()%256)/255.0
            let green = CGFloat(arc4random()%256)/255.0
            let blue = CGFloat(arc4random()%256)/255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
