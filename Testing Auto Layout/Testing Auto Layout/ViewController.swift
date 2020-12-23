//
//  ViewController.swift
//  Testing Auto Layout
//
//  Created by Kartikey Singh on 23/12/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for _ in 1...10 {
            let button = UIButton()
            button.backgroundColor = .red
            button.frame = CGRect(x: button.layer.frame.origin.x, y: button.layer.frame.origin.y, width: 50, height: 50)
            stackView.addSubview(button)
        }
    }


}

