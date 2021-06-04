# 3 Swift Programming Language

可以查看Swift官网的tour来获取最新的特性：[https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html](https://docs.swift.org/swift-book/GuidedTour/GuidedTour.html)

# 3.1 Range

使用stride(from:**through**:by:)来获得带步长的CountableRange：

```swift
for i in stride(from: 0.5, through: 25.5, by: 0.1) {}
```

使用stride(from:**to**:by:)来获得带步长的ClosedCountableRange：

```swift
for i in stride(from: 0.5, to: 25.5, by: 0.1) {}
```

这两者的区别在于CountableRange左闭右开，ClosedCountableRange左闭右闭。

# 3.2 Tuple

Swift的tuple支持命名：

```swift
let x: (a: String, b: Int, c: Double) = ("a", 1, 2)
```

这样就可以使用`x.a`的方式获取"a"。**Swift鼓励对Tuple命名。**

还有将函数的返回值设置为tuple的方法：

```swift
func getSize() -> (weight: Double, height: Double) { return (250, 80) }
```

# 3.3 权限控制

- private：外部不可见
- private(set)：外部只读，不可写
- internal：本framework可见可写
- fileprivate：本文件可见可写
- public：所有地方都可访问，但是在本framework外不可继承和覆写
- open：public，并且可以被framework外继承

# 3.4 extension

可以在class/struct/enum的声明外添加函数/变量。

1. 变量只能是计算变量
2. 不能覆写已经存在的函数/变量

需要注意的是，extension的适用面比较小，只适用于添加一些helper函数，不应该用extension代替OOD。

# 3.5 enum

enum中可以定义**函数**和**计算变量**，但是不能定义**存储变量**。

enum的case中可以定义**关联数据**（个人理解为每个case自己的存储变量），如下：

```swift
enum FastFoodMenuItem {
    case hamburger(numberOfPatties: Int)
    case fries(size: FryOrderSize)
		// the unnamed String is the brand, e.g. “Coke”
		case drink(String, ounces: Int) 
		case cookie 
}
```

在使用switch时，可以利用**let**来获取关联数据。值得注意的是，**let**定义的变量名称不一定与case声明时一致：

```swift
switch menuItem {
      case .hamburger(let pattyCount): print("a burger with \(pattyCount) patties!")
      case .fries(let size): print("a \(size) order of fries!")
      case .drink(let brand, let ounces): print("a \(ounces)oz \(brand)")
      case .cookie: print("a cookie!")
}
```

由于enum与struct是**值类型（value type）**，若要在enum定义的函数中修改自己，需要使用`mutating`关键字。

Swift中的Optional就是一个enum泛型。Optional有none和some两种case。none对应nil，some对应拆包后的值。

# 3.6 内存管理

Swift中使用automatic reference counting（ARC）而不是GC（这点类似C++中的智能指针）。

## 3.6.1 引用强度

- 参考资料：[Swift: 对于weak、unowned的理解](https://blog.csdn.net/jancywen/article/details/92419895)
- strong：默认
- weak：仅为Optional，若该对象以析构，则设为nil
- unowned：在block块内再次获取值时依然是对象本身，只是该对象可能被释放了，因此调用者必须保证在执行block块时该对象一定依然存在，不然调用对象的方法时会造成崩溃。