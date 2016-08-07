//
//  AddViewController.swift
//  ToDoApp
//
//  Created by Simon Ng on 7/8/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Alamofire

class AddViewController: UIViewController {
    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonTapped(sender: AnyObject) {
        guard let todoItem = textField.text else {
            return
        }
        
        Alamofire.request(.POST, "https://still-peak-69201.herokuapp.com/todo", parameters: ["name": todoItem])
        self.navigationController?.popViewControllerAnimated(true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
