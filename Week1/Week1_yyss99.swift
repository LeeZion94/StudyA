//
//  main.swift
//  SaturdayStudy(Optional)
//
//  Created by Yeseul Jang on 2023/05/01.
//
// 실험 1
var productsList: [String?] = ["볼펜", "텀블러", "다이어리", "에코백", "머그컵", "후드집업"]

func showProductsListWithIfLet() {
    for index in 0...(productsList.count - 1) {
        if let product = productsList[index] {
            print("\(index)번 상품은 \(product)입니다.")
        } else {
            print("\(index)번 상품은 없습니다.")
        }
    }
}

func showProductsListWithGuardLet() {
    for index in 0...(productsList.count - 1) {
        guard let product = productsList[index] else {
            print("\(index)번 상품은 없습니다.")
            return
        }
        print("\(index)번 상품은 \(product)입니다.")
    }
}

func showProductsListNilCoalescing() {
    for index in 0...(productsList.count - 1) {
        print("\(index)번 상품은 \(productsList[index] ?? "재고가 없는 상태")입니다.")
    }
}

//if let, guard let, nil-coalescing
//showProductsListWithIfLet()
//showProductsListWithGuardLet()
//showProductsListNilCoalescing()


// 실험 2
var budget: Int = 2000

func buy(productNumber: Int) {
    if let product = productsList[productNumber] {
        if budget >= 1000 {
            budget -= 1000
            
            print("\(productNumber)번 상품 \(product) 구입 완료")
            print("현재 잔액: \(budget)")
            
            productsList[productNumber] = nil
        } else {
            print("잔액이 부족합니다.")
        }
    } else {
        print("\(productNumber)번 상품은 없습니다.")
    }
}

// 추가실험 키워드 throw
enum buyError: Error {
    case lackOfMoney
    case outOfStock
}

func buyWithError(productNumber: Int) throws {
    guard let  product = productsList[productNumber] else { throw buyError.outOfStock }
    if budget >= 1000 {
        budget -= 1000
        
        print("\(productNumber)번 상품 \(product) 구입 완료")
        print("현재 잔액: \(budget)")
        
        productsList[productNumber] = nil
    } else {
        throw buyError.lackOfMoney
    }
}

do {
    try buyWithError(productNumber: 1)
    try buyWithError(productNumber: 1)
} catch buyError.lackOfMoney {
    print("잔액이 부족합니다.")
} catch buyError.outOfStock {
    print("해당 상품은 없습니다.")
}
