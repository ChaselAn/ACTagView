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
class ACTagTextField: UITextField {
  
  var paddingSize = CGSize.zero
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: self.bounds.height / 2 + paddingSize.width, dy: 0)
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: self.bounds.height / 2 + paddingSize.width, y: 0, width: bounds.width + self.bounds.height / 2 + paddingSize.width, height: bounds.height)
  }
}

class ACTagButton: UIButton {
  
  var selectedBgColor = UIColor.clear
  var selectedBorderColor = UIColor.green
  var selectedTextColor = UIColor.green
  var normalBgColor = UIColor.clear
  var normalBorderColor = UIColor.lightGray
  var normalTextColor = UIColor.black
  
  override var isSelected: Bool {
    didSet {
      if isSelected {
        self.backgroundColor = selectedBgColor
        self.layer.borderColor = selectedBorderColor.cgColor
        self.layer.borderWidth = 1
        self.setTitleColor(selectedTextColor, for: .selected)
      } else {
        self.backgroundColor = normalBgColor
        self.layer.borderColor = normalBorderColor.cgColor
        self.layer.borderWidth = 1
        self.setTitleColor(normalTextColor, for: .normal)
      }
//      self.setNeedsDisplay()
    }
  }
  
}

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
  private func getSizeOfString(_ fontSize: CGFloat, textSize : CGSize) -> CGSize {
    let att = NSMutableAttributedString(string: self)
    let font = UIFont.systemFont(ofSize: fontSize)
    att.addAttributes([NSFontAttributeName: font], range: NSRange(location: 0, length: self.characters.count))
    return att.boundingRect(with: textSize, options: [.usesLineFragmentOrigin,.usesFontLeading], context: nil).size
  }
}
