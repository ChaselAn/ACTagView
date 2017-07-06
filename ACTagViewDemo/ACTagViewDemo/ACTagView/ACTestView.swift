//
//  ACTestView.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/7/5.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

public protocol ACTestViewDataSource: NSObjectProtocol {
  
  func numberOfTags(in tagView: ACTestView) -> Int
  func tagView(_ tagView: ACTestView, tagForIndexAt index: Int) -> ACTag
  
}

@objc public protocol ACTestViewDelegate: NSObjectProtocol {
  
  @objc optional func tagView(_ tagView: ACTestView, didSelectTagAt index: Int)
  
}

open class ACTestView: UIScrollView {

  open weak var dataSource: ACTestViewDataSource?
  // tag的外边距，width代表距左右的边距，height代表距上下的边距
  open var tagMarginSize: CGSize = ACTagManager.shared.tagMarginSize
  open var tagHeight: CGFloat = ACTagManager.shared.tagDefaultHeight
  
  open func reloadData() {
    
    layoutTags()
    
  }
  
  public override init(frame: CGRect) {
    
    super.init(frame: frame)
    setupUI()
    
  }
  
  public required init?(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)
    setupUI()
    
  }
  
  open override func didMoveToWindow() {
    super.didMoveToWindow()
    reloadData()
  }
  
  private func setupUI() {
    
    if bounds.width == 0 {
      frame.size.width = ACScreenWidth
    }
    showsVerticalScrollIndicator = true
    showsHorizontalScrollIndicator = false
    
  }
  
  private func layoutTags() {
    
    subviews.forEach({ ($0 as? ACTag)?.removeFromSuperview() })
    guard let dataSource = dataSource else { return }
    
    var offsetX = tagMarginSize.width
    var offsetY = tagMarginSize.height
    
    for i in 0 ..< dataSource.numberOfTags(in: self) {
      
      let tag = dataSource.tagView(self, tagForIndexAt: i)
      tag.setWidth(withHeight: tagHeight)
      var tempFrame = tag.frame
      
      if (offsetX + tempFrame.width + tagMarginSize.width) <= bounds.width {
        tempFrame.origin.x = offsetX
        tempFrame.origin.y = offsetY
        offsetX += tempFrame.width + tagMarginSize.width
      } else if i != 0 {
        offsetX = tagMarginSize.width
        offsetY += tagHeight + tagMarginSize.height
        tempFrame.origin.x = offsetX
        tempFrame.origin.y = offsetY
        offsetX += tempFrame.width + tagMarginSize.width
      } else {
        offsetX = tagMarginSize.width
        tempFrame.origin.x = offsetX
        tempFrame.origin.y = offsetY
        offsetX += tempFrame.width + tagMarginSize.width
      }
      tempFrame.size.height = tagHeight
      tag.frame = tempFrame
      addSubview(tag)
    }
    
//    let oldContentHeight = contentSize.height
    contentSize = CGSize(width: bounds.width, height: offsetY + tagHeight + tagMarginSize.height)
    
//    if isScrollToLast {
//      if oldContentHeight != contentSize.height && oldContentHeight != 0 {
//        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.height)
//        setContentOffset(bottomOffset, animated: true)
//      }
//    }
    
    if bounds.height == 0 {
      frame.size.height = contentSize.height
    }
    
  }


}
