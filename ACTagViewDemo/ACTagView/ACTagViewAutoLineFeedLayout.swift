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
    
    return CGSize(width: collectionView.bounds.width, height: offsetY + tagHeight + tagViewMargin.vertical)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let array = super.layoutAttributesForElements(in: rect), let collectionView = collectionView else { return nil }
    
    collectionView.layoutIfNeeded()
    collectionView.superview?.layoutIfNeeded()
    
    var offsetX = tagViewMargin.horizontal
    var offsetY = tagViewMargin.vertical
    
    var finalAttrs: [UICollectionViewLayoutAttributes] = []
    
    for (index,attribute) in array.enumerated() {
      
      let attrCopy = attribute.copy() as! UICollectionViewLayoutAttributes
      
      var tempFrame = attrCopy.frame
      
      if (offsetX + tempFrame.width + tagViewMargin.horizontal) > collectionView.bounds.width {
        if index != 0 {
          offsetX = tagViewMargin.horizontal
          offsetY += tagHeight + tagMargin.vertical
          if !collectionView.isScrollEnabled && offsetY + tagHeight + tagViewMargin.vertical > collectionView.bounds.height {
            self.offsetY = offsetY
            return finalAttrs
          }
        } else {
          offsetX = tagViewMargin.horizontal
        }
      }
      
      tempFrame.origin.x = offsetX
      tempFrame.origin.y = offsetY
      offsetX += tempFrame.width + tagMargin.horizontal
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
    
    var offsetX = tagViewMargin.horizontal
    var offsetY = tagViewMargin.vertical
    
    for i in 0 ..< dataSource.numberOfTags(in: tagView) {
      
      let attribute = dataSource.tagView(tagView, tagAttributeForIndexAt: i)
      let width = attribute.getWidth(height: tagHeight)
      
      if (offsetX + width + tagViewMargin.horizontal) > collectionView.bounds.width {
        if i != 0 {
          offsetX = tagViewMargin.horizontal
          offsetY += tagHeight + tagMargin.vertical
        } else {
          offsetX = tagViewMargin.horizontal
        }
      }
      
      offsetX += width + tagMargin.horizontal
    }
    
    return CGSize(width: collectionView.bounds.width, height:  offsetY + tagHeight + tagViewMargin.vertical)
  }
}
