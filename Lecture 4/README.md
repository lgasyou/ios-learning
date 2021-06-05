# 4 More Swift

# 4.1 Protocol

- 参考资料：
    - [Compare Protocol in Swift vs Interface in Java](https://stackoverflow.com/questions/30859334/compare-protocol-in-swift-vs-interface-in-java)
    - [How to define optional methods in Swift protocol?](https://stackoverflow.com/questions/24032754/how-to-define-optional-methods-in-swift-protocol)

**注：**这里区别部分资料比较旧，可能还有其他区别，之后遇到再补充。

## 4.1.1 Protocol与Java中interface的不同

protocol中只能有函数和计算变量。与其他语言（以Java为例）中的interface关键字类似，但是有以下3点不同：

1. protocol中也可以声明计算变量；
2. 当函数的实现者（可能为enum, class, struct）在函数内部发生变化时，需要添加`mutating`关键字。这对于实现者仅为class时的情况不是必须的，但是Swift风格上一般认为protocol可以被所有类型实现，因此一般要求添加`mutating`；
3. 可以利用Protocol Composition，如下：

```swift
func wishHappyBirthday(to celebrator: Named & Aged) {}
```

## 4.1.2 默认实现

较新版的Java中，interface支持默认值和函数的默认实现，Swift中也有对应的方法。

1. protocol中可以将某个函数或变量声明为`optional`，代表实现可以选择性实现该函数/变量。但是这样需要标记`@objc`，并将实现继承自`NSObject`。此方法较老。
2. 利用extension，如下所示：

```swift
protocol MyProtocol {
    func doSomething()
}

extension MyProtocol {
    func doSomething() {
        /* return a default value or just leave empty */
    }
}

struct MyStruct: MyProtocol {
    /* no compile error */
}
```

# 4.2 Delegation

- 参考资料：[Swift的代理delegate](https://www.jianshu.com/p/c65f13683001)

一种无需双方互相知道的交流方式。

在MVC模式中，通常是View将某个property声明为Optional，之后在Controller中设置该property，最后View调用该property完成整个委托。

需要注意的是，委托的property一般是**weak**的，防止循环调用的产生。

# 4.3 String

Swift的String比较特别，不能直接使用subscript来取得对应的字符，而是要首先利用`String.index`、`String.startIndex`等函数获得`String.Index`，再使用subscript获取具体的Character。

若要获取子字符串，则利用subscript即可，例如`str[..<str.endIndex]`。

# 4.4 NSAttributedString

- 参考资料：[What does the NS prefix mean?](https://stackoverflow.com/questions/473758/what-does-the-ns-prefix-mean)

NSAttributedString是带有属性的字符串。例如可以调整字体、颜色和字符的大小。

用于在程序中动态的调整字符风格。

其对应的属性为`NSAttributedString.Key`，而不是`NSAttributedStringKey`。

- 关于NS前缀：是从**NeXTSTEP**系统库中延续下来的。目前苹果的所有操作系统都使用了该库。

# 4.5 函数类型

- 参考资料：[https://docs.swift.org/swift-book/LanguageGuide/Closures.html](https://docs.swift.org/swift-book/LanguageGuide/Closures.html)

**注：**这里介绍的较为基础的闭包使用，之后需要更深入地阅读以上文档。

Swift中函数是“一等公民”，称为函数类型。函数变量可以被**赋值**和**调用**。

由于支持函数式编程，因此Swift中也有Lambda表达式（闭包）。标准语法为：

```swift
{ (形参1: 形参1类型，形参2: 形参2类型, ...) -> 返回值类型 in
		Lambda内部表达式
}
```

若是不关注类型和参数名称，则可以使用`$0`, `$1`代替`形参1`, `形参2`，并去除返回值类型和`in`。

另外，若是函数变量作为另一个函数的参数，并且是参数列表的最后一个，则可以将Lambda的声明移到圆括号外（同Kotlin）：

```swift
func a(b: Int, f: (Int) -> Int) {
		print(f(b))
}

a(b: 1) { -$0 }
```

以上调用结果输出`-1`。

同其他语言，Swift的闭包中可以捕获外部的变量。