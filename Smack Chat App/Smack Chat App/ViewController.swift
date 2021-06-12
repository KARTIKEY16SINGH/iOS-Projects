//
//  ViewController.swift
//  Smack Chat App
//
//  Created by Iron Man on 02/05/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var revealView : UIView!
    @IBOutlet weak var revealVCWidthConstant: NSLayoutConstraint!
    var isShowingRevealVC = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealVCWidthConstant.constant = 0
        setupNavigationView()
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination  as? ChatViewController else {return}
        destinationVC.delegate = self
    }
    
    private func setupNavigationView() {
//        navigationBarItem.title = "#general"
        let Image = UIImageView(image: #imageLiteral(resourceName: "smackBurger"))
        Image.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        menuButton.setImage(#imageLiteral(resourceName: "smackBurger"), for: .normal)
        print("1 Menu Button = \(menuButton)")
        menuButton.layer.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        print("2 Menu Button = \(menuButton)")
//        navigationBarItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        print("NavigationItem = \(navigationItem)")
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        print("3 Menu Button = \(menuButton)")
    }
}

extension ViewController : RevealViewControllerDelegate {
    func showRevealVC() {
        if !isShowingRevealVC {
            self.revealVCWidthConstant.constant = UIScreen.main.bounds.width * 0.80
        } else {
            self.revealVCWidthConstant.constant = 0
        }
        isShowingRevealVC = !isShowingRevealVC
        UIView.animate(withDuration: TimeInterval.init(0.5)) {
            self.view.layoutIfNeeded()
        } completion: { (result) in
            
        }

    }
}
