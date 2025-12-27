//
//  PaymentViewModel.swift
//  SwiftUIApp
//
//  Created by Iron Man on 25/12/25.
//

import Foundation

@Observable
final class PaymentViewModel {
    var methods: [PaymentMethod] = []
    var selectedId: Int?
}

struct PaymentMethod: Identifiable {
    let id: Int
    let name: String
}
