//
//  SettingsTableViewCell.swift
//  Splitter App
//
//  Created by Iron Man on 27/03/21.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImage : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
