//
//  MainWindowViewController.swift
//  Twitter
//
//  Created by Golak Sarangi on 9/21/15.
//  Copyright © 2015 Golak Sarangi. All rights reserved.
//

import UIKit

class MainWindowViewController: UIViewController {

    @IBOutlet weak var contentViewLeftMargin: NSLayoutConstraint!
    
    var originalLeftMargin: CGFloat?
    
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var menuView: UIView!
    
    var menuViewController: UIViewController! {
        didSet(oldMenuViewController) {
            view.layoutIfNeeded()
            
            if oldMenuViewController != nil {
                oldMenuViewController.willMoveToParentViewController(nil)
                oldMenuViewController.view.removeFromSuperview()
                oldMenuViewController.didMoveToParentViewController(nil)
            }
            
            menuView.addSubview(menuViewController.view)
        }
    }
    
    var contentViewController: UIViewController! {
        didSet(oldContentViewController) {
            view.layoutIfNeeded()
            
            print("content View Controller")
            
            if oldContentViewController != nil {
                oldContentViewController.willMoveToParentViewController(nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMoveToParentViewController(nil)
            }
            
            contentViewController.willMoveToParentViewController(self)
            let newContentView = contentViewController.view
            newContentView.frame.size.width = view.frame.size.width
            contentView.addSubview(newContentView)
            contentViewController.didMoveToParentViewController(self)
            
            UIView.animateWithDuration(0.3) { () -> Void in
                self.contentViewLeftMargin.constant = 0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func onPanGesture(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        let velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            originalLeftMargin = contentViewLeftMargin.constant
        } else if sender.state == UIGestureRecognizerState.Changed {
            contentViewLeftMargin.constant = originalLeftMargin! + translation.x
        } else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.3, animations: {
                if velocity.x > 0 {
                    self.contentViewLeftMargin.constant = self.view.frame.size.width - 50
                } else {
                    self.contentViewLeftMargin.constant = 0
                }
                self.view.layoutIfNeeded()
            })
        }
    }

    @IBAction func onTapOverContent(sender: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.3, animations: {
            self.contentViewLeftMargin.constant = 0
            self.view.layoutIfNeeded()
        })
    }
}
