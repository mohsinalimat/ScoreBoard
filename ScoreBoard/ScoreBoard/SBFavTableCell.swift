//
//  SBFavTableCell.swift
//  ScoreBoard
//
//  Created by Abhishek Thapliyal on 3/12/17.
//  Copyright © 2017 Abhishek Thapliyal. All rights reserved.
//

import UIKit

class SBFavTableCell: UITableViewCell {
    
    @IBOutlet weak var playerImgView: UIImageView!
    @IBOutlet weak var playerName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
