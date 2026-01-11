//
//  TaskListBuilder.swift
//  RapidoTest
//
//  Created by Iron Man on 10/01/26.
//

import UIKit

struct TaskListBuilder {
    func build() -> some UIViewController {
        let viewController = TaskListViewController()
        let repository = TaskRepository(persistenceStorage: PersistenceContainer.shared, dataModifier: TaskModifier())
        let viewModel = TaskViewModel(repository: repository)
        viewModel.view = viewController
        viewController.build(with: viewModel, addTaskControllerType: AddTaskViewController.self)
        return UINavigationController(rootViewController: viewController)
    }
}
