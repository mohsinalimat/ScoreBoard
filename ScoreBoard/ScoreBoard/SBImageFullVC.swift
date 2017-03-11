//
//  SBImageFullVC.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/11/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit
import SDWebImage

class SBImageFullVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView?
    @IBOutlet weak var playerName: UILabel?
    
    public var player : SBPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.playerName?.text = self.player?.name as String?
        
        if (self.player?.image != nil) {
            
            let imageURL = NSURL(string : self.player?.image as! String)
            self.profileImage?.sd_setImage(with: imageURL as URL!, placeholderImage: UIImage(named: "user_default.png"))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
