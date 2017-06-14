//
//  CustomBoard.swift
//  Tack
//
//  Created by Patrick Mucsi on 2/7/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import UIKit

class CustomBoard: UITableViewCell {

    @IBOutlet weak var BoardName: UILabel!
    @IBOutlet weak var BoardImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
