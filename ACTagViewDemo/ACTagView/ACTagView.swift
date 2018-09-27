//
//  ACTagView.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/7/28.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

public enum ACTagViewLayoutType {
  case autoLineFeed
  case oneLine
  case custom(ACTagViewFlowLayout)
}

public protocol ACTagViewDataSource: NSObjectProtocol {
  
  func numberOfTags(in tagView: ACTagView) -> Int
  
  func tagView(_ tagView: ACTagView, tagAttributeForIndexAt index: Int) -> ACTagAttribute
  
}

@objc public protocol ACTagViewDelegate: NSObjectProtocol {
  
  @objc optional func tagView(_ tagView: ACTagView, didSelectTagAt index: Int)
  
  @objc optional func tagView(_ tagView: ACTagView, didDeselectTagAt index: Int)
}

open class ACTagView: UIView {
  
  open weak var tagDataSource: ACTagViewDataSource?
  open weak var tagDelegate: ACTagViewDelegate?
  open var tagHeight: CGFloat = ACTagConfig.default.tagDefaultHeight {
    didSet {
      layout.tagHeight = tagHeight
    }
  }
  // 第一个tag距离整个view的上边距和左边距
  open var margin = ACTagConfig.default.tagViewMargin {
    didSet {
      layout.tagViewMargin = margin
    }
  }
  // 两个tag之间的距离
  open var tagMargin = ACTagConfig.default.tagMargin {
    didSet {
      layout.tagMargin = tagMargin
    }
  }
  open var allowsMultipleSelection: Bool = false {
    didSet {
      collectionView?.allowsMultipleSelection = allowsMultipleSelection
    }
  }
  open var isScrollEnabled: Bool = true {
    didSet {
      collectionView?.isScrollEnabled = isScrollEnabled
    }
  }
  open var indexsForSelectedTags: [Int] {
    return collectionView?.indexPathsForSelectedItems?.map({ $0.item }) ?? []
  }
  open var estimatedHeight: CGFloat {
    return calculateSize().height
  }
  open var estimatedSize: CGSize {
    return calculateSize()
  }

  private var collectionView: UICollectionView?
  private var layout: ACTagViewFlowLayout!

  public init(frame: CGRect, layoutType: ACTagViewLayoutType) {
    
    super.init(frame: frame)
    
    initTagView(layoutType: layoutType)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    collectionView?.frame = bounds
  }
  
  // 使用xib创建此控件时，必须调用此方法
  open func initTagView(layoutType: ACTagViewLayoutType) {
    switch layoutType {
    case .autoLineFeed:
      layout = ACTagViewAutoLineFeedLayout()
    case .oneLine:
      layout = ACTagViewOneLineLayout()
    case .custom(let customLayout):
      layout = customLayout
    }
    
    initCollectionView(layout: layout)
  }

  open func selectTag(at index: Int) {
    let indexPath = IndexPath(item: index, section: 0)
    collectionView?.selectItem(at: indexPath, animated: true, scrollPosition: .top)
  }
  
  open func deselectTag(at index: Int) {
    let indexPath = IndexPath(item: index, section: 0)
    let cell = collectionView?.cellForItem(at: indexPath) as? ACTagViewCell
    cell?.deselected()
    collectionView?.deselectItem(at: indexPath, animated: true)
  }
  
  open func tagForIndex(at index: Int) -> ACTagButton? {
    let indexPath = IndexPath(item: index, section: 0)
    return (collectionView?.cellForItem(at: indexPath) as? ACTagViewCell)?.tagButton
  }
  
  open func reloadData() {
    collectionView?.reloadData()
  }
  
  private func initCollectionView(layout: ACTagViewFlowLayout) {
    
    self.layout = layout
    collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
    
    collectionView!.dataSource = self
    collectionView!.delegate = self
    collectionView!.backgroundColor = UIColor.clear
    
    collectionView!.register(ACTagViewCell.self, forCellWithReuseIdentifier: "ACTagViewCell")
    addSubview(collectionView!)
  }
  
  private func calculateSize() -> CGSize {
    return layout.getEstimatedSize(in: self)
  }

}

extension ACTagView: UICollectionViewDataSource {
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tagDataSource?.numberOfTags(in: self) ?? 0
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ACTagViewCell", for: indexPath) as! ACTagViewCell
    guard let tagDataSource = tagDataSource else { return cell }
    cell.tagAttribute = tagDataSource.tagView(self, tagAttributeForIndexAt: indexPath.item)
    return cell
  }
  
}

extension ACTagView: UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    guard let tagDataSource = tagDataSource else { return CGSize.zero }
    let tagAttribute = tagDataSource.tagView(self, tagAttributeForIndexAt: indexPath.item)
    var width = tagAttribute.getWidth(height: tagHeight)
    if width < tagHeight {
      width = tagHeight
    }
    return CGSize(width: width, height: tagHeight)
  }
  
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    let cell = collectionView.cellForItem(at: indexPath) as? ACTagViewCell
    cell?.selected()
    tagDelegate?.tagView?(self, didSelectTagAt: indexPath.item)
  }
  
  public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
    
    let cell = collectionView.cellForItem(at: indexPath) as? ACTagViewCell
    cell?.deselected()
    tagDelegate?.tagView?(self, didDeselectTagAt: indexPath.item)
  }

}
