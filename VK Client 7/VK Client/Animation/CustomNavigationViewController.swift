//
//  CustomNavigationViewController.swift
//  VK Client
//
//  Created by Regina Galishanova on 02.02.2021.
//

import UIKit

class CustomNavigationViewController: UINavigationController, UINavigationControllerDelegate {
    
    let interactiveTransition = CusomInteractiveTransitionVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        switch operation {
        case .pop:
            if navigationController.viewControllers.first != toVC {
                self.interactiveTransition.viewController = toVC
            }
            return CustomPopAnimator()
        case .push:
            self.interactiveTransition.viewController = toVC
            return CustomPushAnimator()
        default:
            return nil
        }
    }
    
    
    
}
