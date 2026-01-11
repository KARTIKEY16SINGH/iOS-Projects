//
//  SwfitUITaskListBuilder.swift
//  RapidoTest
//
//  Created by Iron Man on 11/01/26.
//

import SwiftUI

struct SwfitUITaskListBuilder {
    func build() -> some UIViewController {
        let repository = TaskRepository(persistenceStorage: PersistenceContainer.shared, dataModifier: TaskModifier())
        let viewModel = TaskListViewModel(repository: repository)
        let view = SwiftUITaskListView(viewModel: viewModel)
        let controller = UIHostingController(rootView: view)
        controller.title = "SwiftUI"
        return controller
    }
}
