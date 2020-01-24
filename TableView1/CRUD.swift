//
//  CRUD.swift
//  TableView1
//
//  Created by Marni Anuradha on 12/26/19.
//  Copyright © 2019 Marni Anuradha. All rights reserved.
//

import UIKit
import CoreData

struct CRUD
{
    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    

    
    //function for inserting values
    static func insertValue(entityName:String,key1:String,value1:String,key2:String,value2:String,key3:String,value3:Int16,key4:String,value4:Data)
    {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else
        {
            print("Error In Entity Description")
            return
            
        }
        
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        
        managedObject.setValue(value1, forKey: key1)
        
        managedObject.setValue(value2, forKey: key2)
        
        managedObject.setValue(value3, forKey: key3)
        
        managedObject.setValue(value4, forKey: key4)
        
        do
        {
            try context.save()
            
            print("Data Inserted Sucessfully")
        }
        catch
        {
            print("Catch Error : Failed To Insert Data")
        }
        
    }
    
    
        //function for fetching values
    static func fetchData(entityName:String) -> [NSManagedObject]
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        var data:[NSManagedObject]!
        do
        {
            data = try context.fetch(fetchRequest) as! [NSManagedObject]
        }
        catch
        {
            print("Catch Error : Failed To Fetch Data")
        }
        
        return data
        
    }
    
        //function for deleting values
    static func deleteData(entityName:String,deleteBasedOnColumn columnName: String,value:String?)
    {
        let data = CRUD.fetchData(entityName: entityName)
        
        
        for x in data as! [NSManagedObject]
        {
            if(x.value(forKey: columnName) as? String == value)
            {
                context.delete(x)
            }
        }
        
        
        do
        {
            try context.save()
        }
        catch
        {
            print("Failed To Delete")
        }
    }
    
    
}
