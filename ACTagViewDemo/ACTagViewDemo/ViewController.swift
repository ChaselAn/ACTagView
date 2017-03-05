//
//  ViewController.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/3/3.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tagsLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func clickSetTagBtn(_ sender: UIButton) {
    self.navigationController?.pushViewController(TagViewController(), animated: true)
    
  }

}

