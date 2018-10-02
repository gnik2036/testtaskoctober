//
//  dataViewerTableViewController.swift
//  testtaskoctober
//
//  Created by shady on 10/2/18.
//  Copyright © 2018 XYZ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class dataViewerTableViewController: UITableViewController {
    
    var ref = FIRDatabaseReference!
    var refHandel : UInt!
    var data = [test]()
    let cellId = "cellId"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        ref = FIRDatabase.database().reference()
        fetchUser()
    }



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)

        cell.textLabel?.text = data[indexPath.row].ACTION_DATETIME + data[indexPath.row].ACTION_NOTE + data[indexPath.row].ACTION_TAKEN + data[indexPath.row].ACTION_USER + data[indexPath.row].SYSKEY
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete { data.remove(at: indexPath.row)
        
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    
    
func fetchUsers()
{
    
    refHandel = ref.child().observEventType(.ChildAdded,withBlock:{ (snapshot) in
        if let dictionary = snapshot.value as? [String:AnyObject]{
        
        print (dictionary)
        
        
        let dataValue = test()
        
        dataValue.setValuesForKeys(dictionary)
        
        self.data.append(dataValue)
        
        dispatch_asyn(dispatch_get_main_queue(),{
        self.tableView.reloadData()
        })
        
        }
        
        })
    
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
