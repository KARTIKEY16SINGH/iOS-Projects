//
//  SwiftUIAddTaskView.swift
//  RapidoTest
//
//  Created by Iron Man on 11/01/26.
//

import SwiftUI

struct SwiftUIAddTaskView: View {
    let viewModel: TaskListViewModeling
    @Binding var displaySheet: Bool
    @State var titleText: String = ""
    @State var descriptionText: String = ""
    
    var body: some View {
        VStack(spacing: 10) {
            VStack(alignment: .leading) {
                TextField("Title", text: $titleText)
                TextField("Description", text: $descriptionText)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            Button("Add") {
                viewModel.handle(action: .addTask(title: titleText, description: descriptionText))
                displaySheet.toggle()
            }
        }
        
    }
}

#Preview {
    SwiftUIAddTaskView(viewModel: TaskListViewModel(repository: TaskRepository(persistenceStorage: PersistenceContainer.shared, dataModifier: TaskModifier())), displaySheet: .constant(true))
}
