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
  private var redTagView = ACTestView(frame: CGRect(x: 0, y: 100, width: ACScreenWidth, height: 300))
  
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
    
    redTagView.dataSource = self
    redTagView.backgroundColor = UIColor.red
    view.addSubview(redTagView)
    view.backgroundColor = UIColor.white
    
    let tagNibView = Bundle.main.loadNibNamed("GreenTestView", owner: nil, options: nil)?.last as! GreenTestView
    tagNibView.frame = CGRect(x: 0, y: 400, width: ACScreenWidth, height: 200)
    tagNibView.acTagTestView.dataSource = self
    view.addSubview(tagNibView)
    
    automaticallyAdjustsScrollViewInsets = false
    
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
