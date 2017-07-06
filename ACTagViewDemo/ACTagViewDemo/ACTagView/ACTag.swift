//
//  ACTag.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/7/5.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

open class ACTag: UIButton {

  open var selectedBackgroundColor = ACTagManager.shared.selectedTagBackgroundColor
  open var normalBackgroundColor = ACTagManager.shared.tagBackgroundColor
  open var borderType = ACTagManager.shared.tagBorderType {
    didSet {
      setBorderTyper()
    }
  }
  open var selectedBorderColor = ACTagManager.shared.selectedTagBorderColor
  open var borderColor = ACTagManager.shared.tagBorderColor
  // tag的内边距
  open var paddingSize = ACTagManager.shared.tagPaddingSize {
    didSet {
      titleEdgeInsets = UIEdgeInsets(top: paddingSize.height, left: paddingSize.width, bottom: paddingSize.height, right: paddingSize.width)
    }
  }
  open var fontSize: CGFloat = ACTagManager.shared.tagFontSize {
    didSet {
      titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
    }
  }
  
  open override var frame: CGRect {
    didSet {
      setBorderTyper()
    }
  }
  
  override open var isSelected: Bool {
    didSet {
      if isSelected {
        backgroundColor = selectedBackgroundColor
        layer.borderColor = selectedBorderColor.cgColor
      } else {
        backgroundColor = normalBackgroundColor
        layer.borderColor = borderColor.cgColor
      }
    }
  }
  
  public init() {
    super.init(frame: CGRect.zero)
    initializeDefaultValue()
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initializeDefaultValue()
  }
  
  func setWidth(withHeight height: CGFloat) {
    guard let titleLabel = titleLabel, let text = titleLabel.text else { return }
    frame.size.width = text.ac_getWidth(titleLabel.font.pointSize) + height + 2 * paddingSize.width
  }
  
  private func initializeDefaultValue() {
    
    isUserInteractionEnabled = false
    isSelected = false
    
    let manager = ACTagManager.shared
    borderType = manager.tagBorderType
    paddingSize = manager.tagPaddingSize
    layer.borderWidth = manager.tagBorderWidth
    fontSize = manager.tagFontSize
    backgroundColor = manager.tagBackgroundColor
    
    setTitleColor(manager.tagTextColor, for: .normal)
    setTitleColor(manager.selectedTagTextColor, for: .selected)
  }
  
  private func setBorderTyper() {
    
    superview?.layoutIfNeeded()
    switch borderType {
    case .halfOfCircle:
      layer.cornerRadius = frame.height / 2
      layer.masksToBounds = true
    case .custom(radius: let radius):
      layer.cornerRadius = radius
      layer.masksToBounds = true
    case .none:
      layer.cornerRadius = 0
      layer.masksToBounds = false
    }
  }
  
}
