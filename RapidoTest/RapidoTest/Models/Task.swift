//
//  Task.swift
//  RapidoTest
//
//  Created by Iron Man on 10/01/26.
//

import Foundation

struct Task: Identifiable {
    let id: UUID
    let title: String
    let decription: String
    var isCompleted: Bool
    let dueDate: Date
}
