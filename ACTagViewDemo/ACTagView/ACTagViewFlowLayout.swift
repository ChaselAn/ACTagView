//
//  ACTagViewFlowLayout.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/7/30.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

open class ACTagViewFlowLayout: UICollectionViewFlowLayout {

  open var tagMargin = ACTagConfig.default.tagMargin
  open var tagHeight: CGFloat = ACTagConfig.default.tagDefaultHeight
  open var tagViewMargin = ACTagConfig.default.tagViewMargin
  
  open func getEstimatedSize(in tagView: ACTagView) -> CGSize {
    return CGSize.zero
  }
  
}
