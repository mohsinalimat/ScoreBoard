//
//  SBResponseManager.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/11/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

enum RESPONSE_CODE : Int {
    
    case SUCCESS = 200
    case ERROR = 400
}

class SBHTTPResponse: NSObject {

    class func responseWithRequest(request:NSMutableURLRequest , requestTitle:String , completion : @escaping (_ json:Any, _ error:NSError?) -> Void) {
        
        let task : URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            var jsonResponse: Any? = nil
            if (error != nil) {
                print("ERROR RESPONSE (IF-ANY) :: \(error?.localizedDescription)")
                completion(jsonResponse as Any, error as NSError?)
            }
            else
            {
                let httpResponse = response as! HTTPURLResponse
                print("HTTP RESPONSE \(httpResponse.description) && CODE :: \(httpResponse.statusCode)")
                if (httpResponse.statusCode == RESPONSE_CODE.SUCCESS.rawValue) {
                    
                    do {
                        jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    }
                    catch let err as NSError
                    {
                        print("RESPONSE_EXCEPTION :: \(err.localizedDescription)")
                    }
                    completion(jsonResponse as Any, error as NSError?)
                }
                print("ERROR RESPONSE DATA (IF-ANY) :: \(jsonResponse)")
            }
        }
        task.resume()
    }
}
