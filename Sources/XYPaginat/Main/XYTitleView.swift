//
//  XYTitleView.swift
//  XYPagination
//
//  Created by 1 on 2021/9/18.
//

import Foundation
import UIKit

public class XYTitleView: UIView {
    
    var AllBtns:[UIButton] = []
    var thisConfiger:Configer!
    var titleScrollView:UIScrollView!
    var LineView:UIView = UIView()
    
    weak var delegate:TitleViewDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func CreatTitleView(config: Configer) {
       
        if(config.Titles.count>0){
            thisConfiger = config
            self.layoutIfNeeded()
            titleScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
            titleScrollView.showsHorizontalScrollIndicator = false
            titleScrollView.bounces = false
            titleScrollView.isDirectionalLockEnabled = true
            let count = CGFloat(config.Titles.count)
            let AllWidth = count * config.TitleWidth + (count - 1) * config.SpaceWidth
            self.addSubview(titleScrollView)
            titleScrollView.contentSize = CGSize(width: AllWidth, height: titleScrollView.frame.height)
            for i in 0..<config.Titles.count{
                let posX = CGFloat(i) * (config.SpaceWidth + config.TitleWidth)
                let posY = CGFloat(0)
                let cellBtn = UIButton(frame: CGRect(x: posX, y: posY, width: config.TitleWidth, height: titleScrollView.frame.height))
                cellBtn.titleLabel?.font = config.TitleNormalFont
                cellBtn.setTitleColor(config.TitleNormalColor, for: .normal)
                cellBtn.setTitle(config.Titles[i], for: .normal)
                cellBtn.backgroundColor = #colorLiteral(red: 0.9037246704, green: 0.9037246704, blue: 0.9037246704, alpha: 1)
                cellBtn.titleLabel?.textAlignment = .center
                cellBtn.titleEdgeInsets = UIEdgeInsets(top: config.TitleOffset.y, left: config.TitleOffset.x, bottom: 0, right: 0)
                titleScrollView.addSubview(cellBtn)
                cellBtn.tag = i
                cellBtn.addTarget(self, action: #selector(TapTitleBtnCell(button:)), for: .touchUpInside)
                AllBtns.append(cellBtn)
                SetState(index: 0)
                
            }
            LineView.frame.size = CGSize( width: config.LineSize.width, height: config.LineSize.height)
            DefualtTitleAutoMid(index: config.DefaultPageIndex)
            SetState(index: config.DefaultPageIndex)
            LineView.backgroundColor = config.LineColor
            LineView.layer.cornerRadius = config.LineRadius
            titleScrollView.addSubview(LineView)

        }else{
            print("设置分页栏titles")
        }
    }
    
    func DefualtTitleAutoMid(index:Int) {
        let AllWidth = titleScrollView.contentSize.width - titleScrollView.frame.width
        var MidPos = CGFloat(index) * (thisConfiger.SpaceWidth + thisConfiger.TitleWidth) + thisConfiger.TitleWidth/2 - titleScrollView.frame.width/2
        if(MidPos < 0 ){
            MidPos = 0
        }else{
            if(MidPos > AllWidth){
                MidPos = AllWidth
            }
        }
        titleScrollView.contentOffset = CGPoint( x: MidPos , y: 0)
        LineView.center = CGPoint(x: AllBtns[index].center.x + thisConfiger.LineOffset.x, y: AllBtns[index].center.y + thisConfiger.LineOffset.y)
    }
    
    func SetTitleAutoMid(index:Int) {
        
        let AllWidth = titleScrollView.contentSize.width - titleScrollView.frame.width
        var MidPos = CGFloat(index) * (thisConfiger.SpaceWidth + thisConfiger.TitleWidth) + thisConfiger.TitleWidth/2 - titleScrollView.frame.width/2
        if(MidPos < 0 ){
            MidPos = 0
        }else{
            if(MidPos > AllWidth){
                MidPos = AllWidth
            }
        }
        
        UIView.animate(withDuration: 0.3) { [self] in
            titleScrollView.contentOffset = CGPoint( x: MidPos , y: 0)
            LineView.center = CGPoint(x: AllBtns[index].center.x + thisConfiger.LineOffset.x, y: AllBtns[index].center.y + thisConfiger.LineOffset.y)
      }
   }
    
    func LineAnim(index:Int){
        UIView.animate(withDuration: 0.3) { [self] in
            LineView.center = CGPoint(x: AllBtns[index].center.x + thisConfiger.LineOffset.x, y: AllBtns[index].center.y + thisConfiger.LineOffset.y)
      }
    }
    
    func SetState(index:Int) {
        for i in 0..<AllBtns.count{
            if i == index{
                AllBtns[i].titleLabel!.font = thisConfiger.TitleSelectedFont
                AllBtns[i].setTitleColor(thisConfiger?.TitleSelectedColor, for: .normal)
            }else{
                AllBtns[i].titleLabel!.font = thisConfiger.TitleNormalFont
                AllBtns[i].setTitleColor(thisConfiger?.TitleNormalColor, for: .normal)
            }
        }
    }
    
    @objc func TapTitleBtnCell(button : UIButton){
        delegate.ClickTitleBtn(button: button)
        LineAnim(index: button.tag)
    }
}

protocol TitleViewDelegate:NSObjectProtocol {
    func ClickTitleBtn(button:UIButton)
}
