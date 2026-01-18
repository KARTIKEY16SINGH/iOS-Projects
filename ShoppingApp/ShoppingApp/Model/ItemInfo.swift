//
//  ItemInfo.swift
//  ShoppingApp
//
//  Created by Iron Man on 15/01/26.
//
import Foundation

struct ItemInfo: Decodable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: ItemRatingInfo
    var isFav: Bool? = false
}

struct ItemRatingInfo: Decodable {
    let rate: Double
    let count: Int
}
