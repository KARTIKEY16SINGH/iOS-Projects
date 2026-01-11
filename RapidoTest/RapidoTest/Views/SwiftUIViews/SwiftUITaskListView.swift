//
//  SwiftUITaskListView.swift
//  RapidoTest
//
//  Created by Iron Man on 11/01/26.
//

import SwiftUI

struct SwiftUITaskListView: View {
    let viewModel: TaskListViewModeling
    @State var displaySheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.dataSource) { item in
                    VStack(alignment: .leading) {
                        Text(item.title)
                            .font(.title)
                        
                        Text(item.decription)
                            .font(.subheadline)
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Delete", role: .destructive) {
                            viewModel.handle(action: .delete(task: item))
                        }
                        Button {
                            viewModel.handle(action: .toggleCompletion(task: item))
                        } label: {
                            Text(item.isCompleted ? "Mark Incomplete" : "Mark Complete")
                        }
                    }
                }
            }
            .toolbar {
                Image(systemName: "plus")
                    .onTapGesture {
                        displaySheet.toggle()
                    }
            }
        }
        .sheet(isPresented: $displaySheet) {
            SwiftUIAddTaskView(viewModel: viewModel, displaySheet: $displaySheet)
                .padding()
        }
        .onAppear {
            viewModel.handle(action: .viewLoaded)
        }
    }
}

#Preview {
    SwiftUITaskListView(viewModel: TaskListViewModel(repository: TaskRepository(persistenceStorage: PersistenceContainer.shared, dataModifier: TaskModifier())))
}
