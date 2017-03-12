//
//  SBTableCell.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/11/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

protocol SBPlayerCellDelegate: class {
    func didTapFavouriteButton(cell: SBTableCell)
}

class SBTableCell: UITableViewCell {

    @IBOutlet weak var playerImageView: UIImageView?
    @IBOutlet weak var playerNameLabel: UILabel?
    @IBOutlet weak var nextImageView: UIImageView?
    @IBOutlet weak var favouriteButton: UIButton?

    weak var delegate: SBPlayerCellDelegate?
    
    @IBAction func favouriteAction(_ sender: Any) {
        self.delegate?.didTapFavouriteButton(cell: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
