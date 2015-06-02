//
//  AssignmentTableViewController.swift
//  Gradebook
//
//  Created by Erik Owen on 5/14/15.
//  Copyright (c) 2015 Erik Owen. All rights reserved.
//


import Foundation
import UIKit

class AssignmentTableViewCell: UITableViewCell {
        var userScore: UserScore?
}

class AssignmentTableViewController: UITableViewController {
    
    var loader: GradebookLoader? {
        didSet {
            userScores = loader!.loadUserScores()
            var enrollment: Enrollment? = loader!.getCurrentEnrollment()
            self.title = "Assignments for " + enrollment!.first_name! + " " +  enrollment!.middle_name! + " " + enrollment!.last_name!
        }
    }
    
    var userScores: UserScores? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // println("view did load")
        tableView.reloadData()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        navigationItem.leftItemsSupplementBackButton = true
        
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
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        // println("count for section \(section)")
        
        if let userScores =  userScores {
            return userScores.getSize()
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("assignmentSubtitleCell", forIndexPath: indexPath) as! AssignmentTableViewCell
        
        let assignment = userScores?.getUserScoreAtPos(indexPath.row)
        cell.userScore = assignment
        cell.textLabel?.text = assignment?.name
        cell.detailTextLabel?.text = "Out of \(assignment!.max_points!) points"
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        println("segue identifier is: " + segue.identifier!)
        
        if segue.identifier == "assignmentToScoreSegue" {
            if let dest = segue.destinationViewController.childViewControllers[0] as? ScoreTableViewController, let cell = sender as? AssignmentTableViewCell {
                loader?.setCurrentAssignment(cell.userScore!)
                dest.loader = loader
            }
        }
    }
    
}
