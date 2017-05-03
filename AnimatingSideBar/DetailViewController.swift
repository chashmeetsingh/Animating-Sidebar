//
//  DetailViewController.swift
//  AnimatingSideBar
//
//  Created by Chashmeet Singh on 2017-05-03.
//  Copyright © 2017 Chashmeet Singh. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let screenBounds = UIScreen.main.bounds
    
    var menuItem: NSDictionary? {
        didSet {
            if let menuItem = menuItem {
                self.imageView.image = UIImage(named: menuItem["bigImage"] as! String)
                if let colorsArray = menuItem["colors"] as? [CGFloat] {
                    
                    self.view.backgroundColor = UIColor(red: colorsArray[0] / 255,
                                                        green: colorsArray[1] / 255,
                                                        blue: colorsArray[2] / 255,
                                                        alpha: 1)
                }
            }
        }
    }
    
    lazy var imageView: UIImageView = {
        let frame = CGRect(x: 0, y: 0, width: 320, height: 320)
        let iv = UIImageView(frame: frame)
        return iv
    }()
    
    var hamburgerView: HamburgerView? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        addImageView()
        addTouchRecognizer()
    }
    
    func configureView() {
        self.view.backgroundColor = UIColor(red: 249.0 / 255, green: 84.0 / 255, blue: 7.0 / 255, alpha: 1)
    }
    
    func addImageView() {
        self.imageView.center = CGPoint(x: screenBounds.width / 2, y: screenBounds.height / 2)
        self.view.addSubview(imageView)
    }
    
    func addTouchRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hamburgerViewTapped))
        hamburgerView = HamburgerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        hamburgerView!.addGestureRecognizer(tapGestureRecognizer)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)
    }
    
    func hamburgerViewTapped() {
        let navigationController = parent as! UINavigationController
        let mainVC = navigationController.parent as! MainViewController
        mainVC.hideOrShowMenu(!mainVC.isMenuVisible, animated: true)
    }

}
