//
//  EnrollmentTableViewController.swift
//  Gradebook
//
//  Created by Erik Owen on 5/14/15.
//  Copyright (c) 2015 Erik Owen. All rights reserved.
//

import Foundation
import UIKit

class EnrollmentTableViewCell: UITableViewCell {
    var enrollment: Enrollment?
}

class EnrollmentTableViewController: UITableViewController {
    
    var loader: GradebookLoader? {
        didSet {
            var section : Section? = loader!.getCurrentSection()
            self.title = "Enrollments for " + section!.dept! + "-" + section!.course! + ", " + section!.termname!
            enrollments = loader!.loadEnrollments()
        }
    }
    
    var enrollments: Enrollments? {
        didSet {
            tableView.reloadData()
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // println("view did load")
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let enrollments =  enrollments {
            return enrollments.getSize()
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("enrollmentSubtitleCell", forIndexPath: indexPath) as! EnrollmentTableViewCell
        
        // Configure the cell...
        let enrollment = enrollments?.getEnrollmentnAtPos(indexPath.row)
        cell.enrollment = enrollment
        
        cell.textLabel?.text = enrollment!.first_name! + " " +  enrollment!.middle_name! + " " + enrollment!.last_name!
        cell.detailTextLabel?.text = enrollment!.username!
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "enrollmentToAssignmentSegue" {
            if let dest = segue.destinationViewController as? AssignmentTableViewController, let cell = sender as? EnrollmentTableViewCell {
                loader?.setCurrentEnrollment(cell.enrollment!)
                dest.loader = loader
            }
        }
    }
    
}
