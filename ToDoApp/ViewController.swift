//
//  ViewController.swift
//  ToDoApp
//
//  Created by Simon Ng on 7/8/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var jsonArray:NSMutableArray?
    var newArray: Array<String> = []
    var idArray: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        downloadAndUpdate()
    }
    
    func downloadAndUpdate() {
        newArray.removeAll()
        idArray.removeAll()
        
        Alamofire.request(.GET, "https://still-peak-69201.herokuapp.com/todo") .responseJSON { response in
            print(response.request)  // 原始的 URL 要求
            print(response.response) // URL 回應
            print(response.data)     // 伺服器資料
            print(response.result)   // 回應的序列化結果
            
            if let JSON = response.result.value {
                self.jsonArray = JSON as? NSMutableArray
                for item in self.jsonArray! {
                    if let name = item["name"], myName = name as? String,
                        let id = item["_id"], myId = id as? String {
                        self.newArray.append(myName)
                        self.idArray.append(myId)
                    }
                }
                
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.newArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = self.newArray[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print("ID is \(idArray[indexPath.row])")
            
            Alamofire.request(.DELETE, "https://still-peak-69201.herokuapp.com/todo/\(idArray[indexPath.row])")
            downloadAndUpdate()
            
        }
    }
}

