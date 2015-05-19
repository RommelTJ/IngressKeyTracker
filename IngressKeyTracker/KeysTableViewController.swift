//
//  KeysTableViewController.swift
//  IngressKeyTracker
//
//  Created by Rommel Rico on 5/12/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import UIKit

class KeysTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate {

    //For each portal, we need to store: name, picture, latitude, longitude, faction, hasKey, hasL8.
    var keyNames = [String]()
    var haveKey = [Bool]()
    
    var input = UITextField()
    
    @IBAction func addKey(sender: AnyObject) {
        var inputTextField: UITextField?
        let keyPrompt = UIAlertController(title: "Key Tracker", message: "Enter the Key Name: ", preferredStyle: UIAlertControllerStyle.Alert)
        keyPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        keyPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
            // Now do whatever you want with inputTextField (remember to unwrap the optional)
            if let inputText = inputTextField!.text {
                self.keyNames.append(inputText)
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
        
        if let storedKeyNames = NSUserDefaults.standardUserDefaults().objectForKey("keyNames") as? [String] {
            keyNames = storedKeyNames
        } else {
            keyNames = ["USD - St Francis of Assisi Statue",
                "USD Reflecting Pool",
                "Institute of Peace and Justice",
                "USD IPJ Fountain",
                "USD Memorial Fountain",
                "USD Moon Compass Walk",
                "Shiley Center For Science And Technology",
                "Mother Rosalie Hill Hall Main Drive Fountain",
                "Mother Rosalie Hall Fountain",
                "Marshall Garden",
                "USD San Diego De Alcalá Statue",
                "Cactus Mural",
                "Camino Hall at USD",
                "Olin Hall",
                "Mother Mary And Child Statue",
                "Sacred Heart Hall",
                "Manchester Conference Center",
                "USD Founders Hall",
                "Hahn School of Nursing and Health Science",
                "Anne Catherine Swanke Memorial",
                "Sister Mariella Bremner Grace Bremner Truitt Rose Garden",
                "Mary Stained Glass Window",
                "Madonna Hall Glass Window",
                "Founders Statue",
                "Hughes Administration Center Statue",
                "Colachis Plaza Fountain",
                "USD - Immaculata Parish Fountain",
                "Immaculata at University of San Diego",
                "USD - Founder's Statue",
                "Fountain for the Most Reverend Leo T. Maher D. D.",
                "Maher Hall Entrance Emblem",
                "University of San Diego Quad Fountain",
                "Fray Junipero Serra",
                "USD - Plaza de San Diego",
                "Ernest & Jean Hahn University Center",
                "One stop center fountain",
                "Equality Solidarity World Peace Nonviolence Tree",
                "Student Life Pavilion",
                "USD Pavilion Tower",
                "USD - Legal Research Center",
                "Degheri Alumni Center",
                "Edward Tyler Cramer Park",
                "Missions Crossroads",
                "Zipcar-6025 San Dimas Avenue",
                "Old Sheffield Bell",
                "St Francis Center",
                "Ron Fowler Plaque",
                "Fowler Park",
                "Jenny Craig Pavilion Box Office USD Crest",
                "Jenny Craig Pavilion",
                "Torero Stadium",
                "USD World Religions Plaques Fountain",
                "Sports Center",
                "University of San Diego Alcala Park Entrance",
                "Cuyamaca Hall",
                "San Diego County Office of Edu"]
            NSUserDefaults.standardUserDefaults().setObject(keyNames, forKey: "keyNames")
        }
        
        if let storedHaveKeys = NSUserDefaults.standardUserDefaults().objectForKey("haveKey") as? [Bool] {
            haveKey = storedHaveKeys
        } else {
            for var i=0; i<keyNames.count; i++ {
                haveKey.append(false)
            }
            NSUserDefaults.standardUserDefaults().setObject(haveKey, forKey: "haveKey")
        }
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
        return keyNames.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = keyNames[indexPath.row]
        if haveKey[indexPath.row] == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
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
            keyNames.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }   
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell?.accessoryType == UITableViewCellAccessoryType.Checkmark {
            cell?.accessoryType = UITableViewCellAccessoryType.None
            haveKey[indexPath.row] = false
        } else {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
            haveKey[indexPath.row] = true
        }
        NSUserDefaults.standardUserDefaults().setObject(haveKey, forKey: "haveKey")
    }

}
