//
//  ViewController.swift
//  AnimatingSideBar
//
//  Created by Chashmeet Singh on 2017-05-03.
//  Copyright © 2017 Chashmeet Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let sideMenuWidth: CGFloat = 80
    
    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.frame = self.view.bounds
//        sv.backgroundColor = .red
        sv.isPagingEnabled = true
        sv.isScrollEnabled = true
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = true
        return sv
    }()
    
    lazy var  contentView: UIView = {
        let view = UIView()
        view.frame = self.view.bounds
        return view
    }()
    
    lazy var menuContainerView: UIView = {
        let frame = CGRect(x: 0.0, y: 0.0, width: self.sideMenuWidth, height: self.view.bounds.height)
        let view = UIView(frame: frame)
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var detailContainerView: UIView = {
        let frame = CGRect(x: 80.0, y: 0.0, width: self.view.bounds.width, height: self.view.bounds.height)
        let view = UIView(frame: frame)
        view.backgroundColor = .blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        addScrollView()
        addContentView()
        addMenuContainerView()
        addDetailContainerView()
    }
    
    func addScrollView() {
        view.addSubview(scrollView)
    }
    
    func addContentView() {
        scrollView.addSubview(contentView)
    }
    
    func addMenuContainerView() {
        let nv = UINavigationController(rootViewController: MenuViewController())
        nv.navigationBar.isTranslucent = false
        nv.navigationBar.barTintColor = .black
        let menuViewController = nv
        addChildViewController(menuViewController)
        menuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        menuContainerView.addSubview(menuViewController.view)
        menuViewController.didMove(toParentViewController: self)
        contentView.addSubview(menuContainerView)
    }
    
    func addDetailContainerView() {
        contentView.addSubview(detailContainerView)
    }

}
