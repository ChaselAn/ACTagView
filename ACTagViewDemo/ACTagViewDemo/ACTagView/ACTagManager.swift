//
//  ACTagManager.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/7/5.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

public enum ACTagBorderType {
  case none
  case halfOfCircle
  case custom(radius: CGFloat)
}

public class ACTagManager {
  
  static let shared = ACTagManager()
  
  public var tagBorderWidth: CGFloat = 1
  public var tagBorderType = ACTagBorderType.halfOfCircle
  public var tagMarginSize = CGSize(width: 10, height: 10)
  public var tagPaddingSize = CGSize(width: 0, height: 0)
  public var tagFontSize: CGFloat = 14
  
  public var selectedTagBackgroundColor = UIColor.clear
  public var selectedTagBorderColor = UIColor.green
  public var selectedTagTextColor = UIColor.green
  public var tagBackgroundColor = UIColor.clear
  public var tagBorderColor = UIColor.lightGray
  public var tagTextColor = UIColor.black
  
  public var tagDefaultHeight: CGFloat = 30
  
}
