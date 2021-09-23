//
//  XYPaginationView.swift
//  XYPagination
//
//  Created by 1 on 2021/9/18.
//

import Foundation
import UIKit

public class XYPaginationView: UIView {
    
   public  var titleView:XYTitleView = XYTitleView()
   public  var pageView:XYPageView = XYPageView()
   public  var myConfiger:Configer = Configer.init( DefaultPageIndex: 0)
  public weak var delegate:SetPageViewCellDelegate!
    var isInit = false
    
//    /** 所有ChildView */
//    public var ChildView:[UIView] = []
    
    
  
    
   public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleView)
        self.addSubview(pageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
  public func CreatView() {
      
      if isInit {
          return
      }
       isInit = true
        myConfiger.NowSelectIndex = myConfiger.DefaultPageIndex
        titleView.delegate = self
        titleView.CreatTitleView(config: myConfiger)
    
        pageView.delegate = self
        pageView.CreatPageView(config: myConfiger )
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
