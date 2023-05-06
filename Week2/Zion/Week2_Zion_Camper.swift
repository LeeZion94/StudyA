//
//  Camper.swift
//  Week2_Zion
//
//  Created by Hyungmin Lee on 2023/05/06.
//
class Camper {
    private var budget: Int = 2000
    private let shop = Shop()
    
    func buy(productNumber: Int) {
        guard let product = shop.processBuyproduct(productNumber) else {
            print("이미 매진된 상품 입니다.")
            return
        }
        
        budget -= 1000
        print("\(product) 구매완료")
    }
}
