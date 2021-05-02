//
//  ViewController.swift
//  GoMmt
//
//  Created by Iron Man on 10/04/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.pushViewController(UIStoryboard(name: "HostStoryboard", bundle: Bundle(for: ViewController.self)).instantiateInitialViewController() ?? HostViewController(), animated: true)
    }


}

