//
//  ViewController.swift
//  ACTagViewDemo
//
//  Created by ancheng on 2017/3/3.
//  Copyright © 2017年 ac. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: false)
    switch indexPath.row {
    case 0:
      navigationController?.pushViewController(TagViewController(), animated: true)
//    case 1:
//      navigationController?.pushViewController(EditTagViewController(), animated: true)
//    case 2:
//      navigationController?.pushViewController(EditTagAutoFeedViewController(), animated: true)
    default:
      break
    }
    
  }
}
