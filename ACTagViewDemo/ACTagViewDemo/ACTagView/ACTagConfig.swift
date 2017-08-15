//
//  ACTagConfig.swift
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

public enum ACInputTagBorderState {
  case none
  case fullLine(cornerRadius: CGFloat)
  case dashLine(cornerRadius: CGFloat, lineDashPattern: [NSNumber])
  case circleWithFullLine
  case circleWithDashLine(lineDashPattern: [NSNumber])
}

public class ACTagConfig {
  
  public static let `default` = ACTagConfig()
  
  public var tagBorderWidth: CGFloat = 1
  public var tagBorderType = ACTagBorderType.halfOfCircle
  public var tagMarginSize = CGSize(width: 10, height: 10)
  public var tagPaddingSize = CGSize.zero
  public var tagFont = UIFont.systemFont(ofSize: 14)
  
  public var selectedTagBackgroundColor = UIColor.white
  public var selectedTagBorderColor = UIColor.red
  public var selectedTagTextColor = UIColor.red
  public var tagBackgroundColor = UIColor.white
  public var tagBorderColor = UIColor.black
  public var tagTextColor = UIColor.black
  
  public var tagHeight: CGFloat = 30
  
  public var inputTagBackgroundColor = UIColor.white
  public var inputTagBorderType = ACInputTagBorderState.circleWithDashLine(lineDashPattern: [3, 3])
  public var inputTagPaddingSize = CGSize.zero
  public var inputTagFontSize: CGFloat = 14
  public var inputTagBorderColor = UIColor.black
  
}
