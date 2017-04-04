//
//  TagViewController.swift
//  ACTagCommonViewDemo
//
//  Created by ancheng on 2017/3/3.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit


class TagViewController: UIViewController {
  
  fileprivate var totalTagsArr: [String] = ["来来", "范范", "小胖", "jabez", "圆圆姐", "哈哈哈哈哈哈哈哈哈"]
  
  private var inputTagBgViewHeight: CGFloat = 50
  
  private var inputTagBgView = UIView()
  fileprivate var inputTagView = ACInputTagView()
  
  fileprivate var totalTagView = ACTagView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "标签"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(clickSaveBtn))
    
    setupUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  private func setupUI() {
    
    self.automaticallyAdjustsScrollViewInsets = false
    view.backgroundColor = UIColor.white
    
    view.addSubview(inputTagView)
    inputTagView.frame = CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: inputTagBgViewHeight)
    inputTagView.backgroundColor = UIColor.yellow
    inputTagView.tagCornerRadius = .halfOfCircle
    inputTagView.isScrollToLast = true
    inputTagView.addTags(["来来"])
    inputTagView.tagDelegate = self
    
    view.addSubview(totalTagView)
//    totalTagView.frame = CGRect(x: 0, y: inputTagView.frame.maxY, width: UIScreen.main.bounds.width, height: ACScreenHeight - inputTagBgViewHeight - 64)
    totalTagView.frame = CGRect(x: 0, y: inputTagView.frame.maxY, width: UIScreen.main.bounds.width, height: 70)
    totalTagView.isScrollToLast = true
    totalTagView.addTags(totalTagsArr)
    totalTagView.setDefaultSelectedTags(["来来"])
    totalTagView.tagDelegate = self
    totalTagView.backgroundColor = UIColor.red
    
  }
  
  @objc private func clickSaveBtn() {
    
  }
  
}

extension TagViewController: ACTagViewDelegate {
  
  // 实现联动
  func tagView(_ tagView: ACTagView, didClickedTagAt index: Int, tagStr: String, tagState: ACTagView.TagBtnState) {
    
    if tagState == .turnOn {
      inputTagView.addTag(tagStr)
    }else if tagState == .turnOff {
      inputTagView.removeTag(tagStr)
    }
    print("----totalView-----", totalTagView.selectedTagsArr)
    print("----inputView-----", inputTagView.tagsArr)
    
  }
}

extension TagViewController: ACInputTagViewDelegate {
  
  // 实现联动
  func tagView(_ tagView: ACInputTagView, didClickedTagAt index: Int, tagStr: String) {
    
    tagView.removeTag(tagStr)
    totalTagView.clickTag(tagStr)
    print("----totalView-----", totalTagView.selectedTagsArr)
    print("----inputView-----", inputTagView.tagsArr)
    
  }
}

