//
//  YagomGoods.swift
//  Week2_Zion
//
//  Created by Hyungmin Lee on 2023/05/06.
//

class Shop {
    private(set) var productsList: [String?] = ["볼펜", "텀블러", "다이어리", "에코백", "머그컵", "후드집업"]
    
    func processBuyproduct(_ productNumber: Int) -> String? {
        guard let product = productsList[productNumber] else {
            return nil
        }
        
        productsList[productNumber] = nil
        return product
    }
}
