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
  var inputTagAttribute: String? {
    didSet {
      inputTag.frame = bounds
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    contentView.addSubview(inputTag)
    backgroundColor = UIColor.green
    inputTag.backgroundColor = UIColor.lightGray
    inputTag.layoutTags = { [weak self] in
      guard let strongSelf = self else { return }
//      print(strongSelf.inputTag.bounds.width)
//      strongSelf.frame.size.width = strongSelf.inputTag.bounds.width
//      strongSelf.layoutIfNeeded()
      strongSelf.layoutTags?(strongSelf.inputTag.bounds.width)
    }

  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
