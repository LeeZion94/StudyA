//
//  FoodType.swift
//  Week9_MINT
//
//  Created by minsong kim on 2023/07/08.
//

enum FoodType: Int, CaseIterable {
    case American = 0
    case Chinese
    case Korean
    case Japanese
    
    var title: String {
        switch self {
        case .American:
            return "양식"
        case .Chinese:
            return "중식"
        case .Korean:
            return "한식"
        case .Japanese:
            return "일식"
        }
    }
    
    var menuBoard: [(menu: String, price: Int)] {
        switch self {
        case .American:
            return [
                (menu: "햄버거", price: 5000),
                (menu: "피자", price: 18000),
                (menu: "아메리카노", price: 41000)
            ]
        case .Chinese:
            return [
                (menu: "탕수육", price: 18000)
            ]
        case .Korean:
            return [
                (menu: "비빔밥", price: 8000),
                (menu: "돼지갈비", price: 20000)
            ]
        case .Japanese:
            return [
                (menu: "스시", price: 20000),
                (menu: "스윙스(돈까스)", price: 5000)
            ]
        }
    }
}
