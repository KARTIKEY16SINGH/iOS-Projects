//
//  BookingTableViewCell.swift
//  GoMmt
//
//  Created by Iron Man on 11/04/21.
//

import UIKit

class BookingRequestTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var detailLabel : UILabel!
    @IBOutlet weak var iconImageView : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
