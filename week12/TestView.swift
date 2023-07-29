//
//  ViewA.swift
//  hitTest
//
//  Created by 박종화 on 2023/07/29.
//

import UIKit

class TestView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !isUserInteractionEnabled || isHidden || alpha <= 0.01 {
            return nil
        }
        
        if self.point(inside: point, with: event) {
            for subview in subviews.reversed() {
                let convertedPoint = subview.convert(point, from: self)
                if let hitTestView = subview.hitTest(convertedPoint, with: event) {
                    if let hitView = hitTestView.restorationIdentifier {
                        print(hitView)
                    }
                    return hitTestView
                }
            }
            return self
        }
        return nil
    }
}
