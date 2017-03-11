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
        
        favouriteObj.setValue(player.id as String?, forKey: "id")
        favouriteObj.setValue(false, forKey: "favourite")
        
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
    
    public func updatEntity(id: NSString?, flag : Bool) {
    
        let dbPersistence = SBDBPersistence.sharedInstance
        let context = dbPersistence.persistentContainer.viewContext as NSManagedObjectContext
        let predicate = NSPredicate(format:"id == %@", id!)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourite")
        fetchRequest.predicate = predicate
        
        do {
        let resultArray = try context.fetch(fetchRequest) as! [NSManagedObject]
        
        if ((resultArray.count) > 0) {
        let player = (resultArray[0])
           player.setValue(flag, forKey: "favourite")
        }
        
        } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    public func fetchFavourite() -> NSMutableArray {
        
        let dbPersistence = SBDBPersistence.sharedInstance
        let context = dbPersistence.persistentContainer.viewContext as NSManagedObjectContext
        let entityDescription = NSEntityDescription.entity(forEntityName: "Favourite", in: context)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let predicate = NSPredicate(format: "favourite contains[c] %@", NSNumber(value: true))
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = predicate
        
        let resultArray = NSMutableArray()
        
        do {
            let result = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            for playerOb in result {
                
                let player = SBPlayer()
                
                player.id = playerOb.value(forKey: "id") as! NSString?
                player.name = playerOb.value(forKey: "name") as! NSString?
                player.playerdescription = playerOb.value(forKey: "playerDesc") as! NSString?
                player.country = playerOb.value(forKey: "country") as! NSString?
                player.matches_played = playerOb.value(forKey: "matches") as! NSString?
                player.total_score = playerOb.value(forKey: "runs") as! NSString?
                let boolObj = playerOb.value(forKey: "favourite") as! NSNumber?
                player.favourite = boolObj?.boolValue
                
                resultArray.add(player)
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return resultArray
    }
    
}
