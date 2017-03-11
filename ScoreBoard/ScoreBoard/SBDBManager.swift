//
//  SBDBManager.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/11/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit
import CoreData

class SBDBManager: NSObject {

    public func insertEntity(player: SBPlayer) {
     
        let dbPersistence = SBDBPersistence.sharedInstance
        let context = dbPersistence.persistentContainer.viewContext as NSManagedObjectContext
        
        let entityDescription  = NSEntityDescription.entity(forEntityName: "Favourite", in: context)
        
        let favouriteObj = Favourite(entity: entityDescription!, insertInto: context)
        
        favouriteObj.id = player.id as String?
        favouriteObj.favourite = player.favourite!
        
        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    public func fetchEntity(id: NSString?) -> SBPlayer {
        
        let dbPersistence = SBDBPersistence.sharedInstance
        let context = dbPersistence.persistentContainer.viewContext as NSManagedObjectContext
        let predicate = NSPredicate(format:"id == %@", id!)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourite")
        fetchRequest.predicate = predicate
        
        let playerObj = SBPlayer()
        do {
            let resultArray = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            if ((resultArray.count) > 0) {
                let player = (resultArray[0])
                playerObj.id = player.value(forKey: "id") as! NSString?
                playerObj.favourite = (player.value(forKey: "favourite") as! Bool)
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return playerObj
    }
    
}
