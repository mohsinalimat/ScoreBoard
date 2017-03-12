//
//  SBNetworkManager.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/11/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

class SBNetworkManager: NSObject {
    
    public var responseArray : NSMutableArray?
    public var records : NSArray?
    
    
    //====================================================================================================================================
    // GET PLAYERS METHOD
    //====================================================================================================================================
    
    public func getPlayers(sortType:NSString, completion : @escaping (_ articleArray:NSArray?, _ error:NSError?) -> Void) {
        
        let URLString : String = "http://hackerearth.0x10.info/api/gyanmatrix"
        let param = "type=json&query=list_player"
        let request : NSMutableURLRequest = SBHTTPRequest.getServerRequest(urlString: URLString, paramString: param)
        SBHTTPResponse.responseWithRequest(request: request, requestTitle: "FETCH_PLAYERS", completion: { (json, error) in
            
            print("ERROR(IF-ANY) :: \(error?.localizedDescription)")
            self.responseArray = NSMutableArray()
            if (error == nil)
            {
                let dictionary : [String:Any] = json as! [String : Any]
                self.records = NSArray(array: dictionary["records"] as! NSArray)
                for recordDict in self.records as! [[String:Any]] {
                 
                    let player = SBPlayer(dictionary: recordDict)
                    
//                    SBDBManager().insertEntity(player: player)
                    
                    self.responseArray?.add(player)
//                    print("PLAYER : \((player.name)!)")
//                    print("PLAYER RUN: \((player.total_score)!)")
//                    print("PLAYER MATCHES: \((player.matches_played)!)")
                }
            }
            completion(self.responseArray!, error)
        })
    }
}
