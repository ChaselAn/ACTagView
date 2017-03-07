# ACTagView

* Swift3.0

![](http://7xte1z.com1.z0.glb.clouddn.com/ACTagView.gif)

#### ACTagView

* 不含输入框的普通标签View
* 使用方法：

```swift
	var totalTagsArr = ["来来", "范范", "小胖", "jabez", "圆圆姐", "哈哈哈哈哈哈哈哈哈"]
	let totalTagView = ACTagView()
    view.addSubview(totalTagView)
    totalTagView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
    totalTagView.backgroundColor = UIColor.red
    totalTagView.addTags(totalTagsArr)
    totalTagView.setDefaultSelectedTags(["来来"])
    //totalTagView.tagDelegate = self
```

* 获取全部标签以及选中的标签：

```swift
	print("----totalTag-----", totalTagView.tagsArr)
    print("----selectedTag-----", totalTagView.selectedTagsArr)
```

* 可以自定义非选中以及选中的标签的字体、背景、边框颜色，可以自定义标签高度、字体大小、标签外边距、内边距。
* 标签默认不被选中，点击后被选中，再次点击取消选中
* `func addTags(_ tags: [String])` ：添加标签数组
* `func addTag(_ tag: String)` ：添加单个标签
* `func clickTag(_ tag: String)` ：通过代码点击某个标签
* `func setDefaultSelectedTags(_ deFaultTagStrs: [String])` ：默认选中的标签
* `func setDefaultSelectedTagsIndex(_ defaultIndex: [Int])` ：通过下标默认选中标签
* 暂不支持删除方法（微信是没有的，同时考虑到数据的联动多样性的需求）


#### ACInputTagView

* 带输入框的标签View
* 使用方法：

```swift
	let inputTagView = ACInputTagView()
    view.addSubview(inputTagView)
    inputTagView.frame = CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: inputTagBgViewHeight)
    inputTagView.backgroundColor = UIColor.yellow
    inputTagView.addTags(["来来"])
    //inputTagView.tagDelegate = self
```

* 可以自定义标签的字体、背景、边框颜色，可以自定义标签高度、字体大小、标签外边距、内边距。
* 可以自定义输入框的最大字数、占位字、字体大小、背景颜色、字体颜色、边框样式。
* 标签只有选中状态，点击标签被删除
* 输入框输入完成后自动生成新标签。
* 获取全部标签：

```swift
	print("----totalTag-----", inputTagView.tagsArr)
```

* `func addTags(_ tags: [String])` ：添加标签数组
* `func addTag(_ tag: String)` ：添加单个标签
* `func removeTag(_ tag: String)` ：删除单个标签
* `func removeTag(by index: Int)` ：通过下标删除单个标签

#### ACTagView和ACInputTagView的联动

```swift
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
```
