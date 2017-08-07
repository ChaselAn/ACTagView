//
//  ACTagViewAutoLineFeedLayout.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/7/29.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class ACTagViewAutoLineFeedLayout: ACTagViewFlowLayout {
  
  private var offsetY: CGFloat = 0
  
  override var collectionViewContentSize: CGSize {
    guard let collectionView = collectionView else {
      return CGSize.zero
    }
    
    collectionView.layoutIfNeeded()
    collectionView.superview?.layoutIfNeeded()
    
    return CGSize(width: collectionView.bounds.width, height: offsetY + tagHeight + tagMarginSize.height)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {

    guard let array = super.layoutAttributesForElements(in: rect), let collectionView = collectionView else { return nil }
    collectionView.layoutIfNeeded()
    collectionView.superview?.layoutIfNeeded()
    
    var offsetX = tagMarginSize.width
    var offsetY = tagMarginSize.height
    var finalAttrs: [UICollectionViewLayoutAttributes] = []
    
    for (index,attribute) in array.enumerated() {
      
      let attrCopy = attribute.copy() as! UICollectionViewLayoutAttributes
      var tempFrame = attrCopy.frame
      
      if (offsetX + tempFrame.width + tagMarginSize.width) > collectionView.bounds.width {
        if index != 0 {
          offsetX = tagMarginSize.width
          offsetY += tagHeight + tagMarginSize.height
        } else {
          offsetX = tagMarginSize.width
        }
      }
      
      tempFrame.origin.x = offsetX
      tempFrame.origin.y = offsetY
      offsetX += tempFrame.width + tagMarginSize.width
      tempFrame.size.height = tagHeight
      attrCopy.frame = tempFrame
      
      finalAttrs += [attrCopy]
      self.offsetY = offsetY
    }
    
    return finalAttrs
  }

  override func getEstimatedHeight(in tagView: ACTagView, dataSource: ACTagViewDataSource) -> CGFloat {
    
    guard let collectionView = collectionView else { return 0 }
    
    tagView.layoutIfNeeded()
    tagView.superview?.layoutIfNeeded()
    
    var offsetX = tagMarginSize.width
    var offsetY = tagMarginSize.height
    
    for i in 0 ..< dataSource.numberOfTags(in: tagView) {
      
      let attribute = dataSource.tagView(tagView, tagAttributeForIndexAt: i)
      let width = attribute.getWidth(height: tagHeight)
      
      if (offsetX + width + tagMarginSize.width) > collectionView.bounds.width {
        if i != 0 {
          offsetX = tagMarginSize.width
          offsetY += tagHeight + tagMarginSize.height
        } else {
          offsetX = tagMarginSize.width
        }
      }
      
      offsetX += width + tagMarginSize.width
    }
    
    return offsetY + tagHeight + tagMarginSize.height
  }
}
