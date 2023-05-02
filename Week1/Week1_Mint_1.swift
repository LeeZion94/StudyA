//
//  test 1.swift
//  1. optional
//
//  Created by minsong kim on 2023/04/27.
//

import Foundation

struct printList {
    var productsList: [String?] = ["볼펜", "텀블러", "다이어리", "에코백", "머그컵", "후드집업"]
    
    func printListWithIf() {
        for index in 0...productsList.count - 1 {
            if let product = productsList[index] {
                print("\(index)번 상품은 \(product)입니다.")
            }
        }
    }
    
    func printListWithCompactMap() {
        let products = productsList.compactMap{ $0 }
        for index in 0...products.count - 1 {
            print("\(index)번 상품은 \(products[index])입니다.")
        }
    }
    
    func printListWhitGuard() {
        for index in 0...productsList.count - 1 {
            guard let product = productsList[index] else {
                print("없는 상품입니다.")
                return
            }
            print("\(index)번 상품은 \(product)입니다.")
        }
    }
}
