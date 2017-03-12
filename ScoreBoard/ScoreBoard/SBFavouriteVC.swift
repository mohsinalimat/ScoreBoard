//
//  SBFavouriteVC.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/11/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

class SBFavouriteVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var favSearchBar: UISearchBar!
    @IBOutlet weak var favTableView: UITableView!
    
    var playerList : NSMutableArray?
    var filteredList : NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.favSearchBar.delegate = self
        self.favTableView.delegate = self
        self.favTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        SBDBManager().fetchEntities { (arrayList) in
            
            self.playerList = NSMutableArray(array:arrayList)
            self.filteredList = NSMutableArray(array : arrayList)
            print("FAVOURITE_COUNT \((self.filteredList?.count)!)")
            self.favTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //====================================================================================================================================
    // TABLE VIEW DELEGATE
    //====================================================================================================================================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.filteredList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let favTableCell = tableView.dequeueReusableCell(withIdentifier: "SBTableCell") as! SBFavTableCell
        
        let playerOb = self.filteredList?.object(at: indexPath.row) as! SBPlayer
        
        DispatchQueue.main.async {
            favTableCell.playerImgView?.layer.cornerRadius = (favTableCell.playerImgView?.frame.size.width)!/2;
            favTableCell.playerImgView?.layer.masksToBounds = true
        }
        
        favTableCell.playerName?.text = playerOb.name as String?
        
        if (playerOb.image != nil) {
            
            let imageURL = NSURL(string : playerOb.image as! String)
            favTableCell.playerImgView?.sd_setImage(with: imageURL as URL!, placeholderImage: UIImage(named: "user_default.png"))
        }
        
        return favTableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let player = self.filteredList?.object(at: indexPath.row) as! SBPlayer
        print("SELECTED_PLAYER : \((player.name)!)")
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let playerDetailVC = storyBoard.instantiateViewController(withIdentifier: "SBPlayerDetailVC") as! SBPlayerDetailVC
        playerDetailVC.player = player
        self.navigationController?.pushViewController(playerDetailVC, animated: true)
    }
    
    //====================================================================================================================================
    // SEARCH BAR DELEGATE
    //====================================================================================================================================
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        DispatchQueue.main.async {
            
            let predicate = NSPredicate(format: "name contains[cd] %@ OR country contains[cd] %@", searchText, searchText)
            self.filteredList?.removeAllObjects()
            let searcArray = self.playerList?.filtered(using: predicate)
            self.filteredList?.addObjects(from: searcArray!)
            
            if (searchText.characters.count == 0) {
                
                self.filteredList?.addObjects(from: self.playerList?.mutableCopy() as! [Any])
                searchBar.resignFirstResponder()
            }
            self.favTableView.reloadData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("TEXT_DID_END")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}
