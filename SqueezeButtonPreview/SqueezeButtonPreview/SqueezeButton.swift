//
//  SqueezeButton.swift
//  Expense Tracker
//
//  Created by Omar Alejel on 6/30/15.
//  Copyright © 2015 omar alejel. All rights reserved.
//

import UIKit


class SqueezeButton: UIButton {
    ///IMPORTANT: The button will still have all of the normal functionality like having a target and compatibility with storyboards. If you want to put a SqueezeButton in your storyboard, just drag a button onto the view and set its class to SqueezeButton. The corner radius of the button will be equal to the "standardCornerRadius" variable by default...
    
    ///These 2 Bools are important for when the squeeze animation has not been completed but the user removes their finger. In that kind of scenario, we need to animate the button back to its normal shape in the completion handler of the shrinking animation...
    var completedSqueeze = true
    var pendingOut = false
    
    var shrinkTime = 0.2 ///animation time when shrinking
    var expandTime = 0.2 ///animation time when expanding
    
    var standardCornerRadius: CGFloat = 10
    
    ///Looks best when corners are round
    init(frame: CGRect, cornerRadius: CGFloat) {
        super.init(frame: frame)
        layer.cornerRadius = cornerRadius
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = standardCornerRadius
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = standardCornerRadius
    }
    
    ///Animates in when touches begin
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        press()
    }

    ///animates out when touch ends
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        rescaleButton()
    }
    
    func press() {
        UIView.animateKeyframesWithDuration(shrinkTime, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: { () -> Void in
            self.completedSqueeze = false
            self.transform = CGAffineTransformScale(self.transform, 0.9, 0.9)
            }) { (done) -> Void in
                self.completedSqueeze = true
                if self.pendingOut {
                    self.rescaleButton()
                    self.pendingOut = false
                }
        }
    }
    
    func rescaleButton() {
        if completedSqueeze {
            UIView.animateKeyframesWithDuration(expandTime, delay: 0.0, options: UIViewKeyframeAnimationOptions.CalculationModeCubic, animations: { () -> Void in
                self.transform = CGAffineTransformScale(self.transform, 1/0.9, 1/0.9)
                }) { (done) -> Void in
                    ///completion work once it rescales
            }
        } else {
            pendingOut = true
        }
    }
}
