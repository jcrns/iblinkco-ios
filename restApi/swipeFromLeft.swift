//
//  swipeFromRight.swift
//  restApi
//
//  Created by HGPMAC87 on 7/9/19.
//  Copyright © 2019 iBlinkco. All rights reserved.
//

import UIKit

class swipeFromLeft: UIStoryboardSegue {
    override func perform() {
        let src = self.source       //new enum
        let dst = self.destination  //new enum
        
        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0) //Method call changed
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
        }) { (finished) in
            src.present(dst, animated: false, completion: nil) //Method call changed
        }
    }
}
