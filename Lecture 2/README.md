# 2 MVC

本节介绍了MVC模式，并将前一节中的代码修改为了MVC模式。具体来说，是设计了Card和Concentration类代表Model，而ViewController代表Controller，UIKit下的类代表View。分离了Model和Controller，降低了程序耦合。

# 2.1 MVC

目前接触到的，Controller与View通过outlet与action进行交互（对应IBOutlet和IBAction）；Model与Controller通过接口调用交互；Model和View永不直接进行交互。

其他的，例如data source、KVO (KeyValueObserving)、delegate，目前还未接触到。等接触到在做补充。

![2%20MVC%20e1b9476a05e643ff95f55be623303864/Untitled.png](figures/MVC.png)

# 2.2 随机数

- 参考资料
    - [使用arc4random()、arc4random_uniform()取得随机数](https://www.jianshu.com/p/51269165c3e0)
    - [arc4random(3) - OpenBSD manual pages](https://man.openbsd.org/arc4random.3)
    - [iOS--随机数rand、random、arc4random](https://www.jianshu.com/p/106475cbd3da)
- arc4random相对于其他的随机函数，是高精度的随机数发生器。arc4random.*这些函数不需要种子。这些函数是来自于BSD的，可以看到是C.stdlib库下的
- `arc4random(void)`这个全局函数会生成最大0x100000000 (4294967296)的随机整数
- `arc4random_buf(void *buf, size_t nbytes)`将整个nbytes指定的区域随机初始化（看起来不太会用到）
- `arc4random_uniform(uint32_t)`会随机返回一个0到上界之间（不含上界）的整数

# 2.3 struct与class

struct变量总是按值取用，class则是引用，这一点上和C#一致。或是可以对应C++中普通类型和指针。

但是也导致了一个问题：若是设置一个集合中struct的值，总是需要`collection[i].property = ...`来取用，不能使用`var item = collection[i]`来简化，算是有些麻烦，不知道有没有更好的方法。

# 2.4 `,` & `&&`

- 参考资料
    - [Separating multiple if conditions with commas in Swift](https://stackoverflow.com/questions/44989227/separating-multiple-if-conditions-with-commas-in-swift)

两者的区别在于：利用`if let a = ..., b = ...` 声明时，a在整个if block中有效；而利用`&&`，则在if block中a生命周期已结束，a为未定义状态。

对于本程序中的情况（`if emoji[card.identifier] == nil, emojiChoices.count > 0`），两者无区别。
