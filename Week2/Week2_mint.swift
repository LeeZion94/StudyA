//
//  Camper.swift
//  type_study
//
//  Created by mint on 2023/05/05.
//

class Shop {
    var productsList: [String?] = ["볼펜", "텀블러", "다이어리", "에코백", "머그컵", "후드집업"]
    var revenue: Int = 0
}

class ShopManager {
    var shop: Shop
    
    init(shop: Shop) {
        self.shop = shop
    }
    
    func checkProduct(_ productNumber: Int) -> Bool {
        var canBuy: Bool
        if productNumber > shop.productsList.count - 1 {
            print("상품이 존재하지 않습니다.")
            canBuy = false
        } else if shop.productsList[productNumber] != nil {
            canBuy = true
        } else {
            print("상품이 품절 되었습니다.")
            canBuy = false
        }
        return canBuy
    }
    
    func takeBudget(_ productNumber: Int) {
        shop.productsList[productNumber] = nil
        shop.revenue += 1000
    }
}


class Camper {
    var budget: Int
    //var manager: ShopManager
    
    init(budget: Int) {
        self.budget = budget
        //self.manager = manager
    }

    func buy(productNumber: Int, manager: ShopManager) {
        if manager.checkProduct(productNumber) {
            print("\(productNumber)번 주세요.")
            checkBudget(productNumber, manager)
        }
    }
    
    private func checkBudget(_ productNumber: Int, _ manager: ShopManager) {
        if budget < 1000 {
            print("예산이 부족하네요.")
        } else if let product = manager.shop.productsList[productNumber] {
            print("\(product)을/를 구매했어요!")
            payBudget(productNumber, manager)
        }
    }
    
    private func payBudget(_ productNumber: Int, _ manager: ShopManager) {
        budget -= 1000
            
        print("잔액이 \(budget) 만큼 남았습니다.")
        manager.takeBudget(productNumber)
    }
}
