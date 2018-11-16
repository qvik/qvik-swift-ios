//
//  ImmediatePanGestureRecognizer.swift
//  QvikSwift
//
//  Created by Matti Dahlbom on 28/07/2018.
//  Copyright © 2018 Qvik. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

/**
 Provides a UIPanGestureRecognizer whose started state is triggered as soon
 as a touch is registered, instead of the touch having moved enough to be
 considered a pan.
 */
open class ImmediatePanGestureRecognizer: UIPanGestureRecognizer {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if self.state == .began {
            return
        }

        super.touchesBegan(touches, with: event)

        state = UIGestureRecognizer.State.began
    }
}
