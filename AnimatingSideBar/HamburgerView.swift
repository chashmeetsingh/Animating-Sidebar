//
//  HamburgerView.swift
//  AnimatingSideBar
//
//  Created by Chashmeet Singh on 2017-05-03.
//  Copyright © 2017 Chashmeet Singh. All rights reserved.
//

import UIKit

class HamburgerView: UIView {

    let imageView: UIImageView! = UIImageView(image: UIImage(named: "Hamburger"))
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        configure()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func rotate(fraction: CGFloat) {
        let angle = Double(fraction) * (.pi / 2)
        imageView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
    }
        
    private func configure() {
        imageView.contentMode = UIViewContentMode.center
        addSubview(imageView)
    }

}
