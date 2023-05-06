//
//  Week2-redmango.swift
//  FirstProject
//
//  Created by redmango1446 on 2023/05/05.
//

import Foundation

//protocol yagomShop {
//    var productList: [String?] { get }
//
//    func checkProduct(number productNumber: Int) -> String?
//}

class Shop {
    private(set) var productsList: [String?]
    
    init(productsList: [String?]) {
        self.productsList = productsList
    }
    //check는 bool값을 반환하는것처럼 기대하게끔 할 수 있으니 다른 동사를 우회적으로 사용하는걸 권장
    func checkProduct(number productNumber: Int) -> String? {
        let maxProductNumber = productsList.count
        
        if productNumber >= maxProductNumber || productNumber < 0 {
            print("그런 제품은 저희 가게에서 취급하지 않습니다.")
            return nil
        }
        
        guard let product = productsList[productNumber] else {
            print("해당 제품은 현재 재고가 없습니다.")
            return productsList[productNumber]
        }
        
        productsList[productNumber] = nil
        
        return product
    }
}

struct Camper {
    private var budget: Int = 2000
    
    mutating func buy(productNumber: Int, at shop: Shop) {
        if budget >= 1000 {
            guard let product = shop.checkProduct(number: productNumber) else {
                return
            }
            budget -= 1000
            print("\(product)를 샀다.")
            print("현재 잔액은 \(budget)원이다.")
        } else {
            print("무언갈 사기엔 돈이 부족하다.")
        }
    }
}


