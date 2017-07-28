//
//  BetaACTagView.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/7/28.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

enum BetaACTagViewLayoutType {
  case sca
}

class BetaACTagView: UICollectionView {

  init(frame: CGRect, layoutType: BetaACTagViewLayoutType) {
    
    super.init(frame: frame, collectionViewLayout: <#T##UICollectionViewLayout#>)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
