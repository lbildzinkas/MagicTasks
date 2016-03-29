//
//  DetailtsTableViewController.swift
//  MagicTasks
//
//  Created by Luiz Bildzinkas on 3/19/16.
//  Copyright © 2016 Luiz Bildzinkas. All rights reserved.
//

import UIKit
import CoreData

class DetailtsTableViewController: UITableViewController {
    
    var managedObjectContext: NSManagedObjectContext!
    var task: Task?
    
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskDescription: UITextField!
    @IBOutlet weak var projectName: UITextField!
    @IBOutlet weak var beginDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        loadTask()
    }
    
    func loadTask()
    {
        if let taskLoaded = task
        {
            taskName.text = taskLoaded.name
            taskDescription.text = taskLoaded.taskDescription
            projectName.text = taskLoaded.project?.name
            
            let duration = taskLoaded.durations.first
            
            beginDate.date = (duration?.durationInit)!
            endDate.date = (duration?.durationEnd)!
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SaveTaskDetail" {
            
            if task == nil{
                let taskEntity = NSEntityDescription.entityForName("Task", inManagedObjectContext: self.managedObjectContext)
                task = Task(entity: taskEntity!, insertIntoManagedObjectContext: self.managedObjectContext)
                
                let projectEntity = NSEntityDescription.entityForName("Project", inManagedObjectContext: self.managedObjectContext)
                task?.project = Project(entity: projectEntity!, insertIntoManagedObjectContext: self.managedObjectContext)
                
                let durationEntity = NSEntityDescription.entityForName("TaskDuration", inManagedObjectContext: self.managedObjectContext)
                let duration = TaskDuration(entity: durationEntity!, insertIntoManagedObjectContext: self.managedObjectContext)
                duration.task = task
                
                task?.durations = [duration]
            }
            
            task?.name = taskName.text
            task?.taskDescription = taskDescription.text
            task?.project!.name = projectName.text
            let duration = task?.durations.first
            duration!.durationInit = beginDate.date
            duration!.durationEnd = endDate.date

            do {
                try managedObjectContext.save()
            } catch {
                print("Error saving the managed object context!")
            }
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            taskName.becomeFirstResponder()
        }
    }
    
    // MARK: - Table view data source

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
