//
//  BetaACTag.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/7/30.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

open class ACTagAttribute: NSObject {
  
  open var text = ""
  open var selectedBackgroundColor = ACTagManager.shared.selectedTagBackgroundColor
  open var backgroundColor = ACTagManager.shared.tagBackgroundColor
  open var selectedBorderColor = ACTagManager.shared.selectedTagBorderColor
  open var borderColor = ACTagManager.shared.tagBorderColor
  open var textColor = ACTagManager.shared.tagTextColor
  open var selectedTextColor = ACTagManager.shared.selectedTagTextColor
  open var borderType = ACTagManager.shared.tagBorderType
  // tag的内边距
  open var paddingSize = ACTagManager.shared.tagPaddingSize
  open var font: UIFont = ACTagManager.shared.tagFont
  open var borderWidth = ACTagManager.shared.tagBorderWidth
  
  open func getWidth(height: CGFloat) -> CGFloat {
    return text.ac_getWidth(font.pointSize) + height + 2 * paddingSize.width
  }

  convenience public init(text: String) {
    self.init()
    self.text = text
  }
  
}
