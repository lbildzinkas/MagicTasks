//
//  FirstViewController.swift
//  MagicTasks
//
//  Created by Luiz Bildzinkas on 3/15/16.
//  Copyright © 2016 Luiz Bildzinkas. All rights reserved.
//

import UIKit
import CoreData

class Tasks: UIViewController{

    @IBOutlet weak var table: UITableView!
    var managedObjectContext: NSManagedObjectContext!
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadData()
    }
    
    func reloadData() {
        let fetchRequest = NSFetchRequest(entityName: "Task")
        
        do {
            if let results = try managedObjectContext.executeFetchRequest(fetchRequest) as? [Task] {
                tasks = results
                table.reloadData()
            }
        } catch {
            fatalError("There was an error fetching the list of tasks!")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func cancelTasksViewController(segue:UIStoryboardSegue) {
    }
    
    @IBAction func saveTaskDetail(segue:UIStoryboardSegue) {
        table.reloadData()
        //if let taskDetailsView = segue.sourceViewController as? DetailtsTableViewController
        //{
            //if let task = taskDetailsView.task
            //{
            
                //let indexPath = NSIndexPath(forRow: tasks.count-1, inSection: 0)
                //table.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            //}
        //}
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if let details = segue.destinationViewController.childViewControllers[0] as? DetailtsTableViewController
            {
                if let indexPath = table.indexPathForSelectedRow
                {
                    let task = tasks[indexPath.row]
                    details.task = task
                }
                details.managedObjectContext = self.managedObjectContext
            }
    }
}

extension Tasks : UITableViewDataSource
{
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing
        {
            table.setEditing(true, animated: true)
        }
        else
        {
            table.setEditing(false, animated: true)
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].name
        return cell;
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete
        {
            let taskToDelete = tasks[indexPath.row]
            managedObjectContext.deleteObject(taskToDelete)
            reloadData()
        }
    }
}

