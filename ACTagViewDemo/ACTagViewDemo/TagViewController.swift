//
//  TagViewController.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/3/3.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit


class TagViewController: UIViewController {
  
  fileprivate var totalTagsArr: [String] = ["来来", "范范", "小胖", "jabez", "圆圆姐", "哈哈哈哈哈哈哈哈哈"]
  
  private var inputTagBgViewHeight: CGFloat = 50
  
//  private var tableView = UITableView()
  private var inputTagBgView = UIView()
  fileprivate var inputTagView = ACTagView(type: .haveInputTag)
  fileprivate var inputTagView1 = ACTagView(type: .haveInputTag)
//  fileprivate var inputTagView = ACHistoryTagView()
//  fileprivate var cellHeight: CGFloat = 44
  
  fileprivate var totalTagView = ACTagView(type: .normal)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "标签"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(clickSaveBtn))
    
    setupUI()
  }
  
  private func setupUI() {
    
    view.backgroundColor = UIColor.white
    
    view.addSubview(inputTagView)
    inputTagView.frame = CGRect(x: 0, y: 64, width: ACScreenWidth, height: inputTagBgViewHeight)
    inputTagView.backgroundColor = UIColor.yellow
//    inputTagView.addTags(selectedTagsArr)
    
    view.addSubview(inputTagView1)
    inputTagView1.frame = CGRect(x: 0, y: inputTagView.frame.maxY, width: ACScreenWidth, height: 80)
    inputTagView1.addTags(["魏来"])
    inputTagView1.tagDelegate = self
    
    view.addSubview(totalTagView)
//    totalTagView.frame = CGRect(x: 0, y: inputTagBgView.frame.maxY, width: ACScreenWidth, height: ACScreenHeight - inputTagBgViewHeight - 64)
    totalTagView.frame = CGRect(x: 0, y: inputTagView1.frame.maxY, width: ACScreenWidth, height: 50)
    totalTagView.addTags(totalTagsArr)
    totalTagView.setDefaultSelectedTags(["魏来"])
    totalTagView.tagDelegate = self
    totalTagView.backgroundColor = UIColor.red
    
  }
  
  @objc private func clickSaveBtn() {
    
  }
  
}

extension TagViewController: ACTagViewDelegate {
  
  
  // 实现联动
  func tagView(_ tagView: ACTagView, didClickedTagAt index: Int, tagStr: String, tagState: ACTagView.TagBtnState) {
    
    if tagView == inputTagView1 {
      tagView.removeTag(tagStr)
      totalTagView.clickTag(tagStr)
    }else if tagView == totalTagView {
      if tagState == .turnOn {
        inputTagView1.addTag(tagStr)
      }else if tagState == .turnOff {
        inputTagView1.removeTag(tagStr)
      }
    }
    print("----totalView-----", totalTagView.selectedTagStrs)
    print("----inputView-----", inputTagView1.selectedTagStrs)
    
  }
}
