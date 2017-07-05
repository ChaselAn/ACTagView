//
//  TestTagViewController.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/7/5.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class TestTagViewController: UIViewController {

  
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
    
    let tagView = ACTestView(frame: CGRect(x: 0, y: 100, width: ACScreenWidth, height: 300))
    tagView.dataSource = self
    tagView.backgroundColor = UIColor.red
    view.addSubview(tagView)
    view.backgroundColor = UIColor.white
  }
  
  @objc private func clickSaveBtn() {
    
  }
  
}

extension TestTagViewController: ACTestViewDataSource {
  func numberOfTags(in tagView: ACTestView) -> Int {
    return totalTagsArr.count
  }
  
  func tagView(_ tagView: ACTestView, tagForIndexAt index: Int) -> ACTag {
    let tag = ACTag()
    tag.setTitle(totalTagsArr[index], for: .normal)
    return tag
  }
}
