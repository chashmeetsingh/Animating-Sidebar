//
//  MenuViewController.swift
//  AnimatingSideBar
//
//  Created by Chashmeet Singh on 2017-05-03.
//  Copyright © 2017 Chashmeet Singh. All rights reserved.
//

import UIKit

import UIKit

class MenuViewController: UITableViewController {
    
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
        tableView.register(MenuItemCell.self, forCellReuseIdentifier: "MenuItemCell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell") as! MenuItemCell
        let menuItem = menuItems[indexPath.row] as! NSDictionary
        cell.configureForMenuItem(menuItem, view.bounds.height / CGFloat(menuItems.count))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0
    }
    
}
