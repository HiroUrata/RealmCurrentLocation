//
//  PresentationModel.swift
//  createHalfView
//
//  Created by UrataHiroki on 2021/07/02.
//


import UIKit

class PresentationController: UIPresentationController {

    
  let blurEffectView: UIVisualEffectView!
  var tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer()
  
    
    
  override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
    
      blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark)) //UIBlurの明るさを変えられる
    
      super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
      tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissController))
    
      blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    
      self.blurEffectView.isUserInteractionEnabled = true
      self.blurEffectView.addGestureRecognizer(tapGestureRecognizer)
    
  }
  
    
    
  override var frameOfPresentedViewInContainerView: CGRect {  //数字の変更で持ち上げる高さを変えられる
    
    CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height * 0.25),
           size: CGSize(width: self.containerView!.frame.width, height: self.containerView!.frame.height * 0.75))
    
    
    
  }

    
    
  override func presentationTransitionWillBegin() { //blurEffectViewの濃さの変更が可能
    
      self.blurEffectView.alpha = 0
      self.containerView?.addSubview(blurEffectView)
      self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
        
          self.blurEffectView.alpha = 0.8
        
      }, completion: { (UIViewControllerTransitionCoordinatorContext) in })
    
  }
  
    
    
  override func dismissalTransitionWillBegin() {
    
      self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
        
          self.blurEffectView.alpha = 0
        
      }, completion: { (UIViewControllerTransitionCoordinatorContext) in
        
          self.blurEffectView.removeFromSuperview()
        
      })
  }
  
    
    
  override func containerViewWillLayoutSubviews() {
    
      super.containerViewWillLayoutSubviews()
    
    presentedView!.roundCorners([.topLeft, .topRight], radius: 22)
    //presentedView?.roundCorners([.bottomLeft, .bottomRight], radius: 22)
    
  }

    
    
  override func containerViewDidLayoutSubviews() {
    
      super.containerViewDidLayoutSubviews()
    
      presentedView?.frame = frameOfPresentedViewInContainerView
      blurEffectView.frame = containerView!.bounds

  }

    
    
  @objc func dismissController(){
    
      self.presentedViewController.dismiss(animated: true, completion: nil)
    
  }
}



extension UIView {
    
  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
      let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,cornerRadii: CGSize(width: radius, height: radius))
    
    let mask = CAShapeLayer()
      mask.path = path.cgPath
      layer.mask = mask
    
  }
}
