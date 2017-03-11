//
//  SBPlayer.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/11/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

class SBPlayer: NSObject {

    public var country : NSString?
    public var playerdescription : NSString?
    public var id : NSNumber?
    public var image : NSString?
    public var matches_played : NSNumber?
    public var name : NSString?
    public var total_score : NSNumber?
    
    override init() {
        
    }
    
    /********************************************************
     CUSTOM INTIALIZATION : INIT WITH DICTIONARY
     ********************************************************/
    
    init(dictionary : [String:Any]) {
        super.init()
        self.parseDictionary(dictionary: dictionary)
    }
    
    /********************************************************
     PARSING DICTIONARY : MAPPING DATA TO CLASS PROPERTIES
     ********************************************************/
    
    public func parseDictionary(dictionary : [String:Any]) {
        
        self.country = dictionary["country"] as? NSString
        self.id = dictionary["id"] as? NSNumber
        self.playerdescription = dictionary["description"] as? NSString
        self.image = dictionary["image"] as? NSString
        self.matches_played = dictionary["matches_played"] as? NSNumber
        self.name = dictionary["name"] as? NSString
        self.total_score = dictionary["total_score"] as? NSNumber
    }
    
}
