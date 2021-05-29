# 1 Introduction to iOS 11, Xcode 9 and Swift 4

本节主要是介绍了iOS开发中的基础，例如Xcode和Swift。另外构建了简单的Concentration程序。视频中Xcode 9和我使用的12.5变化比较大；Swift也有一些变化，例如`Arrary.index(of:)` 已经弃用，现在使用`firstIndex`或者`lastIndex`替代。

# 1.1 IBOutlet & IBAction

- 参考资料
    - [IBOutlet与IBAction的理解](https://blog.csdn.net/kicinio/article/details/109630116)
- IB: Interface Builder
- IBOutlet相当于Android中的`findViewById`，是为了能在代码中获取UI的控件
- IBAction代表动作，相当于Android中的`setOnXXX`函数。对于Button，这里的配置相当于Android中的`Button.setOnClickListener`

# 1.2 willSet & didSet

- 参考资料
    - [Swift中willSet和didSet的简述](https://www.jianshu.com/p/a709ba98aad9)

Swift中除了其他语言中property常见的setter和getter，还有willSet和didSet。我个人理解为设置前和设置后的回调函数。也许实现上和Python里面的函数装饰器类似？

willSet中利用`newValue`代表即将设置的值，didSet中使用`oldValue`代表之前的值。

# 1.3 ! & ?

- 参考资料
    - [Swift中 ！和 ？的区别及使用](https://www.jianshu.com/p/89a2afb82488)

!和?都可以加在变量声明时类型和变量上。

## 1.3.1 !

- 加在类型上：代表该变量可以为空，但是使用隐式拆包，使用该变量时方法与基础类型一致
- 加在变量上：与?配合使用，代表显式拆包

## 1.3.2 ?

- 加在类型上：代表该变量可以为空
- 加在变量上：代表仅在该变量不为空是使用，否则不会调用该表达式