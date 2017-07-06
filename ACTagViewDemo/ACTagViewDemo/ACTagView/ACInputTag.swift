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
  open var fontSize: CGFloat = 14
  open var borderType: ACInputTagBorderState = .circleWithFullLine
//  open var borderColor:
  
  override open func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: self.bounds.height / 2 + paddingSize.width, dy: 0)
  }
  
  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: self.bounds.height / 2 + paddingSize.width, y: 0, width: bounds.width + self.bounds.height / 2 + paddingSize.width, height: bounds.height)
  }
  
  var defaultPlaceholder = "输入标签"

}
