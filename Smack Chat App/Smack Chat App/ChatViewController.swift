//
//  ChatViewController.swift
//  Smack Chat App
//
//  Created by Iron Man on 02/05/21.
//

import UIKit

protocol RevealViewControllerDelegate : AnyObject {
    func showRevealVC()
}
class ChatViewController : UIViewController {
    
    weak var delegate : RevealViewControllerDelegate!
    
    @IBAction func revealButtonTapped(_ sender: Any) {
        delegate.showRevealVC()
    }
}
