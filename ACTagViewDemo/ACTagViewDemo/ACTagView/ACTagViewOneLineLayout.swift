//
//  ACTagViewOneLineLayout.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/7/30.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class ACTagViewOneLineLayout: ACTagViewFlowLayout {
  
  private var offsetX: CGFloat = 0
  
  override var collectionViewContentSize: CGSize {
    guard let collectionView = collectionView else {
      return CGSize.zero
    }
    
    collectionView.layoutIfNeeded()
    collectionView.superview?.layoutIfNeeded()
    
    return CGSize(width: max(collectionView.bounds.width, offsetX), height: collectionView.bounds.height)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let array = super.layoutAttributesForElements(in: rect), let collectionView = collectionView else { return nil }
    
    collectionView.layoutIfNeeded()
    collectionView.superview?.layoutIfNeeded()
    
    var finalAttrs: [UICollectionViewLayoutAttributes] = []
    
    var offsetX = tagViewMargin.x
    let offsetY = tagViewMargin.y
    
    for attribute in array {
      
      let attrCopy = attribute.copy() as! UICollectionViewLayoutAttributes
      
      attrCopy.frame.origin.x = offsetX
      attrCopy.frame.origin.y = offsetY
      
      if !collectionView.isScrollEnabled && offsetX + attribute.frame.width + tagViewMargin.x > collectionView.bounds.width {
        self.offsetX = offsetX
        return finalAttrs
      }
      
      offsetX += tagMarginSize.width + attribute.frame.width
      
      finalAttrs += [attrCopy]
    }
    
    if offsetX > tagViewMargin.x {
      offsetX = offsetX - tagMarginSize.width + tagViewMargin.x
    }
    self.offsetX = offsetX
    
    return finalAttrs
  }
  
  override func getEstimatedHeight(in tagView: ACTagView) -> CGFloat {
    return tagHeight + 2 * tagViewMargin.y
  }

}
