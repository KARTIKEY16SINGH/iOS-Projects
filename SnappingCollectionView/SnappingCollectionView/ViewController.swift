//
//  ViewController.swift
//  SnappingCollectionView
//
//  Created by Iron Man on 01/11/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let snappingVC = SnappingCollectionViewController()
//        let snappingVC = FlowLayoutSnappingCollectionViewController()
        
        navigationController?.pushViewController(snappingVC, animated: true)
    }


}

