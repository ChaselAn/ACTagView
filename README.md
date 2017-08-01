# ACTagView

* 2.0版本使用说明请点击此处[2.0使用说明](https://github.com/ChaselAn/ACTagView/blob/master/README(ver2.0.0).md)
* Swift3.0

<img width="250" height="445" src="https://raw.githubusercontent.com/ChaselAn/ACTagView/master/ACTagView.gif"/>

## 安装

### CocoaPods    

```ruby
pod 'ACTagView', '~> 1.2.2'
```

Then, run the following command:

```bash
$ pod install
```

## 使用
### 设置全局属性
```swift
    ACTagManager.shared.selectedTagBackgroundColor = UIColor.white // tag选中背景色
    ACTagManager.shared.selectedTagBorderColor = UIColor.red // tag选中边框颜色
    ACTagManager.shared.selectedTagTextColor = UIColor.red // tag选中文字颜色
    ACTagManager.shared.tagBackgroundColor = UIColor.white // tag背景色
    ACTagManager.shared.tagBorderColor = UIColor.black // tag边框颜色
    ACTagManager.shared.tagTextColor = UIColor.black // tag文字颜色
    ACTagManager.shared.autoLineFeed = true // tag是否自动换行
    ...
```

### 普通展示标签

```swift
let tagStrList: [String] = ["标签1", "标签2", "标签3"]
let tagView = ACTagView(frame: CGRect(x: 0, y: 100, width: 300, height: 50))
tagView.dataSource = self
tagView.tagDelegate = self
tagView.autoLineFeed = true // 是否自动换行，false表示只有一行，横向滑动
tagView.backgroundColor = UIColor.white
view.addSubview(tagView)
```

```swift
extension TestTagViewController: ACTagViewDataSource {
  func numberOfTags(in tagView: ACTagView) -> Int {
    return tagStrList.count
  }
  
  func tagView(_ tagView: ACTagView, tagForIndexAt index: Int) -> ACTag {
    let tag = ACTag()
    tag.setTitle(tagStrList[index], for: .normal)
    return tag
  }
}

extension TestTagViewController: ACTagViewDelegate {
  func tagView(_ tagView: ACTagView, didClickTagAt index: Int, clickedTag tag: ACTag) {
    tag.isSelected = !tag.isSelected
  }
}
```

### 可编辑标签
```swift
let tagStrList: [String] = ["标签1", "标签2", "标签3"]
let tagView = ACTagView(frame: CGRect(x: 0, y: 100, width: 300, height: 50))
tagView.dataSource = self
tagView.tagDelegate = self
let inputTag = ACInputTag()
inputTag.position = .head
tagView.inputTag = inputTag
tagView.autoLineFeed = true // 是否自动换行，false表示只有一行，横向滑动
tagView.backgroundColor = UIColor.white
view.addSubview(tagView)
```

```swift
extension TestTagViewController: ACTagViewDataSource {
  func numberOfTags(in tagView: ACTagView) -> Int {
    return tagStrList.count
  }
  
  func tagView(_ tagView: ACTagView, tagForIndexAt index: Int) -> ACTag {
    let tag = ACTag()
    tag.setTitle(tagStrList[index], for: .normal)
    return tag
  }
}

extension TestTagViewController: ACTagViewDelegate {
  func tagView(_ tagView: ACTagView, didClickTagAt index: Int, clickedTag tag: ACTag) {
    tag.isSelected = !tag.isSelected
  }
  func tagView(_ tagView: ACTagView, inputTagShouldReturnWith inputTag: ACInputTag) -> Bool {
    inputTag.resignFirstResponder()
    guard let text = inputTag.text, !text.isEmpty else { return true }
    
    tagStrList.append(text)
    inputTag.text = ""
    tagView.reloadData()
    return true
  }
}
```