//
//  SBNetworkManager.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/11/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

//enum LANGUAGES : String {
//    
//    case ENG = "en"
//}

class SBNetworkManager: NSObject {
    
     public var responseArray : NSMutableArray?
    
    //====================================================================================================================================
    // GET PLAYERS METHOD
    //====================================================================================================================================
    
    public func getPlayers(sortType:NSString, completion : @escaping (_ articleArray:NSArray, _ error:NSError?) -> Void) {
        
        let URLString : String = "http://hackerearth.0x10.info/api/gyanmatrix"
        let param = "type=json&query=list_player"
        let request : NSMutableURLRequest = SBHTTPRequest.getServerRequest(urlString: URLString, paramString: param)
        SBHTTPResponse.responseWithRequest(request: request, requestTitle: "FETCH_PLAYERS", completion: { (json, error) in
            
            print("ERROR :: \(error?.localizedDescription)")
            self.responseArray = NSMutableArray()
            if (error == nil)
            {
                let dictionary : [String:Any] = json as! [String : Any]
                
            }
            completion(self.responseArray!, error)
        })
    }
}
