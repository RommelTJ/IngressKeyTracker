//
//  KeysTableViewController.swift
//  IngressKeyTracker
//
//  Created by Rommel Rico on 5/12/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import UIKit

class KeysTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {

    var keys = ["One", "Two", "Three"]
    var input = UITextField()
    
    @IBAction func addKey(sender: AnyObject) {
        var inputTextField: UITextField?
        let keyPrompt = UIAlertController(title: "Key Tracker", message: "Enter the Key Name: ", preferredStyle: UIAlertControllerStyle.Alert)
        keyPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        keyPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            // Now do whatever you want with inputTextField (remember to unwrap the optional)
            if let inputText = inputTextField!.text {
                self.keys.append(inputText)
                self.tableView.reloadData()
            }
        }))
        keyPrompt.addTextFieldWithConfigurationHandler({(textField: UITextField!) in
            textField.placeholder = "Placeholder Key"
            inputTextField = textField
        })
        
        presentViewController(keyPrompt, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return keys.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell

        cell.textLabel?.text = keys[indexPath.row]

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            keys.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }   
    }

}
