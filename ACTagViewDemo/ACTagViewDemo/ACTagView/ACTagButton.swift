//
//  ACTagButton.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/7/30.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class ACTagButton: UIButton {
  
  var tagAttribute = ACTagAttribute() {
    didSet {
      setUpUI()
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    isUserInteractionEnabled = false
    isSelected = false
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override open var isSelected: Bool {
    didSet {
      if isSelected {
        backgroundColor = tagAttribute.selectedBackgroundColor
        layer.borderColor = tagAttribute.selectedBorderColor.cgColor
      } else {
        backgroundColor = tagAttribute.backgroundColor
        layer.borderColor = tagAttribute.borderColor.cgColor
      }
    }
  }

  private func setUpUI() {
    
    setTitle(tagAttribute.text, for: .normal)
    setTitleColor(tagAttribute.textColor, for: .normal)
    setTitleColor(tagAttribute.selectedTextColor, for: .selected)
    backgroundColor = tagAttribute.backgroundColor
    layer.borderWidth = tagAttribute.borderWidth
    titleLabel?.font = tagAttribute.font
    let paddingSize = tagAttribute.paddingSize
    titleEdgeInsets = UIEdgeInsets(top: paddingSize.height, left: paddingSize.width, bottom: paddingSize.height, right: paddingSize.width)
    
    setBorderTyper(tagAttribute.borderType)
    
  }
  
  private func setBorderTyper(_ type: ACTagBorderType) {
    
    superview?.layoutIfNeeded()
    switch type {
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
