//
//  ItemRepository.swift
//  ShoppingApp
//
//  Created by Iron Man on 15/01/26.
//

protocol ItemRepositoryable {
    func fetchItems() -> [ItemInfo]
    func update(item: ItemInfo)
}

final class ItemRepository: ItemRepositoryable {
    func fetchItems() -> [ItemInfo] {
        []
    }
    
    func update(item: ItemInfo) {
        
    }
    

}
