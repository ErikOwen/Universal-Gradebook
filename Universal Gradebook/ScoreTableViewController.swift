//
//  ScoreTableViewController.swift
//  Gradebook
//
//  Created by Erik Owen on 5/14/15.
//  Copyright (c) 2015 Erik Owen. All rights reserved.
//


import Foundation
import UIKit

class ScoreTableViewCell: UITableViewCell {
        var score: Score?
}

class ScoreTableViewController: UITableViewController {
    
    var loader: GradebookLoader? {
        didSet {
            scores = loader!.loadScores()
            var assignment: UserScore? = loader!.getCurrentAssignment()
            self.title = "Scores for " + assignment!.name!
        }
    }
    
    var scores: Scores? {
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
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        // println("count for section \(section)")
        
        if let scores = scores {
            return scores.getSize()
        }
        
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("scoreSubtitleCell", forIndexPath: indexPath) as! ScoreTableViewCell
        
        let score = scores?.getScoreAtPos(indexPath.row)
        cell.score = score
        cell.textLabel?.text = "\(score!.score!) / \(score!.max_points!)"
        cell.detailTextLabel?.text = "Letter grade received: \"\(score!.displayScore!)\""
        
        return cell
    }
    
    // MARK: - Navigation
    
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "quakeDetails" {
//            if let dest = segue.destinationViewController as? ViewController, let cell = sender as? SectionTableViewCell {
//                //                dest.quake = cell.quake
//            }
//        }
//    }
    
}
