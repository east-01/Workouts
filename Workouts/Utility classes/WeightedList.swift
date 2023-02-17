//
//  WeightedList.swift
//  Workouts
//
//  Created by Ethan Mullen on 2/11/23.
//

import Foundation

// Thanks ChatGPT
class WeightedList<T : Codable> : Codable {
    
    private struct WeightedItem : Codable {
        let item: T
        let weight: Int
    }
    
    private var items: [WeightedItem]
    private var totalWeight: Int
    
    init() {
        self.items = []
        self.totalWeight = 0
    }
    
    func addItem(_ item: T, weight: Int) {
        totalWeight += weight
        items.append(WeightedItem(item: item, weight: weight))
    }
        
    func random() -> T? {
        return random(removeChoice: false)
    }
    
    func count() -> Int {
        return items.count
    }
    
    // Add the ability to remove the choice
    func random(removeChoice: Bool) -> T? {
        guard totalWeight > 0 else { return nil }
        let randomWeight = Int.random(in: 1...totalWeight)
        var currentWeight = 0
        for i in 0..<items.count {
            let currentItem = items[i]
            currentWeight += currentItem.weight
            if currentWeight >= randomWeight {
                
                if(removeChoice) {
                    totalWeight -= currentItem.weight
                    items.remove(at: i)
                }
            
                return currentItem.item
            }
        }
        return nil
    }
    
}
