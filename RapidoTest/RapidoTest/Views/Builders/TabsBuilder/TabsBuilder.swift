//
//  TabsBuilder.swift
//  RapidoTest
//
//  Created by Iron Man on 10/01/26.
//

import UIKit

protocol TabsBuildable {
    func build(tab: Tabs) -> UIViewController
}

struct TabsBuilder: TabsBuildable {
    func build(tab: Tabs) -> UIViewController {
        switch tab {
        case .uiKit:
            return TaskListBuilder().build()
        }
    }
}
