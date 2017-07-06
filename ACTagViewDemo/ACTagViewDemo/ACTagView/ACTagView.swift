//
//  ACTagView.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/7/5.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

public protocol ACTagViewDataSource: NSObjectProtocol {
  
  func numberOfTags(in tagView: ACTagView) -> Int
  func tagView(_ tagView: ACTagView, tagForIndexAt index: Int) -> ACTag
  
}

@objc public protocol ACTagViewDelegate: NSObjectProtocol {
  
  @objc optional func tagView(_ tagView: ACTagView, didClickTagAt index: Int, clickedTag tag: ACTag)
  
}

open class ACTagView: UIScrollView {

  open weak var dataSource: ACTagViewDataSource?
  open weak var tagDelegate: ACTagViewDelegate?
  
  /// tag的外边距，width代表距左右的边距，height代表距上下的边距
  open var tagMarginSize: CGSize = ACTagManager.shared.tagMarginSize
  
  /// tag高度
  open var tagHeight: CGFloat = ACTagManager.shared.tagDefaultHeight
  
  /// 是否自动换行，false表示只有一行，横向滑动，true表示纵向滑动
  open var autoLineFeed: Bool = ACTagManager.shared.autoLineFeed {
    didSet {
      showsVerticalScrollIndicator = autoLineFeed
      showsHorizontalScrollIndicator = !autoLineFeed
    }
  }
  
  // 能输入的标签
  open var inputTag: ACInputTag?
  
  open func reloadData() {
    
    layoutTags()
    
  }
  
  open func tagForIndex(at index: Int) -> ACTag? {
    if index < tagsList.count {
      return tagsList[index]
    }
    return nil
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
  
  open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    guard let position = touches.first?.location(in: self) else { return }
    guard let dataSource = dataSource else { return }
    guard let firstTag = tagsList.first, (position.x >= firstTag.frame.minX && position.y >= firstTag.frame.minY) else { return }
    guard let lastTag = tagsList.last, position.y <= lastTag.frame.maxY else { return }
    for i in 0 ..< dataSource.numberOfTags(in: self) {
      let tag = tagsList[i]
      if tag.frame.contains(position) {
        tagDelegate?.tagView?(self, didClickTagAt: i, clickedTag: tag)
        return
      }
    }
  }
  
  private var tagsList: [ACTag] = []
  
  private func setupUI() {
    
    if bounds.width == 0 {
      frame.size.width = ACScreenWidth
    }
    autoLineFeed = ACTagManager.shared.autoLineFeed
    clipsToBounds = true
  }
  
  private func layoutTags() {
    
    layoutIfNeeded()
    superview?.layoutIfNeeded()
    subviews.forEach({
      ($0 as? ACTag)?.removeFromSuperview()
      ($0 as? ACInputTag)?.removeFromSuperview()
    })
    tagsList = []
    guard let dataSource = dataSource else { return }
    
    if autoLineFeed {
      setTagFrameWhenAutoLineFeed(dataSource: dataSource)
    } else {
      setTagFrameWhenOneLine(dataSource: dataSource)
    }
    
//    let oldContentHeight = contentSize.height
    
    
//    if isScrollToLast {
//      if oldContentHeight != contentSize.height && oldContentHeight != 0 {
//        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.height)
//        setContentOffset(bottomOffset, animated: true)
//      }
//    }
    
  }

  private func setTagFrameWhenAutoLineFeed(dataSource: ACTagViewDataSource) {
    
    var offsetX = tagMarginSize.width
    var offsetY = tagMarginSize.height
    
    if let inputTag = inputTag, inputTag.position == .head {
      let textStr = (inputTag.text ?? inputTag.placeholder) ?? inputTag.defaultPlaceholder
      let width = textStr.ac_getWidth(inputTag.fontSize) + inputTag.bounds.height + inputTag.paddingSize.width * 2
      inputTag.frame = CGRect(x: offsetX, y: offsetY, width: width, height: tagHeight)
      offsetX += width + tagMarginSize.width
      addSubview(inputTag)
    }
    
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
      tagsList.append(tag)
    }
    
    if let inputTag = inputTag, inputTag.position == .tail {
      var tempFrame = inputTag.frame
      let textStr = (inputTag.text ?? inputTag.placeholder) ?? inputTag.defaultPlaceholder
      let textWidth = textStr.ac_getWidth(inputTag.fontSize)
      tempFrame.size.width = textWidth + inputTag.bounds.height + inputTag.paddingSize.width * 2
      
      if (offsetX + tempFrame.width + tagMarginSize.width) <= bounds.width {
        tempFrame.origin.x = offsetX
        tempFrame.origin.y = offsetY
      } else if tagsList.count > 0 {
        offsetX = tagMarginSize.width
        offsetY += tagHeight + tagMarginSize.height
        tempFrame.origin.x = offsetX
        tempFrame.origin.y = offsetY
      } else {
        offsetX = tagMarginSize.width
        tempFrame.origin.x = offsetX
        tempFrame.origin.y = offsetY
      }
      
      inputTag.frame = tempFrame
      addSubview(inputTag)
    }
    
    contentSize = CGSize(width: bounds.width, height: offsetY + tagHeight + tagMarginSize.height)
    
    if bounds.height == 0 {
      frame.size.height = contentSize.height
    }
  }
  
  private func setTagFrameWhenOneLine(dataSource: ACTagViewDataSource) {
    var offsetX = tagMarginSize.width
    let offsetY = tagMarginSize.height
    
    if let inputTag = inputTag, inputTag.position == .head {
      let textStr = (inputTag.text ?? inputTag.placeholder) ?? inputTag.defaultPlaceholder
      let width = textStr.ac_getWidth(inputTag.fontSize) + inputTag.bounds.height + inputTag.paddingSize.width * 2
      inputTag.frame = CGRect(x: offsetX, y: offsetY, width: width, height: tagHeight)
      offsetX += width + tagMarginSize.width
      addSubview(inputTag)
    }
    
    for i in 0 ..< dataSource.numberOfTags(in: self) {
      
      let tag = dataSource.tagView(self, tagForIndexAt: i)
      
      tag.setWidth(withHeight: tagHeight)
      tag.frame.origin.x = offsetX
      tag.frame.origin.y = offsetY
      tag.frame.size.height = tagHeight
      
      offsetX += tagMarginSize.width + tag.frame.width
      addSubview(tag)
      tagsList.append(tag)
      
    }
    
    if let inputTag = inputTag, inputTag.position == .tail {
      
      let textStr = (inputTag.text ?? inputTag.placeholder) ?? inputTag.defaultPlaceholder
      let textWidth = textStr.ac_getWidth(inputTag.fontSize)
      inputTag.frame = CGRect(x: offsetX, y: offsetY, width: textWidth, height: tagHeight)
      
      addSubview(inputTag)
    }
    
    contentSize = CGSize(width: offsetX, height: bounds.height)
    
    if bounds.height == 0 {
      frame.size.height = tagHeight + 2 * offsetY
    }
  }

}
