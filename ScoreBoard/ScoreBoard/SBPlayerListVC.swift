//
//  SBPlayerListVC.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/11/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit
import SDWebImage

class SBPlayerListVC: UIViewController, SBPlayerCellDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var playerSearchBar: UISearchBar!
    @IBOutlet weak var playerTableView: UITableView!
    @IBOutlet weak var totalCount: UILabel!
    
    var playerList : NSMutableArray?                // BASE ARRAY
    var filteredList : NSMutableArray?              // FILTER ARRAY
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.playerSearchBar.delegate = self
        self.playerTableView.delegate = self
        self.playerTableView.dataSource = self
        
        self.filteredList = NSMutableArray(array : self.playerList!)
        self.totalCount.text = NSString(format: "Total Player %lu", (self.playerList?.count)!) as String
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUpNavigation()
    }
    
    func setUpNavigation() {
    
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white,
                                                                        NSFontAttributeName: UIFont(name: "Helvetica", size: 18) as Any]
        
        self.navigationController!.navigationBar.barTintColor = UIColor.blue
        self.navigationController!.navigationBar.tintColor = UIColor.white
    }
    
    //====================================================================================================================================
    // BUTTON ACTIONS
    //====================================================================================================================================
    
    @IBAction func sortAction(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Sort Types", message: nil, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel , handler:nil)
        
        let totalRun = UIAlertAction(title: "Runs", style: .default) { action in
            self.sortArray(param: "total_score")
        }
        
        let totalMatches = UIAlertAction(title: "Matches", style: .default) { action in
            self.sortArray(param: "matches_played")
        }
        
        alertController.addAction(totalRun)
        alertController.addAction(totalMatches)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true , completion:nil)
    }

    
    @IBAction func favouriteButton(_ sender: Any) {
    
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let favouriteVC = storyBoard.instantiateViewController(withIdentifier: "SBFavouriteVC") as! SBFavouriteVC
        self.navigationController?.pushViewController(favouriteVC, animated: true)
    }
    
    func sortArray(param: NSString?) {
        
        let descriptor = NSSortDescriptor(key: param as String?, ascending: false)
        self.filteredList = NSMutableArray(array : (self.playerList?.sortedArray(using: [descriptor]))!)
        self.playerTableView.reloadData()
    }

    //====================================================================================================================================
    // TABLE VIEW DELEGATE
    //====================================================================================================================================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (filteredList?.count)!
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "SBTableCell") as! SBTableCell
        tableCell.delegate = self
        
        let player = filteredList?.object(at: indexPath.row) as! SBPlayer

        DispatchQueue.main.async {
            tableCell.playerImageView.layer.cornerRadius = tableCell.playerImageView.frame.size.width/2;
            tableCell.playerImageView.layer.masksToBounds = true
        }        
        
        tableCell.playerNameLabel.text = player.name as String?
        
        var image = UIImage(named: "favourite_default.png")
        if ((player.favourite!)) {
            image = UIImage(named: "favourite_set.png")
        }
        
        if (player.image != nil) {
            
            let imageURL = NSURL(string : player.image as! String)
            tableCell.playerImageView.sd_setImage(with: imageURL as URL!, placeholderImage: UIImage(named: "user_default.png"))
        }
        
        tableCell.favouriteButton.setImage(image, for: .normal)
        
        return tableCell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let player = filteredList?.object(at: indexPath.row) as! SBPlayer
        print("SELECTED_PLAYER : \((player.name)!)")
        
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let playerDetailVC = storyBoard.instantiateViewController(withIdentifier: "SBPlayerDetailVC") as! SBPlayerDetailVC
        playerDetailVC.player = player
        self.navigationController?.pushViewController(playerDetailVC, animated: true)
    }
    
    //====================================================================================================================================
    // TABLE CELL DELEGATE
    //====================================================================================================================================
    
    internal func didTapFavouriteButton(cell: SBTableCell) {
     
        let indexPath = self.playerTableView.indexPath(for: cell)
        let player = filteredList?.object(at: (indexPath?.row)!) as! SBPlayer
        player.favourite = !(player.favourite!)
        var image = UIImage(named: "favourite_default.png")
        
        if ((player.favourite!)) {
            image = UIImage(named: "favourite_set.png")
        }
        
        SBDBManager().updatEntity(id: player.id, flag: player.favourite!)
        
        cell.favouriteButton.setImage(image, for: .normal)
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
            self.playerTableView.reloadData()
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
