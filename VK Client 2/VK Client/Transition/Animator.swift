//
//  Animator.swift
//  VK Client
//
//  Created by Regina Galishanova on 01.02.2021.
//
//
//import UIKit
//
//final class Animator: NSObject, UIViewControllerAnimatedTransitioning {
//    let isDismissing: Bool
//    
//    init(isDismissing: Bool) {
//        self.isDismissing = isDismissing
//    }
//    
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        0.75
//    }
//    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        guard let source = transitionContext.viewController(forKey:.from),
//              let destination = transitionContext.viewController(forKey: .to)
//        else { return }
//        
//        let containerFrame = transitionContext.containerView.frame
//        let sourceFrame = CGRect(
//            x: 0,
//            y: isDismissing ? -containerFrame.height : containerFrame.height,
//            width: source.view.frame.width,
//            height: source.view.frame.height)
//        
//        let destinationFrame = source.view.frame
//        
//        transitionContext.containerView.addSubview(destination.view)
//        destination.view.frame = CGRect(
//            x: 0,
//            y: isDismissing ? containerFrame.height : -containerFrame.height,
//            width: source.view.frame.width,
//            height: source.view.frame.height)
//        
//        UIView.animate(withDuration: transitionDuration(using: transitionContext),
//                       delay: 0,
//                       usingSpringWithDamping: 0.5,
//                       initialSpringVelocity: 0,
//                       options: []) {
//            source.view.frame = sourceFrame
//            destination.view.frame = destinationFrame
//        } completion: { (isFinished) in
//            transitionContext.completeTransition(isFinished)
//        }
//
//    }
//    
//    
//}
