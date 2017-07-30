//
//  ACTagViewCell.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/7/30.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class ACTagViewCell: UICollectionViewCell {
  
  var tagButton = ACTagButton()
  var tagAttribute: ACTagAttribute? {
    didSet {
      tagButton.frame = bounds
      tagButton.tagAttribute = tagAttribute!
      tagButton.isSelected = isSelected
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.addSubview(tagButton)

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func selected() {
    tagButton.isSelected = true
  }
  
  func deselected() {
    tagButton.isSelected = false
  }
  
}
