//
//  PositionsData.swift
//  SunburstChartDemo
//
//  Created by Daniel Bolella on 5/1/24.
//

import Foundation

struct MarketData: Identifiable, Hashable {
    var id = UUID()
    
    let name: String
    let total: Double
    let type: MarketType
    
    let children: [MarketData]
}

enum MarketType {
    case fruit
    case vegetable
    case meat
    case other
}

let mockData: [MarketData] = [
    .init(name: "Fruits", total: 63000.0, type: .fruit, children: [
        .init(name: "Apple", total: 40000.0, type: .fruit, children: []),
        .init(name: "Orange", total: 15000.0, type: .fruit, children: []),
        .init(name: "Grapes", total: 5000.0, type: .fruit, children: []),
        .init(name: "Bananas", total: 3000.0, type: .fruit, children: [])
    ]),
    .init(name: "Vegetables", total: 25000.0, type: .vegetable, children: [
        .init(name: "Zucchini", total: 17000.0, type: .vegetable, children: []),
        .init(name: "Spinach", total: 8000.0, type: .vegetable, children: [])
    ]),
    .init(name: "Meats", total: 7000.0, type: .meat, children: [
        .init(name: "Beef", total: 5000.0, type: .meat, children: []),
        .init(name: "Chicken", total: 2000.0, type: .meat, children: [])
    ]),
    .init(name: "Other", total: 30000.0, type: .other, children: [
        .init(name: "Pirate's Booty", total: 30000.0, type: .other, children: [])
    ])
]
