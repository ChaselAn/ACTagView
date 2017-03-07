//
//  ACTagView.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/3/6.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

public protocol ACTagViewDelegate: NSObjectProtocol {
  
  func tagView(_ tagView: ACTagView, didClickedTagAt index: Int, tagStr: String, tagState: ACTagView.TagBtnState)
  
}

extension ACTagViewDelegate {
  
  public func tagView(_ tagView: ACTagView, didClickedTagAt index: Int, tagStr: String, tagState: ACTagView.TagBtnState) {
    return
  }
  
}
public class ACTagView: UIScrollView {
  
  public enum TagBtnState {
    case turnOn
    case turnOff
  }
  
  // 设置以下属性需要在addTags方法前设置
  public var tagHeight: CGFloat = 30
  // tag的外边距，width代表距左右的边距，height代表距上下的边距
  public var tagMarginSize: CGSize = CGSize(width: 10, height: 10)
  // tag的内边距
  public var tagPaddingSize: CGSize = CGSize(width: 0, height: 0)
  // 输入标签的字体大小
  public var tagFontSize: CGFloat = 14
  
  public var selectedTagBgColor = UIColor.clear
  public var selectedTagBorderColor = UIColor.green
  public var selectedTagTextColor = UIColor.green
  public var normalTagBgColor = UIColor.clear
  public var normalTagBorderColor = UIColor.lightGray
  public var normalTagTextColor = UIColor.black
  
  public weak var tagDelegate: ACTagViewDelegate?
  
  
  private var tagBtns: [ACTagButton] = []
  private(set) var tagStrs: [String] = []
  private(set) var selectedTagStrs: [String] = []
  
  public func addTags(_ tags: [String]) {
    
    tags.forEach({ addTagToLast($0) })
    layoutTags()
    
  }
  
  public func addTag(_ tag: String) {
    
    addTagToLast(tag)
    layoutTags()
    
  }
  
  public func clickTag(_ tag: String) {
    
    if let index = tagStrs.index(of: tag) {
      
      if !tagBtns[index].isSelected && !selectedTagStrs.contains(tag) {
        selectedTagStrs.append(tag)
      }else if tagBtns[index].isSelected && selectedTagStrs.contains(tag) {
        selectedTagStrs.remove(at: selectedTagStrs.index(of: tag)!)
      }
      tagBtns[index].isSelected = !tagBtns[index].isSelected
    }
    
  }
  
  public func setDefaultSelectedTags(_ deFaultTagStrs: [String]) {
    
    for tagStr in deFaultTagStrs {
      if !selectedTagStrs.contains(tagStr) && tagStrs.contains(tagStr) {
        selectedTagStrs.append(tagStr)
        let index = tagStrs.index(of: tagStr)
        tagBtns[index!].isSelected = true
      }
    }
    
  }
  
  public func setDefaultSelectedTagsIndex(_ defaultIndex: [Int]) {
    
    for index in defaultIndex {
      if index >= tagBtns.count || index >= tagStrs.count { continue }
      selectedTagStrs.append(tagStrs[index])
      tagBtns[index].isSelected = true
    }
    
  }
  
  public override init(frame: CGRect) {
    
    super.init(frame: frame)
    setupUI()
    
  }
  
  public required init?(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)
    setupUI()
    
  }
  
  private func setupUI() {
    
    if bounds.width == 0 {
      frame.size.width = ACScreenWidth
    }
    showsVerticalScrollIndicator = true
    showsHorizontalScrollIndicator = false
    
  }

  
  private func addTagToLast(_ tag: String) {
    
    if !tagStrs.contains(tag) {
      tagStrs.append(tag)
      
      let tagBtn = createTagBtn(with: tag)
      addSubview(tagBtn)
      tagBtns.append(tagBtn)
      
    }
    
  }

  private func layoutTags() {
    
    var offsetX = tagMarginSize.width
    var offsetY = tagMarginSize.height
    
    for (i, tagBtn) in tagBtns.enumerated() {
      var tempFrame = tagBtn.frame
      if (offsetX + tempFrame.width + tagMarginSize.width) <= bounds.width {
        tempFrame.origin.x = offsetX
        tempFrame.origin.y = offsetY
        offsetX += tempFrame.width + tagMarginSize.width
      }else if i != 0 {
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
      tagBtn.frame = tempFrame
    }

    
    let oldContentHeight = contentSize.height
    contentSize = CGSize(width: bounds.width, height: offsetY + tagHeight + tagMarginSize.height)
    
    if oldContentHeight != contentSize.height && oldContentHeight != 0 {
      let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.height)
      setContentOffset(bottomOffset, animated: true)
    }
    
    if bounds.height == 0 {
      frame.size.height = contentSize.height
    }
    
  }
  
  private func createTagBtn(with tag: String) -> ACTagButton {
    
    let tagBtn = ACTagButton()
    tagBtn.normalTextColor = normalTagTextColor
    tagBtn.normalBgColor = normalTagBgColor
    tagBtn.normalBorderColor = normalTagBorderColor
    
    tagBtn.selectedBgColor = selectedTagBgColor
    tagBtn.selectedTextColor = selectedTagTextColor
    tagBtn.selectedBorderColor = selectedTagBorderColor
    
    tagBtn.isSelected = false
    tagBtn.titleLabel?.font = UIFont.systemFont(ofSize: tagFontSize)
    tagBtn.addTarget(self, action: #selector(clickTagBtn), for: .touchUpInside)
    tagBtn.setTitle(tag, for: .normal)
    tagBtn.setTitle(tag, for: .selected)
    tagBtn.frame = CGRect(x: 0, y: 0, width: tag.ac_getWidth(tagFontSize) + tagHeight + 2 * tagPaddingSize.width, height: tagHeight)
    tagBtn.layer.cornerRadius = tagBtn.frame.height / 2
    
    return tagBtn
    
  }
  
  @objc private func clickTagBtn(sender: ACTagButton) {
    
    guard let tagStr = sender.title(for: .normal) else { return }
    if !sender.isSelected && !selectedTagStrs.contains(tagStr) {
      selectedTagStrs.append(tagStr)
    }else if sender.isSelected && selectedTagStrs.contains(tagStr) {
      selectedTagStrs.remove(at: selectedTagStrs.index(of: tagStr)!)
    }
    sender.isSelected = !sender.isSelected
    guard let index = tagStrs.index(of: tagStr) else { return }
    tagDelegate?.tagView(self, didClickedTagAt: index, tagStr: tagStr, tagState: sender.isSelected ? .turnOn : .turnOff)
  }

}
