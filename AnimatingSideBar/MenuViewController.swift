//
//  MenuViewController.swift
//  AnimatingSideBar
//
//  Created by Chashmeet Singh on 2017-05-03.
//  Copyright © 2017 Chashmeet Singh. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {
    
    let cellReuseidentifier: String = "MenuItemCell"
    
    var mainVC: MainViewController?
    
    var detailVC: DetailViewController? {
        didSet {
            let menuItem = menuItems.firstObject as! NSDictionary
            
            detailVC?.imageView.image = UIImage(named: menuItem["bigImage"] as! String)
            if let colorsArray = menuItem["colors"] as? [CGFloat] {
                
                detailVC?.view.backgroundColor = UIColor(red: colorsArray[0] / 255,
                                                         green: colorsArray[1] / 255,
                                                         blue: colorsArray[2] / 255,
                                                         alpha: 1)
            }
        }
    }
    
    lazy var menuItems: NSArray = {
        let path = Bundle.main.path(forResource: "MenuItems", ofType: "plist")
        return NSArray(contentsOfFile: path!)!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController!.navigationBar.clipsToBounds = true
        
        configureTableView()
    }
    
    func configureTableView() {
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: cellReuseidentifier)
        tableView.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return max(80, view.bounds.height / CGFloat(menuItems.count))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseidentifier) as! MenuItemCell
        
        let menuItem = menuItems[indexPath.row] as! NSDictionary
        
        cell.height = view.bounds.height / CGFloat(menuItems.count)
        cell.configureForMenuItem(menuItem)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row] as! NSDictionary
        detailVC?.menuItem = menuItem
        mainVC?.hideOrShowMenu(false, animated: true)
    }
    
}
