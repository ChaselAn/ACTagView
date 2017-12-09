# ACTagView（2.0.1）

* Swift3.0/Swift4.0
* 此版本暂不支持可编辑标签

<img width="250" height="445" src="https://raw.githubusercontent.com/ChaselAn/ACTagView/master/ACTagView_ver2.0.0.gif"/>

## 安装

### CocoaPods    

* Swift3.0：

```ruby
pod 'ACTagView', '~> 2.0.1'
```

* Swift4.0：

```ruby
pod 'ACTagView', '~> 2.2.4'
```

Then, run the following command:

```bash
$ pod install
```

## 使用
### 设置全局属性
```swift
    ACTagConfig.default.selectedTagBackgroundColor = UIColor.white // tag选中背景色
    ACTagConfig.default.selectedTagBorderColor = UIColor.red // tag选中边框颜色
    ACTagConfig.default.selectedTagTextColor = UIColor.red // tag选中文字颜色
    ACTagConfig.default.tagBackgroundColor = UIColor.white // tag背景色
    ACTagConfig.default.tagBorderColor = UIColor.black // tag边框颜色
    ACTagConfig.default.tagTextColor = UIColor.black // tag文字颜色
    ...
```

### 自动换行的标签View

```swift
let tagsStrList = ["我喜欢", "胸大", "腿长"]
var autoLineFeedTagView = ACTagView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 100), layoutType: .autoLineFeed)
autoLineFeedTagView.tagDataSource = self
autoLineFeedTagView.tagDelegate = self
autoLineFeedTagView.allowsMultipleSelection = true // 是否支持多选
autoLineFeedTagView.backgroundColor = UIColor.white
print(autoLineFeedTagView.estimatedHeight) // 打印预估高度
view.addSubview(autoLineFeedTagView)
```

### 一行标签的View，可横向滚动

```swift
let tagsStrList = ["我喜欢", "胸大", "腿长"]
var oneLineTagView = ACTagView(frame: CGRect(x: 0, y: 300, width: UIScreen.main.bounds.width, height: 50), layoutType: .oneLine)
oneLineTagView.tagDataSource = self
oneLineTagView.tagDelegate = self
oneLineTagView.backgroundColor = UIColor.white
view.addSubview(oneLineTagView)
```

### 数据源及代理
```swift
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
    print("selectedTagsList-----------", tagView.indexsForSelectedTags) // 打印所有已选中标签的下标
  }
  
  func tagView(_ tagView: ACTagView, didDeselectTagAt index: Int) {
    print("deselected------------",index)
  }
  
}
```

### 使用注意
* 使用xib关联时，必须在`awakeFromNib`方法中调用标签View的`initTagView(layoutType: ACTagViewLayoutType)`方法