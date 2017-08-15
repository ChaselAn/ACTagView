//
//  ACInputTag.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/7/6.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

open class ACInputTag: UITextField {

  public enum Position {
    case head
    case tail
  }
  
  var attribute: ACInputTagAttribute? {
    didSet {
      setUpUI()
    }
  }
  var layoutTags: (() -> ())?
  var inputFinish: ((ACInputTag) -> Bool)?
  
  private var borderLayer: CAShapeLayer?
  private var paddingSize = CGSize.zero
  
  public init() {
    super.init(frame: CGRect.zero)
    initializeDefaultValue()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initializeDefaultValue()
  }
  
  override open func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: self.bounds.height / 2 + paddingSize.width, dy: 0)
  }
  
  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: self.bounds.height / 2 + paddingSize.width, y: 0, width: bounds.width + self.bounds.height / 2 + paddingSize.width, height: bounds.height)
  }
  
  func setBorder(type: ACInputTagBorderState, color: UIColor) {
    layoutIfNeeded()
    superview?.layoutIfNeeded()
    
    setTagDashLine(type: type, color: color)
  }
  
  private func initializeDefaultValue() {
    
    layer.borderWidth = ACTagConfig.default.tagBorderWidth
    
    addTarget(self, action: #selector(textFieldDidFinishChange), for: .editingChanged)
    textAlignment = .left
    returnKeyType = .done
    delegate = self
  }
  
  private func setUpUI() {
    guard let attribute = attribute else { return }
    paddingSize = attribute.paddingSize
    font = UIFont.systemFont(ofSize: attribute.fontSize)
    setBorder(type: attribute.borderType, color: attribute.borderColor)
    let str = attribute.defaultPlaceholder
    let attributeStr = NSMutableAttributedString(string: str)
    attributeStr.addAttributes([NSForegroundColorAttributeName: attribute.placeholderColor], range: NSRange(location: 0, length: str.characters.count))
    attributedPlaceholder = attributeStr
  }
  
  private func setTagDashLine(type: ACInputTagBorderState, color: UIColor) {
    
    switch type {
    case .none:
      borderStyle = .none
      borderLayer = nil
    case .circleWithFullLine:
      layer.borderWidth = 1
      layer.borderColor = color.cgColor
      layer.cornerRadius = frame.height * 0.5
      borderLayer = nil
    case .circleWithDashLine(lineDashPattern: let lineDashPattern):
      if let borderLayer = borderLayer {
        borderLayer.frame = bounds
        borderLayer.path = UIBezierPath(roundedRect: borderLayer.bounds, cornerRadius: borderLayer.bounds.width / 2).cgPath
        break
      }
      borderStyle = .none
      layer.borderWidth = 0
      borderLayer = CAShapeLayer()
      borderLayer!.frame = bounds
      borderLayer!.lineDashPattern = lineDashPattern
      borderLayer!.path = UIBezierPath(roundedRect: borderLayer!.bounds, cornerRadius: borderLayer!.bounds.width / 2).cgPath
      borderLayer!.fillColor = UIColor.clear.cgColor
      borderLayer!.strokeColor = color.cgColor
      layer.sublayers?.removeAll()
      layer.addSublayer(borderLayer!)
    case .fullLine(cornerRadius: let radius):
      layer.borderWidth = 1
      layer.borderColor = color.cgColor
      layer.cornerRadius = radius
      borderLayer = nil
    case .dashLine(cornerRadius: let radius, lineDashPattern: let lineDashPattern):
      if let borderLayer = borderLayer {
        borderLayer.frame = bounds
        borderLayer.path = UIBezierPath(roundedRect: borderLayer.bounds, cornerRadius: borderLayer.bounds.width / 2).cgPath
        break
      }
      borderStyle = .none
      layer.borderWidth = 0
      borderLayer = CAShapeLayer()
      borderLayer!.frame = bounds
      borderLayer!.lineDashPattern = lineDashPattern
      borderLayer!.path = UIBezierPath(roundedRect: borderLayer!.bounds, cornerRadius: radius).cgPath
      borderLayer!.fillColor = UIColor.clear.cgColor
      borderLayer!.strokeColor = color.cgColor
      layer.sublayers?.removeAll()
      layer.addSublayer(borderLayer!)
    }
    
  }
  
  @objc private func textFieldDidFinishChange(_ textField: UITextField) {
    guard let textStr = textField.text else{
      return
    }
    guard let maxWordCount = attribute?.maxWordCount else {
      frame.size.width = max(textStr.ac_getWidth(attribute?.fontSize ?? ACTagConfig.default.inputTagFontSize), placeholder?.ac_getWidth(attribute?.fontSize ?? ACTagConfig.default.inputTagFontSize) ?? 0) + bounds.height
      if let attribute = attribute {
        setBorder(type: attribute.borderType, color: attribute.borderColor)
      }
      layoutTags?()
      return
    }
    let temRange = textField.markedTextRange
    var temSelectLength: Int = 0
    if let range = temRange {
      temSelectLength = textField.offset(from: range.start, to: range.end)
    }
    if textStr.characters.count - temSelectLength >= maxWordCount {
      let index = textStr.characters.index(textStr.startIndex, offsetBy: maxWordCount)
      textField.text = textStr.substring(to: index).replacingOccurrences(of: " ", with: "")
    }
    
    bounds.size.width = max(textStr.ac_getWidth(attribute?.fontSize ?? ACTagConfig.default.inputTagFontSize), placeholder?.ac_getWidth(attribute?.fontSize ?? ACTagConfig.default.inputTagFontSize) ?? 0) + bounds.height
    if let attribute = attribute {
       setBorder(type: attribute.borderType, color: attribute.borderColor)
    }
    layoutTags?()
    
  }

}

extension ACInputTag: UITextFieldDelegate {
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    return inputFinish?(self) ?? false
    
  }
  
  
}
