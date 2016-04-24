//
//  StaffTableViewController.swift
//  Ratings
//
//  Created by apple on 4/23/16.
//  Copyright © 2016 Ray Wenderlich. All rights reserved.
//

import UIKit

class StaffTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func postAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message,
                                      preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    @IBOutlet weak var camera: UIBarButtonItem!
    var list = [Staff]()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredTool=[Staff]()
    let imagePicker: UIImagePickerController! = UIImagePickerController()
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredTool = list.filter{staff in
            return staff.name.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView.reloadData()
    }
    @IBAction func cameraAction(sender: UIBarButtonItem) {
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: {})
            } else {
                postAlert("Rear camera doesn't exist", message: "Application cannot access the camera.")
            }
        } else {
            postAlert("Camera inaccessable", message: "Application cannot access the camera.")
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSample()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }

    func loadSample(){
        let staff1 = Staff(name: "Yifu Luo")!
        let staff2 = Staff(name: "Yifan Chen")!
        let staff3 = Staff(name: "Hahaha")!
        list += [staff1, staff2, staff3]
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.active && searchController.searchBar.text != ""{
            return filteredTool.count
        }
        return list.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StaffTableViewCell", forIndexPath: indexPath)
        
            as! StaffTableViewCell
        
        let mstaff: Staff
        
        if searchController.active && searchController.searchBar.text != ""
        {
            mstaff = filteredTool[indexPath.row]
        } else {
            mstaff = list[indexPath.row]
        }
        
        cell.StaffLabel.text = mstaff.name
        return cell
    }
}


extension StaffTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController){
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
