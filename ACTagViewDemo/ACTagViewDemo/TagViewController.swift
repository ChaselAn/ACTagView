//
//  TagViewController.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/7/7.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class TagViewController: UIViewController {
  
  fileprivate let tagsStrList1 = ["这是一个", "非常长的", "标签非常多的", "可以横向滑动的", "标签页", "啊!"]
  fileprivate let tagsStrList2 = ["这是一个", "精简版的", "标签页", "啊!", "啊！"]
  fileprivate let tagsStrList3 = ["我喜欢", "胸大", "腿长", "瓜子脸", "黑长直", "身材高挑", "会卖萌", "会发嗲", "会做饭", "会洗衣", "的", "男生"]
  
  fileprivate var tagView1 = ACTagView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 50))
  fileprivate var tagView2 = ACTagView(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 100))
  fileprivate var tagView3 = ACTagView(frame: CGRect(x: 0, y: 350, width: UIScreen.main.bounds.width, height: 100))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    automaticallyAdjustsScrollViewInsets = false
    view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    
    setupNormalTagView()
    
  }
  
  private func setupNormalTagView() {
    
    tagView1.backgroundColor = UIColor.white
    tagView1.dataSource = self
    tagView1.tagDelegate = self
    tagView1.autoLineFeed = false
    view.addSubview(tagView1)
    
    tagView2.backgroundColor = UIColor.white
    tagView2.dataSource = self
    tagView2.tagDelegate = self
    view.addSubview(tagView2)
    
    
    tagView3.backgroundColor = UIColor.white
    tagView3.dataSource = self
    tagView3.tagDelegate = self
    view.addSubview(tagView3)
  }

}

extension TagViewController: ACTagViewDataSource {
  func numberOfTags(in tagView: ACTagView) -> Int {
    switch tagView {
    case tagView1:
      return tagsStrList1.count
    case tagView2:
      return tagsStrList2.count
    case tagView3:
      return tagsStrList3.count
    default:
      return 0
    }
  }
  
  func tagView(_ tagView: ACTagView, tagForIndexAt index: Int) -> ACTag {
    let tag = ACTag()
    var list: [String] = []
    switch tagView {
    case tagView1:
      list = tagsStrList1
    case tagView2:
      list = tagsStrList2
      tag.textColor = UIColor.green
      tag.borderColor = UIColor.green
      tag.selectedBackgroundColor = UIColor.red
      tag.selectedTextColor = UIColor.white
      tag.selectedBorderColor = UIColor.white
      tag.borderType = .custom(radius: 5)
    case tagView3:
      list = tagsStrList3
    default:
      break
    }
    tag.setTitle(list[index], for: .normal)
    return tag
  }
}

extension TagViewController: ACTagViewDelegate {
  func tagView(_ tagView: ACTagView, didClickTagAt index: Int, clickedTag tag: ACTag) {
    tag.isSelected = !tag.isSelected
  }
}
