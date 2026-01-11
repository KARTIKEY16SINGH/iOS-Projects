//
//  ViewController.swift
//  RapidoTest
//
//  Created by Iron Man on 10/01/26.
//

import UIKit

final class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpTabs()
    }
    
    private func setUpTabs() {
        let tabsControllers = getTabViewControllers(for: Tabs.allCases)
        viewControllers = tabsControllers
        selectedViewController = tabsControllers.first
    }

    private func getTabViewControllers(for tabs: [Tabs]) -> [UIViewController] {
        tabs.map(TabsBuilder().build(tab:))
    }
}

