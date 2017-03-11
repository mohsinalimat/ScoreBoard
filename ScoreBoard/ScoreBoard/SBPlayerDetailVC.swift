//
//  SBPlayerDetailVC.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/11/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

class SBPlayerDetailVC: UIViewController {

    public var player : SBPlayer?
    
    @IBOutlet weak var playerName: UILabel?
    @IBOutlet weak var playerCountry: UILabel?
    @IBOutlet weak var playerRuns: UILabel?
    @IBOutlet weak var playerMatches: UILabel?
    @IBOutlet weak var playerDescription: UILabel?
    
    @IBOutlet weak var shareButton: UIButton?
    @IBOutlet weak var linkButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.playerName?.text = self.player?.name as String?
        self.playerCountry?.text = self.player?.country as String?
        self.playerRuns?.text = NSString(format:"%@",(self.player?.total_score)!) as String
        self.playerMatches?.text = NSString(format:"%@",(self.player?.matches_played)!) as String
        self.playerDescription?.text = self.player?.playerdescription as String?
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shareAction(_ sender: Any) {
        
    }
    
    @IBAction func linkAction(_ sender: Any) {
        
    }
    
}
