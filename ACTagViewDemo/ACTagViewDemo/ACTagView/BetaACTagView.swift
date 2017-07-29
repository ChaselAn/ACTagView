//
//  BetaACTagView.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/7/28.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

enum BetaACTagViewLayoutType {
  case autoLineFeed
}

class BetaACTagView: UICollectionView {

  init(frame: CGRect, layoutType: BetaACTagViewLayoutType) {
    var layout: UICollectionViewLayout!
    switch layoutType {
    case .autoLineFeed:
      layout = BetaACTagViewLayout()
    }
    super.init(frame: frame, collectionViewLayout: layout)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
