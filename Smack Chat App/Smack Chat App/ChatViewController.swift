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
    
    @IBOutlet weak var navigationBar : UINavigationBar!
    @IBOutlet weak var navigationBarItem: UINavigationItem!
    //MARK: VC Life Cycle Function
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupNavigationView()
    }
    
    private func setupNavigationView() {
        navigationBarItem.title = "#general"
        let Image = UIImageView(image: #imageLiteral(resourceName: "smackBurger"))
        Image.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        menuButton.setImage(#imageLiteral(resourceName: "smackBurger"), for: .normal)
        print("1 Menu Button = \(menuButton)")
        menuButton.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        print("2 Menu Button = \(menuButton)")
        navigationBarItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        print("NavigationItem = \(navigationItem)")
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        print("3 Menu Button = \(menuButton)")
    }
    
    //MARK: Menu Button Action
    @IBAction func revealButtonTapped(_ sender: Any) {
        delegate.showRevealVC()
    }
}
