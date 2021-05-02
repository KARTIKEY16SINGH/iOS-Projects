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
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination  as? ChatViewController else {return}
        destinationVC.delegate = self
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
