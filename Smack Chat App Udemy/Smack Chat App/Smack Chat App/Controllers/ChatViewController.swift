//
//  ChatViewController.swift
//  Smack Chat App
//
//  Created by Iron Man on 13/06/21.
//

import UIKit

class ChatViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var menuButton: UIButton!
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
    }

}
