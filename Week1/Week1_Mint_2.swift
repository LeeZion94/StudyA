//
//  test 2.swift
//  1. optional
//
//  Created by minsong kim on 2023/04/29.
//

import Foundation

struct buyProduct {
    var budget: Int
    private var productsList: [String?] = ["볼펜", "텀블러", "다이어리", "에코백", "머그컵", "후드집업"]
    
    init(budget: Int) {
        self.budget = budget
    }
    
    mutating func selectProduct(_ productNumber: Int) {
        if productNumber > productsList.count - 1 {
            print("상품이 존재하지 않습니다.")
        } else if let product = productsList[productNumber] {
            checkBudget(productNumber, product)
        } else {
            print("상품이 품절 되었습니다.")
        }
    }
    
    private mutating func checkBudget(_ productNumber: Int, _ product: String) {
        if budget < 1000 {
            print("예산을 초과하였습니다.")
        } else {
            print("\(product)을/를 구매하였습니다.")
            payBudget(productNumber)
        }
    }
    
    private mutating func payBudget(_ productNumber: Int) {
        budget -= 1000
        productsList[productNumber] = nil
            
        print("잔액이 \(budget) 만큼 남았습니다.")
    }
}
