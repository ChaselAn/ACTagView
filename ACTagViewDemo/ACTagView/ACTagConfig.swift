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

public struct ACTagDistance {
  
  public var horizontal: CGFloat
  public var vertical: CGFloat
  
  public static var zero: ACTagDistance {
    return ACTagDistance(horizontal: 0, vertical: 0)
  }
  
  public init(horizontal: CGFloat, vertical: CGFloat) {
    self.horizontal = horizontal
    self.vertical = vertical
  }
}

//public enum ACInputTagBorderState {
//  case none
//  case fullLine(cornerRadius: CGFloat)
//  case dashLine(cornerRadius: CGFloat, lineDashPattern: [NSNumber])
//  case circleWithFullLine
//  case circleWithDashLine(lineDashPattern: [NSNumber])
//}

public class ACTagConfig {
  
  public static let `default` = ACTagConfig()
  
  public var tagBorderWidth: CGFloat = 1
  public var tagBorderType = ACTagBorderType.halfOfCircle
  public var tagViewMargin = ACTagDistance(horizontal: 10, vertical: 10)
  public var tagMargin = ACTagDistance(horizontal: 10, vertical: 10)
  public var tagHorizontalPadding: CGFloat = 15
  public var tagFont = UIFont.systemFont(ofSize: 14)
  
  public var selectedTagBackgroundColor = UIColor.white
  public var selectedTagBorderColor = UIColor.red
  public var selectedTagTextColor = UIColor.red
  public var tagBackgroundColor = UIColor.white
  public var tagBorderColor = UIColor.black
  public var tagTextColor = UIColor.black
  
  public var tagDefaultHeight: CGFloat = 30
  
//  public var inputTagBorderType = ACInputTagBorderState.circleWithDashLine(lineDashPattern: [3, 3])
//  public var inputTagPaddingSize = CGSize.zero
//  public var inputTagFontSize: CGFloat = 14
//  public var inputTagBorderColor = UIColor.black
  
}
