//
//  LoginFormViewController.swift
//  VK Client
//
//  Created by Regina Galishanova on 19.12.2020.
//

import UIKit

class LoginFormViewController: UIViewController {
    
    
    let fadingCircleView = FadingCircleView()
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnScroll))
        scrollView?.addGestureRecognizer(tapGesture)
        scrollView.isUserInteractionEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        configure()
        configureFadingCircleView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    private func configure() {
    }
    
    private func configureFadingCircleView() {
        view.addSubview(fadingCircleView)
        
        NSLayoutConstraint.activate([
            fadingCircleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fadingCircleView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            fadingCircleView.heightAnchor.constraint(equalToConstant: 40),
            fadingCircleView.widthAnchor.constraint(equalToConstant: 150)])
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let kbSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.size.height, right: 0)
        scrollView.contentInset = insets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let insets = UIEdgeInsets.zero
        scrollView.contentInset = insets
    }
    
    @objc func didTapOnScroll() {
        self.scrollView?.endEditing(true)
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        fadingCircleView.animate()
    }
    
//    @IBAction func showNavigationDidTap(_ sender: UIButton){
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyBoard.instantiateViewController(withIdentifier: "NewsNC")
//
//        navigationController?.pushViewController(viewController, animated: true)
//    }
//    @IBAction func showModalDidTap(_ sender: UIButton){
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyBoard.instantiateViewController(withIdentifier: "NewsNC")
//
//        viewController.modalPresentationStyle = .fullScreen
//        viewController.transitioningDelegate = self
//
//        present(viewController, animated: true, completion: nil)
//    }
//
}
//
//extension LoginFormViewController:
//    UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return Animator(isDismissing: false)
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        Animator(isDismissing: true)
//    }
//}
