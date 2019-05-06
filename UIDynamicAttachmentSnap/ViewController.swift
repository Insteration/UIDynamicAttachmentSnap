//
//  ViewController.swift
//  UIDynamicAttachmentSnap
//
//  Created by Art Karma on 5/6/19.
//  Copyright © 2019 Art Karma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var squareView: UIView = {
        let myView = UIView()
        myView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        myView.backgroundColor = .green
        return myView
    }()
    
    private lazy var squareViewSecond: UIView = {
        let myView = UIView()
        myView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        myView.backgroundColor = .red
        return myView
    }()
    
    var animator = UIDynamicAnimator()
    var snap: UISnapBehavior?
    var snapSecond: UISnapBehavior?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGestureRecognizer()
        squareView.center = self.view.center
        squareViewSecond.center = self.view.center

        view.addSubview(squareView)
        view.addSubview(squareViewSecond)

        createAnimationAndBehaviors()

    }
    
    private func createGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(param:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(param: UITapGestureRecognizer) {
        let tapPoint = param.location(in: self.view)
        if snap != nil {
            animator.removeBehavior(snap!)
        }
        if snapSecond != nil {
            animator.removeBehavior(snapSecond!)
        }
        snap = UISnapBehavior(item: squareView, snapTo: tapPoint)
        snap?.damping = 0.7
        animator.addBehavior(snap!)
        
        snapSecond = UISnapBehavior(item: squareViewSecond, snapTo: tapPoint)
        snapSecond?.damping = 0.7
        animator.addBehavior(snapSecond!)
    }
    
    private func createAnimationAndBehaviors() {
        animator = UIDynamicAnimator(referenceView: self.view)
        let collision = UICollisionBehavior(items: [squareView, squareViewSecond])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator.addBehavior(collision)
        snap = UISnapBehavior(item: squareView, snapTo: self.view.center)
        snap?.damping = 0.6
        animator.addBehavior(snap!)
        
        snapSecond = UISnapBehavior(item: squareViewSecond, snapTo: self.view.center)
        snapSecond?.damping = 0.6
        animator.addBehavior(snapSecond!)
    }
}

