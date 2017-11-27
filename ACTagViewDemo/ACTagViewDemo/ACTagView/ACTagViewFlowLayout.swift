//
//  ACTagViewFlowLayout.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/7/30.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

open class ACTagViewFlowLayout: UICollectionViewFlowLayout {

  open var tagMarginSize = ACTagConfig.default.tagMarginSize
  open var tagHeight: CGFloat = ACTagConfig.default.tagDefaultHeight
  open var tagViewMargin = ACTagConfig.default.tagViewMargin
  
  open func getEstimatedHeight(in tagView: ACTagView) -> CGFloat {
    return 0
  }
  
}
