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
    
    return CGSize(width: collectionView.bounds.width, height: offsetY + tagHeight + tagViewMargin.y)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let array = super.layoutAttributesForElements(in: rect), let collectionView = collectionView else { return nil }
    
    collectionView.layoutIfNeeded()
    collectionView.superview?.layoutIfNeeded()
    
    var offsetX = tagViewMargin.x
    var offsetY = tagViewMargin.y
    
    var finalAttrs: [UICollectionViewLayoutAttributes] = []
    
    for (index,attribute) in array.enumerated() {
      
      let attrCopy = attribute.copy() as! UICollectionViewLayoutAttributes
      
      var tempFrame = attrCopy.frame
      
      if (offsetX + tempFrame.width + tagViewMargin.x) > collectionView.bounds.width {
        if index != 0 {
          offsetX = tagViewMargin.x
          offsetY += tagHeight + tagMarginSize.height
          if !collectionView.isScrollEnabled && offsetY + tagHeight + tagViewMargin.y > collectionView.bounds.height {
            self.offsetY = offsetY
            return finalAttrs
          }
        } else {
          offsetX = tagViewMargin.x
        }
      }
      
      tempFrame.origin.x = offsetX
      tempFrame.origin.y = offsetY
      offsetX += tempFrame.width + tagMarginSize.width
      tempFrame.size.height = tagHeight
      attrCopy.frame = tempFrame
      self.offsetY = offsetY
      
      finalAttrs += [attrCopy]
    }
    
    return finalAttrs
  }

  override func getEstimatedSize(in tagView: ACTagView) -> CGSize {
    
    guard let collectionView = collectionView, let dataSource = tagView.tagDataSource else { return CGSize.zero }
    
    tagView.layoutIfNeeded()
    tagView.superview?.layoutIfNeeded()
    
    var offsetX = tagViewMargin.x
    var offsetY = tagViewMargin.y
    
    for i in 0 ..< dataSource.numberOfTags(in: tagView) {
      
      let attribute = dataSource.tagView(tagView, tagAttributeForIndexAt: i)
      let width = attribute.getWidth(height: tagHeight)
      
      if (offsetX + width + tagViewMargin.x) > collectionView.bounds.width {
        if i != 0 {
          offsetX = tagViewMargin.x
          offsetY += tagHeight + tagMarginSize.height
        } else {
          offsetX = tagViewMargin.x
        }
      }
      
      offsetX += width + tagMarginSize.width
    }
    
    return CGSize(width: collectionView.bounds.width, height:  offsetY + tagHeight + tagViewMargin.y)
  }
}
