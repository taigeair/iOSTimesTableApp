//
//  ViewController.swift
//  timestable
//
//  Created by Taige Zhang on 15/07/15.
//  Copyright (c) 2015 Taige Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var labelValue: UITextField!
    
    @IBOutlet weak var table: UITableView!
    
    @IBAction func enterNumber(sender: AnyObject) {
    
        println(labelValue.text)
        var number = (labelValue.text as NSString).floatValue
        print(number)
  
        slider.value = number
        NSUserDefaults.standardUserDefaults().setObject(number, forKey: "lastValue")

        table.reloadData()

    }
    
    
    @IBAction func sliderValue(sender: AnyObject) {
        println(slider.value)
        table.reloadData()
        NSUserDefaults.standardUserDefaults().setObject(slider.value, forKey: "lastValue")
       
        var name = NSUserDefaults.standardUserDefaults().objectForKey("lastValue") as! Float
        println("saved: \(name)")
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")

        cell.textLabel?.text = String(Int(slider.value)*(indexPath.row+1))
        
        return cell;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if NSUserDefaults.standardUserDefaults().objectForKey("lastValue") == nil {
            println("hi")
        } else {
            println(NSUserDefaults.standardUserDefaults().objectForKey("lastValue") as! Float)
            slider.value = NSUserDefaults.standardUserDefaults().objectForKey("lastValue") as! Float
        }
        
        self.labelValue.delegate = self //view controller is delegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
   func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true


    }


}

