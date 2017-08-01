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
  
  open var paddingSize = CGSize.zero
  open var position: Position = .tail
  open var fontSize: CGFloat = 14 {
    didSet {
      font = UIFont.systemFont(ofSize: fontSize)
    }
  }
  open var borderType: ACInputTagBorderState = .circleWithFullLine
  open var borderColor: UIColor = ACTagManager.shared.inputTagBorderColor
  
  open var maxWordCount: Int?
  
  open var defaultPlaceholder = "输入标签" {
    didSet {
      placeholder = defaultPlaceholder
    }
  }
  open var placeholderColor: UIColor = .lightGray {
    didSet {
      let str = placeholder ?? ""
      let attribute = NSMutableAttributedString(string: str)
      attribute.addAttributes([NSForegroundColorAttributeName: placeholderColor], range: NSRange(location: 0, length: str.characters.count))
      attributedPlaceholder = attribute
    }
  }
  
  var layoutTags: (() -> ())?
  var inputFinish: ((ACInputTag) -> Bool)?
  private var borderLayer: CAShapeLayer?
  
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
  
  func setBorder() {
    layoutIfNeeded()
    superview?.layoutIfNeeded()
    
    setTagDashLine()
  }
  
  private func initializeDefaultValue() {
    
    let manager = ACTagManager.shared
    paddingSize = manager.inputTagPaddingSize
    layer.borderWidth = manager.tagBorderWidth
    fontSize = manager.inputTagFontSize
    defaultPlaceholder = "输入标签"
    
    addTarget(self, action: #selector(textFieldDidFinishChange), for: .editingChanged)
    textAlignment = .left
    returnKeyType = .done
    delegate = self
  }
  
  private func setTagDashLine() {
    
    switch borderType {
    case .none:
      borderStyle = .none
      borderLayer = nil
    case .circleWithFullLine:
      layer.borderWidth = 1
      layer.borderColor = borderColor.cgColor
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
      borderLayer!.strokeColor = borderColor.cgColor
      layer.sublayers?.removeAll()
      layer.addSublayer(borderLayer!)
    case .fullLine(cornerRadius: let radius):
      layer.borderWidth = 1
      layer.borderColor = borderColor.cgColor
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
      borderLayer!.strokeColor = borderColor.cgColor
      layer.sublayers?.removeAll()
      layer.addSublayer(borderLayer!)
    }
    
  }
  
  @objc private func textFieldDidFinishChange(_ textField: UITextField) {
    guard textField.text != nil else{
      return
    }
    guard let maxWordCount = maxWordCount else {
      layoutTags?()
      return
    }
    let temRange = textField.markedTextRange
    var temSelectLength: Int = 0
    if let range = temRange {
      temSelectLength = textField.offset(from: range.start, to: range.end)
    }
    if textField.text!.characters.count - temSelectLength >= maxWordCount {
      let index = textField.text!.characters.index(textField.text!.startIndex, offsetBy: maxWordCount)
      textField.text = textField.text!.substring(to: index).replacingOccurrences(of: " ", with: "")
    }
    
    layoutTags?()
    
  }

}

extension ACInputTag: UITextFieldDelegate {
  
  public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    return inputFinish?(self) ?? false
    
  }
  
  
}
