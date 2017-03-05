//
//  ACTagView.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/3/5.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

protocol ACTagViewDelegate: NSObjectProtocol {
  
  func tagView(_ tagView: ACTagView, didClickedTagAt index: Int, tagStr: String, tagState: ACTagView.TagBtnState)
  
}

extension ACTagViewDelegate {
  
  func tagView(_ tagView: ACTagView, didClickedTagAt index: Int, tagStr: String, tagState: ACTagView.TagBtnState) {
    return
  }
  
}
class ACTagView: UIScrollView {
  
  enum TagViewType {
    case normal
    case haveInputTag
  }
  
  enum InputTagBorderState {
    case none
    case circleWithFullLine(color: UIColor)
    case circleWithDashLine(color: UIColor, lineDashPattern: [NSNumber])
  }
  
  enum TagBtnState {
    case turnOn
    case turnOff
  }
  
  // 设置以下属性需要在addTags方法前设置
  var tagHeight: CGFloat = 30
  // tag的外边距，width代表距左右的边距，height代表距上下的边距
  var tagMarginSize: CGSize = CGSize(width: 10, height: 10)
  // tag的内边距
  var tagPaddingSize: CGSize = CGSize(width: 0, height: 0)
  // 输入标签的字体大小
  var tagFontSize: CGFloat = 14
  
  var selectedTagBgColor = UIColor.clear
  var selectedTagBorderColor = UIColor.green
  var selectedTagTextColor = UIColor.green
  var normalTagBgColor = UIColor.clear
  var normalTagBorderColor = UIColor.lightGray
  var normalTagTextColor = UIColor.black
  
  weak var tagDelegate: ACTagViewDelegate?
  var tagViewType: TagViewType = .normal
  
  // 当type为haveInputTag时才会用到下面的属性
  var inputTagPlaceholder = "输入标签"
  var inputTagFontSize: CGFloat = 14
  var inputTagBgColor = UIColor.clear
  var inputTagTextColor = UIColor.black
  var inputTagPlaceholderColor = UIColor.lightGray
  var inputTagBorderState = InputTagBorderState.circleWithDashLine(color: UIColor.lightGray, lineDashPattern: [3, 3])
  
  private var tagBtns: [ACTagButton] = []
  private(set) var tagStrs: [String] = []
  private(set) var selectedTagStrs: [String] = []
  
  private var inputTagTextField: ACTagTextField?
  
  
  func addTags(_ tags: [String]) {
    
    tags.forEach({ addTagToLast($0) })
    layoutTags()
    if tagViewType == .haveInputTag {
      setDefaultSelectedTags(tags)
    }
    
  }
  
  func addTag(_ tag: String) {
    
    addTagToLast(tag)
    layoutTags()
    if tagViewType == .haveInputTag {
      setDefaultSelectedTags([tag])
    }
    
  }
  
  func removeTag(_ tag: String) {
    
    if tagViewType == .haveInputTag {
      if let index = tagStrs.index(of: tag) {
        tagStrs.remove(at: index)
        tagBtns[index].removeFromSuperview()
        tagBtns.remove(at: index)
      }
      if let i = selectedTagStrs.index(of: tag) {
        selectedTagStrs.remove(at: i)
      }
      layoutTags()
    }
    
  }
  
  func removeTag(by index: Int) {
    
    if tagViewType == .haveInputTag {
      if index >= tagStrs.count || index >= tagBtns.count { return }
      let tagStr = tagStrs[index]
      tagStrs.remove(at: index)
      tagBtns[index].removeFromSuperview()
      tagBtns.remove(at: index)
      if let i = selectedTagStrs.index(of: tagStr) {
        selectedTagStrs.remove(at: i)
      }
      layoutTags()
    }
    
  }
  
  func clickTag(_ tag: String) {
    
    if let index = tagStrs.index(of: tag) {
      
      if !tagBtns[index].isSelected && !selectedTagStrs.contains(tag) {
        selectedTagStrs.append(tag)
      }else if tagBtns[index].isSelected && selectedTagStrs.contains(tag) {
        selectedTagStrs.remove(at: selectedTagStrs.index(of: tag)!)
      }
      tagBtns[index].isSelected = !tagBtns[index].isSelected
    }
    
  }
  
  func setDefaultSelectedTags(_ deFaultTagStrs: [String]) {
    
    for tagStr in deFaultTagStrs {
      if !selectedTagStrs.contains(tagStr) && tagStrs.contains(tagStr) {
        selectedTagStrs.append(tagStr)
        let index = tagStrs.index(of: tagStr)
        tagBtns[index!].isSelected = true
      }
    }
    
  }
  
  func setDefaultSelectedTagsIndex(_ defaultIndex: [Int]) {
    
    for index in defaultIndex {
      if index >= tagBtns.count || index >= tagStrs.count { continue }
      selectedTagStrs.append(tagStrs[index])
      tagBtns[index].isSelected = true
    }
    
  }
  
  init(type: TagViewType, frame: CGRect = CGRect.zero) {
    
    super.init(frame: frame)
    self.frame = frame
    tagViewType = type
    setupUI()
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    
    super.init(coder: aDecoder)
    setupUI()
    
  }
  
  private func setupUI() {
    
    if bounds.width == 0 {
      frame.size.width = ACScreenWidth
    }
    showsVerticalScrollIndicator = true
    showsHorizontalScrollIndicator = false
    clipsToBounds = true
    
    if tagViewType == .haveInputTag {
      inputTagTextField = ACTagTextField()
      guard let inputTagTextField = inputTagTextField else { return }
      addSubview(inputTagTextField)
      inputTagTextField.frame = CGRect(x: 0, y: 0, width: inputTagPlaceholder.ac_getWidth(inputTagFontSize), height: tagHeight)
      //    inputTagTextField.addTarget(self, action: #selector(textFieldDidFinishChange), for: .editingChanged)
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
    
    if tagViewType == .haveInputTag {
      setupTextField()
      guard let inputTagTextField = inputTagTextField else { return }
      
      var tempFrame = inputTagTextField.frame
      let textStr = inputTagTextField.text ?? inputTagPlaceholder
      tempFrame.size.width = (textStr.isEmpty ? inputTagPlaceholder : textStr).ac_getWidth(inputTagFontSize) + inputTagTextField.bounds.height + tagPaddingSize.width * 2
      
      if (offsetX + tempFrame.width + tagMarginSize.width) <= bounds.width {
        tempFrame.origin.x = offsetX
        tempFrame.origin.y = offsetY
      } else if tagBtns.count > 0 {
        offsetX = tagMarginSize.width
        offsetY += tagHeight + tagMarginSize.height
        tempFrame.origin.x = offsetX
        tempFrame.origin.y = offsetY
      } else {
        offsetX = tagMarginSize.width
        tempFrame.origin.x = offsetX
        tempFrame.origin.y = offsetY
      }
      inputTagTextField.frame = tempFrame
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
  
  private func addTagToLast(_ tag: String) {
    
    if !tagStrs.contains(tag) {
      tagStrs.append(tag)
      
      let tagBtn = createTagBtn(with: tag)
      addSubview(tagBtn)
      tagBtns.append(tagBtn)
      
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
  
  private func setupTextField() {
    
    guard let inputTagTextField = inputTagTextField else { return }
    
    inputTagTextField.returnKeyType = .done
    inputTagTextField.placeholder = inputTagPlaceholder
    inputTagTextField.font = UIFont.systemFont(ofSize: inputTagFontSize)
    inputTagTextField.backgroundColor = inputTagBgColor
    inputTagTextField.textColor = inputTagTextColor
    
    let placeholderStr = inputTagPlaceholder
    let attr = NSMutableAttributedString(string: placeholderStr)
    attr.addAttributes([NSForegroundColorAttributeName: inputTagPlaceholderColor], range: NSRange(location: 0, length: placeholderStr.characters.count))
    inputTagTextField.attributedPlaceholder = attr
    inputTagTextField.paddingSize = tagPaddingSize
    switch inputTagBorderState {
    case .none:
      inputTagTextField.borderStyle = .none
    case .circleWithFullLine(color: let color):
      inputTagTextField.layer.borderWidth = 1
      inputTagTextField.layer.borderColor = color.cgColor
      inputTagTextField.layer.cornerRadius = inputTagTextField.frame.height * 0.5
    case .circleWithDashLine(color: let color, lineDashPattern: let lineDashPattern):
      inputTagTextField.borderStyle = .none
      let borderLayer = CAShapeLayer()
      borderLayer.frame = CGRect(x: 0, y: 0, width: inputTagTextField.bounds.width + inputTagTextField.bounds.height + tagPaddingSize.width * 2, height: inputTagTextField.bounds.height)
      borderLayer.lineDashPattern = lineDashPattern
      borderLayer.path = UIBezierPath(roundedRect: borderLayer.bounds, cornerRadius:borderLayer.bounds.width / 2).cgPath
      borderLayer.fillColor = UIColor.clear.cgColor
      borderLayer.strokeColor = color.cgColor
      inputTagTextField.layer.addSublayer(borderLayer)
    }
    
  }
  
}
