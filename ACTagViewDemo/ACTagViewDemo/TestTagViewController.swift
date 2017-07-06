//
//  TestTagViewController.swift
//  ACTagViewDemo
//
//  Created by ac on 2017/7/5.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class TestTagViewController: UIViewController {

  fileprivate var totalTagsArr: [String] = ["来来", "范范", "小胖", "jabez", "啊", "圆圆姐", "哈哈哈哈哈哈哈哈哈", "阿萨德浪费卡拉斯科答机房啦送假的佛偈哦哦拉克丝都放假了卡束带结发", "啊", "啊", "啊", "啊", "啊", "啊", "啊", "啊", "啊", "啊", "啊", "啊", "啊",]
  fileprivate var firstTagView = ACTagView(frame: CGRect(x: 0, y: 100, width: ACScreenWidth, height: 50))
  
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
    
    firstTagView.dataSource = self
    firstTagView.tagDelegate = self
    firstTagView.autoLineFeed = false
    firstTagView.backgroundColor = UIColor.white
    view.addSubview(firstTagView)
    view.backgroundColor = UIColor.white
    
    let tagNibView = Bundle.main.loadNibNamed("GreenTestView", owner: nil, options: nil)?.last as! GreenTestView
    tagNibView.frame = CGRect(x: 0, y: 200, width: ACScreenWidth, height: 200)
    tagNibView.acTagTestView.dataSource = self
    tagNibView.acTagTestView.tagDelegate = self
    view.addSubview(tagNibView)
    
    automaticallyAdjustsScrollViewInsets = false
    
  }
  
  @objc private func clickSaveBtn() {
    
  }
  
}

extension TestTagViewController: ACTagViewDataSource {
  func numberOfTags(in tagView: ACTagView) -> Int {
    return totalTagsArr.count
  }
  
  func tagView(_ tagView: ACTagView, tagForIndexAt index: Int) -> ACTag {
    let tag = ACTag()
    tag.setTitle(totalTagsArr[index], for: .normal)
    if tagView != firstTagView {
      tag.borderType = .none
    }
    return tag
  }
}

extension TestTagViewController: ACTagViewDelegate {
  func tagView(_ tagView: ACTagView, didClickTagAt index: Int, clickedTag tag: ACTag) {
    tag.isSelected = !tag.isSelected
  }
}
