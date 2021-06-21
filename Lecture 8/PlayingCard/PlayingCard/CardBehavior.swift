//
//  CardBehavior.swift
//  PlayingCard
//
//  Created by xenon on 2021/6/18.
//

import UIKit

// UIDynamicBehavior是所有Behavior的基类
// 所以这里使用的UICollisionBehavior，UIDynamicItemBehavior
// 都是它的子类，一层套一层，其实这里的编程体验和用Unity有点像
// 刚体碰撞，速度，加速度啥的都有
class CardBehavior: UIDynamicBehavior {

    // 这里挺有意思的，利用的是类似于Kotlin apply的方式来初始化变量，而不是在放在init中
    // 可以学习一下，这样显得初始化的步骤更清晰一些
    private lazy var collisionBehavior: UICollisionBehavior = {
        let behavior = UICollisionBehavior()
        behavior.translatesReferenceBoundsIntoBoundary = true
        return behavior
    }()
    
    private lazy var itemBehavior: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = false
        behavior.elasticity = 1.0
        behavior.resistance = 0.0
        return behavior
    }()
    
    private func push(_ item: UIDynamicItem) {
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        push.angle = CGFloat(arc4random_uniform(UInt32(2 * CGFloat.pi)))
        push.magnitude = CGFloat(1.0) + CGFloat(arc4random_uniform(UInt32(2.0)))
        // 这里由于action引用了自身，所以可能导致引用环的产生
        // 由此可见Swift的ARC和C++的智能指针是相当类似的
        // unowned裸指针，weak对应weak_ptr，strong对应shared_ptr，C++里面的unique_ptr这里没有对应的
        // 但iOS能在低内存占用下达到Android相同的效果应该也是不用GC达到的
        push.action = { [unowned push, weak self] in
            self?.removeChildBehavior(push)
        }
        addChildBehavior(push)
    }
    
    func addItem(_ item: UIDynamicItem) {
        collisionBehavior.addItem(item)
        itemBehavior.addItem(item)
        push(item)
    }
    
    func removeItem(_ item: UIDynamicItem) {
        collisionBehavior.removeItem(item)
        itemBehavior.removeItem(item)
    }
    
    override init() {
        super.init()
        addChildBehavior(collisionBehavior)
        addChildBehavior(itemBehavior)
    }
    
    // 便利构造函数
    convenience init(in animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }
    
}
