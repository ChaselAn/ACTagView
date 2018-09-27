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
    
    var offsetX = tagViewMargin.horizontal
    let offsetY = tagViewMargin.vertical
    
    for attribute in array {
      
      let attrCopy = attribute.copy() as! UICollectionViewLayoutAttributes
      
      attrCopy.frame.origin.x = offsetX
      attrCopy.frame.origin.y = offsetY
      
      if !collectionView.isScrollEnabled && offsetX + attribute.frame.width + tagViewMargin.horizontal > collectionView.bounds.width {
        self.offsetX = offsetX
        return finalAttrs
      }
      
      offsetX += tagMargin.horizontal + attribute.frame.width
      
      finalAttrs += [attrCopy]
    }
    
    if offsetX > tagViewMargin.horizontal {
      offsetX = offsetX - tagMargin.horizontal + tagViewMargin.horizontal
    }
    self.offsetX = offsetX
    
    return finalAttrs
  }
  
  override func getEstimatedSize(in tagView: ACTagView) -> CGSize {
    
    guard let dataSource = tagView.tagDataSource else { return CGSize.zero }
    
    tagView.layoutIfNeeded()
    tagView.superview?.layoutIfNeeded()
    
    var offsetX = tagViewMargin.horizontal
    
    for i in 0 ..< dataSource.numberOfTags(in: tagView) {
      
      let attribute = dataSource.tagView(tagView, tagAttributeForIndexAt: i)
      let width = attribute.getWidth(height: tagHeight)
      
      offsetX += tagMargin.horizontal + width
      
    }
    
    if offsetX > tagViewMargin.horizontal {
      offsetX = offsetX - tagMargin.horizontal + tagViewMargin.horizontal
    }
    
    return CGSize(width: offsetX, height: tagHeight + 2 * tagViewMargin.vertical)
  }

}
