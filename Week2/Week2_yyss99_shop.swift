//
//  shop.swift
//  SaturdayWeek2
//
//  Created by Yeseul Jang on 2023/05/06.
//

class shop {
    var productsList: [String?] = ["볼펜", "텀블러", "다이어리", "에코백", "머그컵", "후드집업"]
    
    func sell(productNumber: Int) -> String? {
        
        guard let product = productsList[productNumber]  else {
            print("\(productNumber)번 상품은 없습니다.")
            return nil
        }
        print("\(productNumber)번 \(product) 있습니다.\n")
        productsList[productNumber] = nil
        print("남은 물건들: \(productsList)")
        return product
    }
}
