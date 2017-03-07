//
//  ACInputTagView.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/3/6.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

public protocol ACInputTagViewDelegate: NSObjectProtocol {
  
  func tagView(_ tagView: ACInputTagView, didClickedTagAt index: Int, tagStr: String)
  
  func tagView(_ tagView: ACInputTagView, didFinishInputTagStr tagStr: String)
}

extension ACInputTagViewDelegate {
  
  public func tagView(_ tagView: ACInputTagView, didClickedTagAt index: Int, tagStr: String) {
    return
  }
  
  public func tagView(_ tagView: ACInputTagView, didFinishInputTagStr tagStr: String) {
    return
  }
  
}
public class ACInputTagView: UIScrollView {
  
  public enum InputTagBorderState {
    case none
    case circleWithFullLine(color: UIColor)
    case circleWithDashLine(color: UIColor, lineDashPattern: [NSNumber])
  }
  
  public var tagsArr: [String] {
    return tagStrs
  }
  
  // 设置以下属性需要在addTags方法前设置
  public var tagHeight: CGFloat = 30
  // tag的外边距，width代表距左右的边距，height代表距上下的边距
  public var tagMarginSize: CGSize = CGSize(width: 10, height: 10)
  // tag的内边距
  public var tagPaddingSize: CGSize = CGSize(width: 0, height: 0)
  // 输入标签的字体大小
  public var tagFontSize: CGFloat = 14
  
  public var tagBgColor = UIColor.clear
  public var tagBorderColor = UIColor.green
  public var tagTextColor = UIColor.green
  
  public weak var tagDelegate: ACInputTagViewDelegate?
  
  public var inputTagMaxWordCount: Int = 15
  public var inputTagPlaceholder: String {
    didSet {
      inputTagTextField.placeholder = inputTagPlaceholder
    }
  }
  public var inputTagFontSize: CGFloat {
    didSet {
      inputTagTextField.font = UIFont.systemFont(ofSize: inputTagFontSize)
    }
  }
  public var inputTagBgColor: UIColor {
    didSet {
      inputTagTextField.backgroundColor = inputTagBgColor
    }
  }
  public var inputTagTextColor: UIColor {
    didSet {
      inputTagTextField.textColor = inputTagTextColor
    }
  }
  public var inputTagPlaceholderColor: UIColor {
    didSet {
      let placeholderStr = inputTagPlaceholder
      let attr = NSMutableAttributedString(string: placeholderStr)
      attr.addAttributes([NSForegroundColorAttributeName: inputTagPlaceholderColor], range: NSRange(location: 0, length: placeholderStr.characters.count))
      inputTagTextField.attributedPlaceholder = attr
      inputTagTextField.paddingSize = tagPaddingSize
    }
  }
  public var inputTagBorderState: InputTagBorderState {
    didSet {
      setTagDashLine()
    }
  }
  
  private var tagBtns: [ACTagButton] = []
  private var tagStrs: [String] = []
  
  fileprivate var inputTagTextField = ACTagTextField()
  fileprivate var borderLayer = CAShapeLayer()
  
  public func addTags(_ tags: [String]) {
    
    tags.forEach({ addTagToLast($0) })
    layoutTags()
    
  }
  
  public func addTag(_ tag: String) {
    
    addTagToLast(tag)
    layoutTags()
    
  }
  
  public func removeTag(_ tag: String) {
    
    if let index = tagStrs.index(of: tag) {
      tagStrs.remove(at: index)
      tagBtns[index].removeFromSuperview()
      tagBtns.remove(at: index)
    }
    layoutTags()
    
    
  }
  
  public func removeTag(by index: Int) {
    
    
    if index >= tagStrs.count || index >= tagBtns.count { return }
    tagStrs.remove(at: index)
    tagBtns[index].removeFromSuperview()
    tagBtns.remove(at: index)
    layoutTags()
    
  }
  
  public override init(frame: CGRect) {
    
    inputTagPlaceholder = "输入标签"
    inputTagFontSize = 13
    inputTagBgColor = UIColor.clear
    inputTagTextColor = UIColor.black
    inputTagPlaceholderColor = UIColor.lightGray
    inputTagBorderState = InputTagBorderState.none
    
    super.init(frame: frame)
    setupUI()
    
  }
  
  public required init?(coder aDecoder: NSCoder) {
    
    inputTagPlaceholder = "输入标签"
    inputTagFontSize = 13
    inputTagBgColor = UIColor.clear
    inputTagTextColor = UIColor.black
    inputTagPlaceholderColor = UIColor.lightGray
    inputTagBorderState = InputTagBorderState.none
    
    super.init(coder: aDecoder)
    setupUI()
    
  }
  
  private func setupUI() {
    
    if bounds.width == 0 {
      frame.size.width = ACScreenWidth
    }
    showsVerticalScrollIndicator = true
    showsHorizontalScrollIndicator = false
    
    addSubview(inputTagTextField)
    inputTagTextField.addTarget(self, action: #selector(textFieldDidFinishChange), for: .editingChanged)
    inputTagTextField.delegate = self
    inputTagTextField.textAlignment = .left
    inputTagTextField.returnKeyType = .done
    setupTextField()
    
  }

  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
    super.touchesBegan(touches, with: event)
    _ = textFieldShouldReturn(inputTagTextField)
    
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
    
    var tempFrame = inputTagTextField.frame
    let textStr = inputTagTextField.text ?? inputTagPlaceholder
    let textWidth = max((textStr.isEmpty ? inputTagPlaceholder : textStr).ac_getWidth(inputTagFontSize), inputTagPlaceholder.ac_getWidth(inputTagFontSize))
    tempFrame.size.width = textWidth + inputTagTextField.bounds.height + tagPaddingSize.width * 2
    
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
  
  private func setTagDashLine() {
    
    switch inputTagBorderState {
    case .none:
      inputTagTextField.borderStyle = .none
    case .circleWithFullLine(color: let color):
      inputTagTextField.layer.borderWidth = 1
      inputTagTextField.layer.borderColor = color.cgColor
      inputTagTextField.layer.cornerRadius = inputTagTextField.frame.height * 0.5
    case .circleWithDashLine(color: let color, lineDashPattern: let lineDashPattern):
      inputTagTextField.borderStyle = .none
      borderLayer = CAShapeLayer()
      borderLayer.frame = CGRect(x: 0, y: 0, width: inputTagTextField.bounds.width + inputTagTextField.bounds.height + tagPaddingSize.width * 2, height: inputTagTextField.bounds.height)
      borderLayer.lineDashPattern = lineDashPattern
      borderLayer.path = UIBezierPath(roundedRect: borderLayer.bounds, cornerRadius: borderLayer.bounds.width / 2).cgPath
      borderLayer.fillColor = UIColor.clear.cgColor
      borderLayer.strokeColor = color.cgColor
      inputTagTextField.layer.sublayers?.removeAll()
      inputTagTextField.layer.addSublayer(borderLayer)
    }
    
  }

  fileprivate func setupTextField() {
    
    inputTagTextField.frame = CGRect(x: 0, y: 0, width: inputTagPlaceholder.ac_getWidth(inputTagFontSize), height: tagHeight)
    
    inputTagFontSize = 13
    inputTagBgColor = UIColor.clear
    inputTagTextColor = UIColor.black
    inputTagPlaceholder = "输入标签"
    inputTagPlaceholderColor = UIColor.lightGray
    inputTagBorderState = InputTagBorderState.circleWithDashLine(color: UIColor.lightGray, lineDashPattern: [3, 3])
    
  }
  
  @objc private func textFieldDidFinishChange(_ textField: UITextField) {
    guard textField.text != nil else{
      return
    }
    
    let temRange = textField.markedTextRange
    var temSelectLength: Int = 0
    if temRange != nil {
      temSelectLength = textField.offset(from: temRange!.start, to: temRange!.end)
    }
    if textField.text!.characters.count - temSelectLength >= inputTagMaxWordCount {
      let index = textField.text!.characters.index(textField.text!.startIndex, offsetBy: inputTagMaxWordCount)
      textField.text = textField.text!.substring(to: index).replacingOccurrences(of: " ", with: "")
    }
    
    layoutTags()
    
    if case .circleWithDashLine(color: _, lineDashPattern: _) = inputTagBorderState {
      borderLayer.frame = inputTagTextField.bounds
      borderLayer.path = UIBezierPath(roundedRect: borderLayer.bounds, cornerRadius: borderLayer.bounds.height / 2).cgPath
    }
    
  }
  
  private func createTagBtn(with tag: String) -> ACTagButton {
    
    let tagBtn = ACTagButton()
    
    tagBtn.selectedBgColor = tagBgColor
    tagBtn.selectedTextColor = tagTextColor
    tagBtn.selectedBorderColor = tagBorderColor
    
    tagBtn.isSelected = true
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
    guard let index = tagStrs.index(of: tagStr) else { return }
    removeTag(tagStr)
    tagDelegate?.tagView(self, didClickedTagAt: index, tagStr: tagStr)
  }

}


extension ACInputTagView: UITextFieldDelegate {
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    textField.resignFirstResponder()
    guard let tfText = textField.text, !tfText.isEmpty else { return false }
    textField.text = ""
    addTag(tfText)
    if case .circleWithDashLine(color: _, lineDashPattern: _) = inputTagBorderState {
      borderLayer.frame = inputTagTextField.bounds
      borderLayer.path = UIBezierPath(roundedRect: borderLayer.bounds, cornerRadius: borderLayer.bounds.height / 2).cgPath
    }
    tagDelegate?.tagView(self, didFinishInputTagStr: tfText)
    return true
    
  }
  
  
}
