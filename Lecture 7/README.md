# 7 Multiple MVCs, Timer, and Animation

# 7.1 UINavigationController

栈式结构，每转入新的View就将原有MVC压入栈中。主要表示递进关系，会在左上角添加一个返回按钮。

可以使用两个函数实现向`UINavigationController`中增加或减少`View`：

```swift
// 压入View
func pushViewController(_ vc: UIViewController, animated: Bool)

// 弹出View
func popViewController(animated: Bool)
```

# 7.2 UISplitViewController

左右式的结构，主要是用于大屏设备上的显示（如iPad上设置的显示方式）。

左侧称为master view，右侧称为detail view。从名字中就能看到，左侧大多数是菜单类型的View，右侧则是点击菜单条目时显示的具体的View。

UISplitViewController能在大屏和小屏设备上自动适应，在大屏上为左右式，小屏上则每次只显示一个View。

# 7.3 UITabBarController

下方多个tab的显示方式，如App Store中的分类方式。

这个View比较简单，一个tab对应一个Controller，可以添加多个来表示并列关系。

# 7.4 获得子MVC的方式

`ViewController`中有`viewControllers`变量来代表子`Controller`集合。

```swift
var viewControllers: [UIViewController]? { get set }
```

- 对于UISplitViewController，[0]是master，[1]是detail
- 对于UITabBarController，是从左到右的view
- 对于UINavigationController，[0]是root，其他的依次是栈中的view

# 7.5 Segue

可以在storyboard中创建segue来建立ViewController之间的联系。

需要主要的是，在创建segue后，需要指定每个segue的identifier，并重写segue发起方的prepare函数处理segue。例如以下代码就处理了`segue.identifier`为`"Show Graph"`的事件：

```swift
func prepare(for segue: UIStoryboardSegue, sender: Any?) {
	if let identifier = segue.identifier {
		switch identifier {
		case “Show Graph”:
			if let vc = segue.destination as? GraphController {
				vc.property1 = ...
				vc.callMethodToSetItUp(...)
			}
    default: break
	  }
	}
}
```

# 7.6 Timer

`Timer`类中创建`Timer`对象的函数是：

```swift
class func scheduledTimer(
      withTimeInterval: TimeInterval,
      repeats: Bool,
      block: (Timer) -> Void
) -> Timer
```

可以这样来使用：

```swift
var timer = Timer.scheduledTimer(
	withTimeInterval: 2.0, 
	repeats: true) 
	{ timer in
		// code here
	}
```

可以使用`timer.invalidate()`来停止timer的继续执行。

可以使用`timer.tolerance = SECONDS`来设置timer最多运行的延迟执行时间（为了省电）。

# 7.7 `@objc`的作用

- 参考资料：[https://www.cnblogs.com/yangzigege/p/8683097.html](https://www.cnblogs.com/yangzigege/p/8683097.html)

Swift在编译器就能确定哪些函数会被使用，哪些不会。这样就会去除无效的函数。但是OC的函数调用是基于消息的，所以Swift无法得知那些被OC代码调用的函数。如此，可能在编译器需要的函数被优化掉了。**加入@objc就是为了保留可能被OC调用的函数。**