//
//  ACTagViewLayout.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/7/29.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class ACTagViewLayout: UICollectionViewFlowLayout {
  
  var tagMarginSize = ACTagManager.shared.tagMarginSize
  private var offsetY: CGFloat = 0
  
  override var collectionViewContentSize: CGSize {
    guard let collectionView = collectionView else {
      return CGSize.zero
    }
    return CGSize(width: collectionView.bounds.width, height: offsetY + 30 + tagMarginSize.height)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let array = super.layoutAttributesForElements(in: rect), let collectionView = collectionView else { return nil }
    
    var offsetX = tagMarginSize.width
    var offsetY = tagMarginSize.height
    
    for (index,attribute) in array.enumerated() {
      
      var tempFrame = attribute.frame
      
      if (offsetX + tempFrame.width + tagMarginSize.width) > collectionView.bounds.width {
        if index != 0 {
          offsetX = tagMarginSize.width
          offsetY += 30 + tagMarginSize.height
        } else {
          offsetX = tagMarginSize.width
        }
      }
      
      tempFrame.origin.x = offsetX
      tempFrame.origin.y = offsetY
      offsetX += tempFrame.width + tagMarginSize.width
      tempFrame.size.height = 30
      attribute.frame = tempFrame
      self.offsetY = offsetY
    }
    
    return array
  }

}