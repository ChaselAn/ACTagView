//
//  ACTagView.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/7/28.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

enum ACTagViewLayoutType {
  case autoLineFeed
}

protocol ACTagViewDataSource: NSObjectProtocol {
  
  func numberOfTags(in tagView: ACTagView) -> Int
  
  func tagView(_ tagView: ACTagView, tagForIndexAt index: Int) -> ACTagAttribute
  
}

@objc protocol ACTagViewDelegate: NSObjectProtocol {
  
  @objc optional func tagView(_ tagView: ACTagView, didSelectTagAt index: Int)
  
  @objc optional func tagView(_ tagView: ACTagView, didDeselectTagAt index: Int)
}

class ACTagView: UIView {
  
  weak var tagDataSource: ACTagViewDataSource?
  weak var tagDelegate: ACTagViewDelegate?
  var tagHeight: CGFloat = ACTagManager.shared.tagDefaultHeight
  var paddingSize: CGSize = ACTagManager.shared.tagPaddingSize
  var tagMarginSize = ACTagManager.shared.tagMarginSize {
    didSet {
      layout.tagMarginSize = tagMarginSize
    }
  }
  var allowsMultipleSelection: Bool = false {
    didSet {
      collectionView.allowsMultipleSelection = allowsMultipleSelection
    }
  }
  
  var indexsForSelectedTags: [Int] {
    return collectionView.indexPathsForSelectedItems?.map({ $0.item }) ?? []
  }
  
  private var collectionView: UICollectionView!
  private var layout: ACTagViewLayout!

  init(frame: CGRect, layoutType: ACTagViewLayoutType) {
    
    var layout: ACTagViewLayout!
    switch layoutType {
    case .autoLineFeed:
      layout = ACTagViewLayout()
    }
    super.init(frame: frame)
    
    initCollectionView(layout: layout)
  }
  
  init(frame: CGRect, tagViewLayout layout: UICollectionViewLayout) {
    
    super.init(frame: frame)
    
    initCollectionView(layout: layout)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  // 使用xib创建此控件时，必须调用此方法
  func initTagView(layoutType: ACTagViewLayoutType) {
    switch layoutType {
    case .autoLineFeed:
      layout = ACTagViewLayout()
    }
    
    initCollectionView(layout: layout)
  }

  func selectTag(at index: Int) {
    let indexPath = IndexPath(item: index, section: 0)
    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
  }
  
  func deselectTag(at index: Int) {
    let indexPath = IndexPath(item: index, section: 0)
    let cell = collectionView.cellForItem(at: indexPath) as? ACTagViewCell
    cell?.deselected()
    collectionView.deselectItem(at: indexPath, animated: true)
  }
  
  func tagForIndex(at index: Int) -> ACTagButton? {
    let indexPath = IndexPath(item: index, section: 0)
    return (collectionView.cellForItem(at: indexPath) as? ACTagViewCell)?.tagButton
  }
  
  private func initCollectionView(layout: UICollectionViewLayout) {
    
    collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.backgroundColor = UIColor.clear
    collectionView.showsHorizontalScrollIndicator = false
    
    collectionView.register(ACTagViewCell.self, forCellWithReuseIdentifier: "ACTagViewCell")
    addSubview(collectionView)
  }
}

extension ACTagView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tagDataSource?.numberOfTags(in: self) ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ACTagViewCell", for: indexPath) as! ACTagViewCell
    guard let tagDataSource = tagDataSource else { return cell }
    cell.tagAttribute = tagDataSource.tagView(self, tagForIndexAt: indexPath.item)
    return cell
  }
  
}

extension ACTagView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let tagDataSource = tagDataSource else { return CGSize.zero }
    let tagAttribute = tagDataSource.tagView(self, tagForIndexAt: indexPath.item)
    return CGSize(width: tagAttribute.getWidth(height: tagHeight), height: tagHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    let cell = collectionView.cellForItem(at: indexPath) as? ACTagViewCell
    cell?.selected()
    tagDelegate?.tagView?(self, didSelectTagAt: indexPath.item)
  }
  
  func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    
    let cell = collectionView.cellForItem(at: indexPath) as? ACTagViewCell
    cell?.deselected()
    tagDelegate?.tagView?(self, didDeselectTagAt: indexPath.item)
  }

}
