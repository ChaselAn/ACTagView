//
//  ACUtil.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/3/3.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

let ACScreenWidth = UIScreen.main.bounds.width
let ACScreenHeight = UIScreen.main.bounds.height

extension String{
  
  /**
   得到文字宽度
   
   - parameter fontSize: 字号
   - parameter height: 字符串最大高度
   - returns: 宽度值
   */
  func ac_getWidth(_ fontSize : CGFloat, height: CGFloat = 0) -> CGFloat {
    
    let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
    return getSizeOfString(fontSize, textSize: size).width + 1
  }
  /**
   得到文字高度
   
   - parameter fontSize: 字号
   - parameter width: 字符串最大宽度
   - returns: 高度值
   */
  func ac_getHeight(_ fontSize: CGFloat, width: CGFloat) -> CGFloat {
    
    let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
    return getSizeOfString(fontSize, textSize: size).height
  }
  
  // 计算文字宽高的辅助方法
  private func getSizeOfString(_ fontSize: CGFloat, textSize: CGSize) -> CGSize {
    let att = NSMutableAttributedString(string: self)
    let font = UIFont.systemFont(ofSize: fontSize)
    att.addAttributes([NSAttributedString.Key.font: font], range: NSRange(location: 0, length: count))
    return att.boundingRect(with: textSize, options: [.usesLineFragmentOrigin,.usesFontLeading], context: nil).size
  }
}
