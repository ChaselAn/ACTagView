//
//  ACInputTagAttribute.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/8/14.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

open class ACInputTagAttribute: NSObject {

  open var backgroundColor = ACTagConfig.default.inputTagBackgroundColor
  open var paddingSize = CGSize.zero
  open var position: ACInputTag.Position
  open var fontSize: CGFloat = 14
  open var borderType: ACInputTagBorderState = ACTagConfig.default.inputTagBorderType
  open var borderColor: UIColor = ACTagConfig.default.inputTagBorderColor
  
  open var maxWordCount: Int?
  
  open var defaultPlaceholder = "输入标签"
  open var placeholderColor: UIColor = .lightGray
  
  init(position: ACInputTag.Position) {
    self.position = position
    super.init()
  }
  
}
