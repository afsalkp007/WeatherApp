//
//  UIView+Ext.swift
//  WeatherApp
//
//  Created by Afsal's Macbook Pro on 03/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

extension UIView {

  /// Convenient method to add a list of subviews
  func addSubviews(_ views: [UIView]) {
    views.forEach({
      addSubview($0)
    })
  }

  /// Apply mask to round corners
  func round(corners: UIRectCorner) {
    let raddi = bounds.size.height / 2
    let path = UIBezierPath(
      roundedRect: bounds,
      byRoundingCorners: corners,
      cornerRadii: CGSize(width: raddi, height: raddi)
    )

    let maskLayer = CAShapeLayer()

    maskLayer.path = path.cgPath
    layer.mask = maskLayer
  }
}

extension UIView {
  @discardableResult func addSubview<S: UIView>(_ subview: S, constraints: [NSLayoutConstraint]) -> S {
    subview.translatesAutoresizingMaskIntoConstraints = false
    addSubview(subview)
    NSLayoutConstraint.activate(constraints)
    return subview
  }
}

extension UIView {
    func animate(from: CGFloat, to: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            
            self.transform = CGAffineTransform.init(scaleX: from, y: from)
            UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                self.transform = CGAffineTransform.init(scaleX: to, y: to)
            })
        })
    }
}


