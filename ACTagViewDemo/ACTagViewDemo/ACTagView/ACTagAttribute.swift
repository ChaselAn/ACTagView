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
  open var selectedBackgroundColor = ACTagConfig.default.selectedTagBackgroundColor
  open var backgroundColor = ACTagConfig.default.tagBackgroundColor
  open var selectedBorderColor = ACTagConfig.default.selectedTagBorderColor
  open var borderColor = ACTagConfig.default.tagBorderColor
  open var textColor = ACTagConfig.default.tagTextColor
  open var selectedTextColor = ACTagConfig.default.selectedTagTextColor
  open var borderType = ACTagConfig.default.tagBorderType
  // tag的内边距
  open var paddingSize = ACTagConfig.default.tagPaddingSize
  open var font: UIFont = ACTagConfig.default.tagFont
  open var borderWidth = ACTagConfig.default.tagBorderWidth
  
  open func getWidth(height: CGFloat) -> CGFloat {
    return text.ac_getWidth(font.pointSize) + height + 2 * paddingSize.width
  }

  convenience public init(text: String) {
    self.init()
    self.text = text
  }
  
}
