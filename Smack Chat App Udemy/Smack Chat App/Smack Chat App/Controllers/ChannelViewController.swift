//
//  ChannelViewController.swift
//  Smack Chat App
//
//  Created by Iron Man on 13/06/21.
//

import UIKit

class ChannelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController()?.rearViewRevealWidth = self.view.frame.size.width - 60
    }

}
