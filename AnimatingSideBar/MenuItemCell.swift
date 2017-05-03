//
//  MenuItemCell.swift
//  AnimatingSideBar
//
//  Created by Chashmeet Singh on 2017-05-03.
//  Copyright © 2017 Chashmeet Singh. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {
    
    var height: CGFloat? {
        didSet {
            menuItemImageView.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: self.height!)
        }
    }
    
    let menuItemImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    func configureForMenuItem(_ menuItem: NSDictionary, _ height: CGFloat) {
        menuItemImageView.image = UIImage(named: menuItem["image"] as! String)
        
        if let colorsArray = menuItem["colors"] as? [CGFloat] {
            backgroundColor = UIColor(red: colorsArray[0] / 255, green: colorsArray[1] / 255, blue: colorsArray[2] / 255, alpha: 1)
        }
        
        self.height = height
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addImageView() {
        self.addSubview(menuItemImageView)
    }

}
