//
//  ChannelTableViewCell.swift
//  Smack Chat App
//
//  Created by Iron Man on 15/06/21.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {
    @IBOutlet weak var channelNameLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        channelNameLabel.text = ""
    }
}
