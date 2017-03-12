//
//  ViewController.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/11/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func goAction(_ sender: Any) {
        
        SBNetworkManager().getPlayers(sortType: "") { (arrayList, error) in
            
            for playerp in arrayList! {
                SBDBManager().insertEntity(player: playerp as! SBPlayer)
            }
            
            DispatchQueue.main.async {
                
                let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
                let navigationVC = storyBoard.instantiateViewController(withIdentifier: "SBPlayerNavigationVC") as! UINavigationController
                let viewArray = navigationVC.viewControllers as NSArray
                let playerListVC = viewArray.object(at: 0) as! SBPlayerListVC
                playerListVC.playerList = NSMutableArray(array: arrayList!)
                self.present(navigationVC, animated: true, completion: nil)
            }
        }
    }
}

