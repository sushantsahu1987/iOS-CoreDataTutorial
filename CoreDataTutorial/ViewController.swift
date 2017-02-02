//
//  ViewController.swift
//  CoreDataTutorial
//
//  Created by Sushant Sahu on 02/02/17.
//  Copyright © 2017 Sushant Sahu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var fnameTxtField: UITextField!
    
    @IBOutlet weak var lnameTxtField: UITextField!
    
    @IBOutlet weak var btnSubmit: UIButton!
    
    @IBOutlet weak var submitedDataTable: UITableView!
    
    var people:[String]? = [String]()
    
    var peopleData:[NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Core Data Tutorial")
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedCtx = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do {
            let fetchResults = try managedCtx.fetch(fetchRequest)
            print("fetch results \(fetchResults.count)")
        
            peopleData = fetchResults as! [NSManagedObject]
            
        } catch let error as NSError {
            print("\(error)")
        }
        
        submitedDataTable.dataSource = self
        submitedDataTable.delegate = self
        

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellItem", for: indexPath)
        
        let person = peopleData[indexPath.row]
        
        let fname = person.value(forKeyPath: "fname") as! String
        let lname = person.value(forKeyPath: "lname") as! String
        
        let name = "\(fname), \(lname)"
        cell.textLabel?.text = name
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return peopleData.count
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
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedCtx = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedCtx)!
        let person = NSManagedObject(entity: entity, insertInto: managedCtx)
        
        person.setValue(fname, forKeyPath: "fname")
        person.setValue(lname, forKey: "lname")
        
        do {
            try managedCtx.save()
            peopleData.append(person)
        } catch let error as NSError {
          print("\(error), \(error.description)")
        }
        
        submitedDataTable.reloadData()
        
    }
    
    



}

