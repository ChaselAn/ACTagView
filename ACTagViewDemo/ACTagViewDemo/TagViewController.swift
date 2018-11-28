//
//  TagViewController.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/7/7.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit
import ACTagView

class TagViewController: UIViewController {
  
  fileprivate let tagsStrList = ["我喜欢", "胸大", "腿长", "瓜子脸", "黑长直", "身材高挑", "会卖萌", "会发嗲", "会做饭", "会洗衣", "的", "男生"]

  private var autoLineFeedTagView = ACTagView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 100), layoutType: .autoLineFeed)
  private var oneLineTagView = ACTagView(frame: CGRect(x: 0, y: 250, width: UIScreen.main.bounds.width, height: 50), layoutType: .oneLine)
  private var oneLineTagViewNoScroll = ACTagView(frame: CGRect(x: 0, y: 350, width: UIScreen.main.bounds.width, height: 50), layoutType: .oneLine)

    private var testButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    automaticallyAdjustsScrollViewInsets = false
    view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    
    setupNormalTagView()

    testButton.frame = CGRect(x: 100, y: 550, width: 50, height: 50)
    testButton.setTitle("test", for: .normal)
    testButton.addTarget(self, action: #selector(testDidClicked), for: .touchUpInside)
    view.addSubview(testButton)

  }

    @objc private func testDidClicked() {
        oneLineTagView.clipsToBounds = true
        oneLineTagView.layoutType = .autoLineFeed

        UIView.animate(withDuration: 0.25) {
            self.oneLineTagView.frame.size.height = self.oneLineTagView.estimatedSize.height
        }
    }
  
  private func setupNormalTagView() {
    
    autoLineFeedTagView.tagDataSource = self
    autoLineFeedTagView.tagDelegate = self
    autoLineFeedTagView.allowsMultipleSelection = true
    autoLineFeedTagView.backgroundColor = UIColor.white
    print(autoLineFeedTagView.estimatedSize)
    view.addSubview(autoLineFeedTagView)
    
    oneLineTagView.tagDataSource = self
    oneLineTagView.tagDelegate = self
    oneLineTagView.backgroundColor = UIColor.white
    print(oneLineTagView.estimatedSize)
    view.addSubview(oneLineTagView)
    
    oneLineTagViewNoScroll.tagDataSource = self
    oneLineTagViewNoScroll.tagDelegate = self
    oneLineTagViewNoScroll.backgroundColor = UIColor.white
    oneLineTagViewNoScroll.isScrollEnabled = false
//    view.addSubview(oneLineTagViewNoScroll)
  }

}

extension TagViewController: ACTagViewDataSource {
  func numberOfTags(in tagView: ACTagView) -> Int {
    return tagsStrList.count
  }
  
  func tagView(_ tagView: ACTagView, tagAttributeForIndexAt index: Int) -> ACTagAttribute {
    let tag = ACTagAttribute(text: tagsStrList[index])
    return tag
  }
}

extension TagViewController: ACTagViewDelegate {
  
  func tagView(_ tagView: ACTagView, didSelectTagAt index: Int) {
    print(index)
    print("selectedTagsList-----------", tagView.indexsForSelectedTags)
  }
  
  func tagView(_ tagView: ACTagView, didDeselectTagAt index: Int) {
    print("deselected------------",index)
  }
  
}
