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
        
        let entityDescription = NSEntityDescription.entity(forEntityName: "Favourite", in: context)
        
        let favouriteObj = Favourite(entity: entityDescription!, insertInto: context)
        
        favouriteObj.setValue(player.id as String?, forKey: "id")
        favouriteObj.setValue(player.name as String?, forKey: "name")
        favouriteObj.setValue(player.country, forKey: "country")
        favouriteObj.setValue(player.playerdescription, forKey: "playerDesc")
        favouriteObj.setValue(player.matches_played, forKey: "matches")
        favouriteObj.setValue(player.image, forKey: "imageUrl")
        favouriteObj.setValue(player.total_score, forKey: "runs")
        let boolObj = NSNumber(value: player.favourite!)
        favouriteObj.setValue(boolObj, forKey: "favourite")
        
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
        
        let playerOb = SBPlayer()
        do {
            let resultArray = try context.fetch(fetchRequest) as! [Favourite]
            
            if ((resultArray.count) > 0) {
                
                let player = (resultArray[0]) as Favourite
                
                playerOb.id = player.value(forKey: "id") as! NSString? 
                playerOb.name = player.value(forKey: "name") as! NSString?
                playerOb.playerdescription = player.value(forKey: "playerDesc") as! NSString?
                playerOb.country = player.value(forKey: "country") as! NSString?
                playerOb.matches_played = player.value(forKey: "matches") as! NSString?
                playerOb.total_score = player.value(forKey: "runs") as! NSString?
                
                let boolObj = player.value(forKey: "favourite") as! NSNumber?
                playerOb.favourite = boolObj?.boolValue
                
                playerOb.image = player.value(forKey: "imageUrl") as! NSString?
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return playerOb
    }
    
    public func updatEntity(id: NSString?, flag : Bool) {
    
        let dbPersistence = SBDBPersistence.sharedInstance
        let context = dbPersistence.persistentContainer.viewContext as NSManagedObjectContext
        
        let predicate = NSPredicate(format:"id == %@", id!)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourite")
        fetchRequest.predicate = predicate
        
        do {
        let resultArray = try context.fetch(fetchRequest) as! [Favourite]
        
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
        let predicate = NSPredicate(format: "favourite == %@", NSNumber(value: true))
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = predicate
        
        let resultArray = NSMutableArray()
        
        do {
            let result = try context.fetch(fetchRequest) as! [Favourite]
            
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
                
                player.image = playerOb.value(forKey: "imageUrl") as! NSString?
                
                print("NAME_FETCH \((player.name)!)")
                
                resultArray.add(player)
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return resultArray
    }
    
    public func fetchEntities(completion : @escaping (_ arrayList: NSMutableArray) -> Void) {
        
        let list : NSMutableArray = self.fetchFavourite()
        print("LIST_COUNT \((list.count))")
        completion(list)
    }
    
}
