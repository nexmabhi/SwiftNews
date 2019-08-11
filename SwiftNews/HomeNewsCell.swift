//
//  HomeNewsCell.swift
//  SwiftNews
//
//  Created by Dsilva on 11/08/19.
//  Copyright © 2019 Dsilva. All rights reserved.
//

import UIKit

class HomeNewsCell: UITableViewCell {

    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
