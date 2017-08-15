//
//  ACTagViewInputTagCell.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/7/31.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class ACTagViewInputTagCell: UICollectionViewCell {
  
  var layoutTags: ((_ width: CGFloat)->())?
  
  var inputTag = ACInputTag()
  var inputTagAttribute: ACInputTagAttribute! {
    didSet {
      inputTag.frame = bounds
      inputTag.attribute = inputTagAttribute
      inputTag.backgroundColor = inputTagAttribute.backgroundColor
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.addSubview(inputTag)
    backgroundColor = UIColor.green
    inputTag.layoutTags = { [weak self] in
      guard let strongSelf = self else { return }
      let width = max(strongSelf.inputTag.bounds.width, strongSelf.inputTagAttribute.defaultPlaceholder.ac_getWidth(strongSelf.inputTagAttribute.fontSize) + strongSelf.inputTag.bounds.height)
      strongSelf.layoutTags?(width)
    }

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
