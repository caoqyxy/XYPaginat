//
//  configer.swift
//  XYPagination
//
//  Created by 1 on 2021/9/18.
//

import Foundation
import UIKit

public struct Configer {
    
    /** 所有标题 */
    public var Titles:[String] = []
    
    /** 标题栏格子的宽度 */
    public var TitleWidth:CGFloat = 100
    
    /** 标题栏格子间距的宽度 */
    public var SpaceWidth :CGFloat = 0
    
    /** 标题栏字体样式——normal */
    public var TitleNormalFont = UIFont.systemFont(ofSize: 20)
    
    /** 标题栏字体颜色 ——normal */
    public var TitleNormalColor = UIColor.black
    
    /** 标题栏字体样式——selected*/
    public var TitleSelectedFont = UIFont.boldSystemFont(ofSize: 25)
    
    /** 标题栏字体颜色 ——selected */
    public var TitleSelectedColor = UIColor.orange
    
    
    /** Line 大小 */
    public var LineSize = CGSize(width: 60 , height: 5)
    
    /** Line偏移*/
    public var LineOffset = CGPoint(x: 0,y: 20)
    
    /** Line颜色*/
    public var LineColor = UIColor.orange
    
    /** Line圆角*/
    public var LineRadius :CGFloat = 3
    
    public var LineModulus: CGFloat = 0.8
    
    
    
    /** 字体大小是否变化 */
    internal var IsTitleSizeChange:Bool{
        get {
            if TitleNormalFont.pointSize == TitleSelectedFont.pointSize {
                return false
            }else {
                
                return true
            }
        }
    }
    
    /** 字体颜色是否变化 */
    internal var IsTitleColorChange:Bool{
        get {
            if TitleNormalColor == TitleSelectedColor {
                return false
            }else {
                return true
            }
        }
    }
    
    /** 字体偏移是否变化 */
    public var TitleOffset:CGPoint = CGPoint.zero
    
    /** 现在选择Index */
    internal var NowSelectIndex:Int = 0
    
    public var DefaultPageIndex: Int{
        didSet {
            if self.DefaultPageIndex > Titles.count{
                self.DefaultPageIndex = Titles.count - 1
            }
        }
    }
    
    
    
    
    
    
    
    
}
