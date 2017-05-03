//
//  ViewController.swift
//  AnimatingSideBar
//
//  Created by Chashmeet Singh on 2017-05-03.
//  Copyright © 2017 Chashmeet Singh. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {

    let sideMenuWidth: CGFloat = 80

    var detailVC: DetailViewController?

    var menuItem: NSDictionary? {
        didSet {
            hideOrShowMenu(false, animated: true)
            if let detailViewController = detailVC {
                detailViewController.menuItem = menuItem
            }
        }
    }

    var isMenuVisible = false

    lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.frame = self.view.bounds
        sv.isPagingEnabled = sv.contentOffset.x < (sv.contentSize.width - sv.frame.width)
        sv.bounces = false
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.contentSize = CGSize(width: self.view.bounds.width + self.sideMenuWidth, height: self.view.bounds.height)
        sv.delegate = self
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

        hideOrShowMenu(false, animated: false)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuContainerView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
        hideOrShowMenu(isMenuVisible, animated: false)
    }

    func addScrollView() {
        view.addSubview(scrollView)
    }

    func addContentView() {
        scrollView.addSubview(contentView)
    }

    func addMenuContainerView() {
        let menuVC = MenuViewController()
        let detailVC = DetailViewController()
        menuVC.detailVC = detailVC
        menuVC.mainVC = self
        self.detailVC = detailVC
        let menuViewController = embedInsideNavigationController(menuVC)
        addChildViewController(menuViewController)
        menuContainerView.addSubview(menuViewController.view)
        menuViewController.didMove(toParentViewController: self)
        contentView.addSubview(menuContainerView)
    }

    func addDetailContainerView() {
        let detailViewController = embedInsideNavigationController(self.detailVC!)
        addChildViewController(detailViewController)
        detailContainerView.addSubview(detailViewController.view)
        detailViewController.didMove(toParentViewController: self)
        contentView.addSubview(detailContainerView)
    }

    func embedInsideNavigationController(_ vc: UIViewController) -> UINavigationController {
        let nv = UINavigationController(rootViewController: vc)
        nv.navigationBar.isTranslucent = false
        nv.navigationBar.barTintColor = .black
        nv.view.translatesAutoresizingMaskIntoConstraints = false
        return nv
    }

    func hideOrShowMenu(_ show: Bool, animated: Bool) {
        let menuOffset = menuContainerView.bounds.width
        scrollView.setContentOffset(show ? CGPoint.zero : CGPoint(x: menuOffset, y: 0), animated: animated)
        isMenuVisible = show
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let multiplier = 1.0 / menuContainerView.bounds.width
        let offset = scrollView.contentOffset.x * multiplier
        let fraction = 1.0 - offset
        menuContainerView.layer.transform = transformForFraction(fraction: fraction)
        menuContainerView.alpha = fraction

        if let detailViewController = detailVC {
            if let rotatingView = detailViewController.hamburgerView {
                rotatingView.rotate(fraction: fraction)
            }
        }

        scrollView.isPagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.frame.width)

        let menuOffset = menuContainerView.bounds.width
        isMenuVisible = !CGPoint(x: menuOffset, y: 0).equalTo(scrollView.contentOffset)
    }

    func transformForFraction(fraction: CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0 / 1000.0
        let angle = Double(1.0 - fraction) * -(Double.pi / 2)
        let xOffset = menuContainerView.bounds.width * 0.5
        let rotateTransform = CATransform3DRotate(identity, CGFloat(angle), 0.0, 1.0, 0.0)
        let translateTransform = CATransform3DMakeTranslation(xOffset, 0.0, 0.0)
        return CATransform3DConcat(rotateTransform, translateTransform)
    }

}
