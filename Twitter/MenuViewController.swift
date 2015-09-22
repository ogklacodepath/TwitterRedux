//
//  MenuViewController.swift
//  Twitter
//
//  Created by Golak Sarangi on 9/21/15.
//  Copyright © 2015 Golak Sarangi. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var menuTableView: UITableView!
    
    var viewControllers: [UIViewController] = []
    
    var mainViewController : MainWindowViewController?
    
    var menuItem = [
        "TimeLine", "Profile"
    ]
    
    override func viewDidLoad() {
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let TweetsViewNavigationController = storyboard.instantiateViewControllerWithIdentifier("TweetsViewNavigationController")

        viewControllers.append(TweetsViewNavigationController)

        let ProfileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController")
        
        viewControllers.append(ProfileViewController)

        mainViewController?.contentViewController = TweetsViewNavigationController

    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItem.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("startingwith cell")
        let cell = menuTableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath) as! MenuCell
        cell.menuTitleLabel.text = menuItem[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        menuTableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        mainViewController?.contentViewController = viewControllers[indexPath.row]
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCellWithIdentifier("menuHeaderCell") as! MenuHeaderCell

        headerCell.profileImageView!.setImageWithURL(NSURL(string: User.currentUser!.profileImageUrl!))
        
        headerCell.nameLabel.text = User.currentUser!.name
        headerCell.handleLabel.text = User.currentUser!.screenName

        return headerCell
    }
}


class MenuCell: UITableViewCell {
    
    @IBOutlet weak var menuTitleLabel: UILabel!
    
}

class MenuHeaderCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
}
