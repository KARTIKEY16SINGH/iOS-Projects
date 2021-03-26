//
//  MySplitViewController.swift
//  Splitter App
//
//  Created by Iron Man on 26/03/21.
//

import UIKit

class MySplitViewController: UISplitViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        if #available(iOS 14.0, *) {
            hide(.secondary)
            print("view controllers = \(viewControllers)")
        } else {
            // Fallback on earlier versions
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension MySplitViewController : UISplitViewControllerDelegate {
    @available(iOS 14.0, *)
    func splitViewController(_ svc: UISplitViewController, topColumnForCollapsingToProposedTopColumn proposedTopColumn: UISplitViewController.Column) -> UISplitViewController.Column {
        .primary
    }
}
