//
//  CellTableView.swift
//  covoiturageV1_2
//
//  Created by houssem on 8/17/18.
//  Copyright © 2018 houssem. All rights reserved.
//

import UIKit

class CellTableView: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var numberPlacesLbl: UILabel!
    @IBOutlet weak var hourLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var fromLbl: UILabel!
    @IBOutlet weak var toLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
