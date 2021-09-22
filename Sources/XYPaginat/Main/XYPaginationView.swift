//
//  XYPaginationView.swift
//  XYPagination
//
//  Created by 1 on 2021/9/18.
//

import Foundation
import UIKit

public class XYPaginationView: UIView {
    
   public var titleView:XYTitleView = XYTitleView()
   public var pageView:XYPageView = XYPageView()
   public  var myConfiger:Configer = Configer.init( DefaultPageIndex: 0)
  public weak var delegate:SetPageViewCellDelegate!
    
//    /** 所有ChildView */
//    public var ChildView:[UIView] = []
    
    
  
    
   public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  public func CreatView() {
        myConfiger.NowSelectIndex = myConfiger.DefaultPageIndex
        //titleView = XYTitleView(frame: CGRect(x: 0, y: 200, width: self.frame.width, height: 50))
        titleView.delegate = self
        titleView.CreatTitleView(config: myConfiger)
        self.addSubview(titleView)
        
        
        //pageView = XYPageView(frame: CGRect(x: 0, y: 250, width: self.frame.width, height: 300))
        pageView.delegate = self
        pageView.CreatPageView(config: myConfiger )
        self.addSubview(pageView)
        
        
    }
}

extension XYPaginationView :TitleViewDelegate,PageViewDelegate{
    func SetView(index: Int, childView: UIView) {
        delegate.SetPageView(index: index, childView: childView)
    }
    
    
    
    func MovePage(pageIndex: Int) {
        if(myConfiger.NowSelectIndex != pageIndex){
            myConfiger.NowSelectIndex = pageIndex
            titleView.SetState(index: pageIndex)
            titleView.SetTitleAutoMid(index: pageIndex)
        }
       
    }
    
    func ClickTitleBtn(button: UIButton) {
        let tag = button.tag
        if(tag == myConfiger.NowSelectIndex){
            return
        }else{
            myConfiger.NowSelectIndex = tag
            titleView.SetState(index: tag)
            pageView.SetPageValue(index: tag)
        }
    }
}

//代理
public protocol SetPageViewCellDelegate:NSObjectProtocol {
    func SetPageView(index: Int, childView: UIView)
}
