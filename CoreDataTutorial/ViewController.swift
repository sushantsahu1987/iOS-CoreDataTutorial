//
//  ViewController.swift
//  CoreDataTutorial
//
//  Created by Sushant Sahu on 02/02/17.
//  Copyright © 2017 Sushant Sahu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var fnameTxtField: UITextField!
    
    @IBOutlet weak var lnameTxtField: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var submitedDataTable: UITableView!
    
    var people:[String]? = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Core Data Tutorial")
        
        submitedDataTable.dataSource = self
        submitedDataTable.delegate = self
        

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellItem", for: indexPath)
        cell.textLabel?.text = people?[indexPath.row]
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = people?.count {
            return count
        }
        
        return 0
    }
    
    
    
    @IBAction func onSubmitClick(_ sender: UIButton) {
        
        if(!(fnameTxtField.text?.isEmpty)! && !(lnameTxtField.text?.isEmpty)!) {
            save(fname: fnameTxtField.text!, lname: lnameTxtField.text!)
            fnameTxtField.text = ""
            lnameTxtField.text = ""
        }
        
    }
    
    
    
    func save(fname: String, lname:String) {
        print("\(fname), \(lname)")
        let name = "\(fname), \(lname)"
        people?.append(name)
        submitedDataTable.reloadData()
        
    }
    
    



}

