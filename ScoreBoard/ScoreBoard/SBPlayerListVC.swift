//
//  SBPlayerListVC.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/11/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

class SBPlayerListVC: UIViewController, SBPlayerCellDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var playerSearchBar: UISearchBar!
    @IBOutlet weak var playerTableView: UITableView!
    
    var playerList : NSMutableArray?                // BASE ARRAY
    var filteredList : NSMutableArray?              // FILTER ARRAY
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.playerSearchBar.delegate = self
        self.playerTableView.delegate = self
        self.playerTableView.dataSource = self
        
        self.filteredList = NSMutableArray(array : self.playerList!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //====================================================================================================================================
    // TABLE VIEW DELEGATE
    //====================================================================================================================================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (filteredList?.count)!
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "SBTableCell") as! SBTableCell
        let player = filteredList?.object(at: indexPath.row) as! SBPlayer

        tableCell.playerNameLabel.text = player.name as String?
        
        return tableCell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = filteredList?.object(at: indexPath.row) as! SBPlayer
        print("SELECTED_PLAYER : \((player.name)!)")
    }
    
    
    //====================================================================================================================================
    // TABLE CELL DELEGATE
    //====================================================================================================================================
    
    internal func didTapFavouriteButton(cell: SBTableCell) {
        
    }
    
    //====================================================================================================================================
    // SEARCH BAR DELEGATE
    //====================================================================================================================================
    
    /*
     
     - (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
     
     dispatch_async(dispatch_get_main_queue(), ^{
     
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", searchText];
     [self.filteredArray removeAllObjects];
     NSArray *searchArray = [self.empList filteredArrayUsingPredicate:predicate];
     [self.filteredArray addObjectsFromArray:searchArray];
     
     if (!searchText.length) {
     [self.filteredArray addObjectsFromArray:self.empList];
     [searchBar resignFirstResponder];
     }
     
     [self.empTableView reloadData];
     });
     }
     
     */
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        DispatchQueue.main.async {
         
            let predicate = NSPredicate(format: "name contains[cd] %@", searchText)
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
