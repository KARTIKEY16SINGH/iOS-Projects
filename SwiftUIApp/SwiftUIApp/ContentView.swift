//
//  ContentView.swift
//  SwiftUIApp
//
//  Created by Iron Man on 25/12/25.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel: PaymentViewModel
    @State var isShowingAddCard: Bool = false
    
    var body: some View {
        NavigationStack {
            List(viewModel.methods) { method in
                HStack {
                    Text(method.name)
                    Spacer()
                    if method.id == viewModel.selectedId {
                        Image(systemName: "checkmark")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.selectedId = method.id
                }
            }
            .sheet(isPresented: $isShowingAddCard) {
                
            } content: {
                Text("Sheet View")
            }
            .toolbar {
                Button("+") {
                    isShowingAddCard.toggle()
                }
            }
        }
        

    }
}

#Preview {
    let testViewModel = PaymentViewModel()
    testViewModel.methods = [.init(id: 1, name: "GooglePay"), .init(id: 2, name: "PhonePe"), .init(id: 3, name: "Paytem"), .init(id: 4, name: "Credit Card"), .init(id: 5, name: "Amazon Pay")]
    return ContentView(viewModel: testViewModel)
}
