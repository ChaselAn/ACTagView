//
//  ACTagViewInputTagCell.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/7/31.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class ACTagViewInputTagCell: UICollectionViewCell {
  
  var inputTag = ACInputTag()
  var tagAttribute: ACTagAttribute? {
    didSet {
      inputTag.frame = bounds
      inputTag.isSelected = isSelected
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.addSubview(inputTag)
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
//  
//  func selected() {
//    tagButton.isSelected = true
//  }
//  
//  func deselected() {
//    tagButton.isSelected = false
//  }
//  
}
