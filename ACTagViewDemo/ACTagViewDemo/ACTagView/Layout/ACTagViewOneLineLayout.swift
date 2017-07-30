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
    return CGSize(width: max(collectionView.bounds.width, offsetX), height: collectionView.bounds.height)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let array = super.layoutAttributesForElements(in: rect) else { return nil }
    
    print("one---------", rect)
    var finalAttrs: [UICollectionViewLayoutAttributes] = []
    
    var offsetX = tagMarginSize.width
    let offsetY = tagMarginSize.height
    
    for attribute in array {
      
      let attrCopy = attribute.copy() as! UICollectionViewLayoutAttributes
      
      attrCopy.frame.origin.x = offsetX
      attrCopy.frame.origin.y = offsetY
      
      offsetX += tagMarginSize.width + attribute.frame.width
      
      finalAttrs += [attrCopy]
    }
    self.offsetX = offsetX
    
    return finalAttrs
  }

}
