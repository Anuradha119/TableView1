//
//  ViewController.swift
//  TableView1
//
//  Created by Marni Anuradha on 12/24/19.
//  Copyright © 2019 Marni Anuradha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static var name = [String]()
    
    static var age = [Int16]()
    
    static var email = [String]()
    
    static var image = [UIImage]()
    
    static var rowIndex:Int!
    
    var tableView:UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = ViewController.name[indexPath.row]
        cell.imageView?.image = ViewController.image[indexPath.row]
        
        cell.detailTextLabel?.text = String(ViewController.age[indexPath.row]) + " : " + ViewController.email[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ViewController.rowIndex = indexPath.row
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true))
        createUI()
        // Do any additional setup after loading the view.
    }

    
    func createUI(){
        
        tableView = UITableView(frame: view.frame, style: UITableView.Style.plain)
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        ViewController.name = [String]()
        ViewController.age = [Int16]()
        ViewController.email = [String]()
        ViewController.image = [UIImage]()
        
        let data = CRUD.fetchData(entityName: "PersonalDetails")
        
        for x in data{
            
            ViewController.name.append((x.value(forKey: "name") as! String))
            
            ViewController.age.append((x.value(forKey: "age") as! Int16))
            
            ViewController.email.append((x.value(forKey: "email") as! String))
            
            ViewController.image.append(UIImage(data: (x.value(forKey: "picture") as! Data))!)
        }
        tableView.reloadData()
    }
    
    @IBAction func addContactBtn(_ sender: Any) {
        
        ViewController.rowIndex == nil
        let sVC = storyboard?.instantiateViewController(identifier: "secondVC") as! SecondViewController
        
        navigationController?.pushViewController(sVC, animated: true)
        
    }
}

