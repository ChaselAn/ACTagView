//
//  EditTagViewController.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/7/7.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class EditTagViewController: UIViewController {
  
  fileprivate var tagsStrList1 = ["这是一个", "非常长的", "标签非常多的", "可以横向滑动的", "标签页", "啊!"]
  fileprivate var tagsStrList2 = ["你愁啥"]
  fileprivate var tagsStrList3 = ["我喜欢", "胸大", "腿长", "瓜子脸", "黑长直", "身材高挑", "会卖萌", "会发嗲", "会做饭", "会洗衣", "的", "男生"]
  
  fileprivate var tagView1 = ACTagView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 50))
  fileprivate var tagView2 = ACTagView(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 50))
  fileprivate var tagView3 = ACTagView(frame: CGRect(x: 0, y: 300, width: UIScreen.main.bounds.width, height: 50))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    automaticallyAdjustsScrollViewInsets = false
    view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    
    setupTagView()
    
  }
  
  private func setupTagView() {
    
    tagView1.backgroundColor = UIColor.white
    tagView1.dataSource = self
    tagView1.tagDelegate = self
    tagView1.autoLineFeed = false
    let inputTag1 = ACInputTag()
    inputTag1.position = .head
    tagView1.inputTag = inputTag1
    view.addSubview(tagView1)
    
    tagView2.backgroundColor = UIColor.white
    tagView2.dataSource = self
    tagView2.tagDelegate = self
    tagView2.autoLineFeed = false
    let inputTag2 = ACInputTag()
    inputTag2.borderType = .fullLine(cornerRadius: 5)
    inputTag2.borderColor = UIColor.green
    inputTag2.placeholderColor = UIColor.red
    inputTag2.textColor = UIColor.green
    tagView2.inputTag = inputTag2
    view.addSubview(tagView2)
    
    tagView3.backgroundColor = UIColor.white
    tagView3.dataSource = self
    tagView3.tagDelegate = self
    tagView3.autoLineFeed = false
    let inputTag3 = ACInputTag()
    inputTag3.position = .head
    inputTag3.borderType = .circleWithFullLine
    inputTag3.maxWordCount = 5
    tagView3.inputTag = inputTag3
    view.addSubview(tagView3)
  }
  
}

extension EditTagViewController: ACTagViewDataSource {
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

extension EditTagViewController: ACTagViewDelegate {
  func tagView(_ tagView: ACTagView, didClickTagAt index: Int, clickedTag tag: ACTag) {
    tag.isSelected = !tag.isSelected
  }
  
  func tagView(_ tagView: ACTagView, inputTagShouldReturnWith inputTag: ACInputTag) -> Bool {
    inputTag.resignFirstResponder()
    guard let text = inputTag.text, !text.isEmpty else { return true }
    if tagView == tagView1 {
      tagsStrList1.insert(text, at: 0)
    }
    if tagView == tagView2 {
      tagsStrList2.append(text)
    }
    if tagView == tagView3 {
      tagsStrList3.insert(text, at: 0)
    }
    
    inputTag.text = ""
    tagView.reloadData()
    return true
  }
}
