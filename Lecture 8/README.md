# 8 Animation

本节介绍了iOS中一些动画的使用方式。总体来说，我目前能想到的是多个回调函数嵌套导致的回调地狱。应该有更好的方式来避免这个问题的出现。

# 8.1 动画

本节中介绍了3种动画的调用方式。下面提到的Behavior需要与Animator相关联才能被使用。

1. `UIViewPropertyAnimator.runningPropertyAnimator`：当View的属性发生变化时（例如位置、透明度），可以利用这个动画绘制器完成
2. `UIView.transition`：在变化的过程中会利用options中的预定义方式进行变化
3. `UIDynamicAnimator`：与物理属性相关的动画绘制。例如：
    - `UIGravityBehavior`：重力事件管理
    - `UICollisionBehavior`：碰撞事件管理
    - `UIPushBehavior`：施加力（瞬时、持续两种方式）

# 8.2 闭包捕获

闭包中可以使用`[引用强度 局部变量名 = 表达式]`来声明闭包内的局部变量。例如，可以使用`[weak self]`来捕获`self`，并在闭包内声明其为弱引用，如此来避免`self`的自引用可能。