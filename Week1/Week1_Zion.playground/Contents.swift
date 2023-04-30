import UIKit

// MARK : Step1
var productList: [String?] = ["볼펜", "텀블러", "다이어리", "에코백", "머그컵", "후드집업"]

func optionalBinding() {
    for (index, product) in productList.enumerated() {
        if let product = product {
            print("\(index)번 상품은 \(product)입니다.")
        }
    }
}

func optionalDefault() {
    for (index, product) in productList.enumerated() {
        print("\(index)번 상품은 \(product ?? "없는 상품")입니다.")
    }
}

func explicitBinding() {
    for (index, product) in productList.enumerated() {
        print("\(index)번 상품은 \(product!)입니다.")
    }
}

func optionalPattern() {
    for (index, product) in productList.enumerated() {
        switch product {
            case .some(let product):
                print("\(index)번 상품은 \(product)입니다.")
            case .none:
                print("\(index)번 상품은 없는 상품입니다.")
        }
        
        if case let product? = product {
            print("\(index)번 상품은 \(product)입니다.")
        }
    }
}

//print("출력 예시")
//optionalPattern()

// MARK : Step2
enum BuyError: Error {
    case wrongGoodsNumber
    case soldOut
    case insufficientBalance
}

var budget: Int = 2000
var productsList: [String?] = ["볼펜", "텀블러", "다이어리", "에코백", "머그컵", "후드집업"]

func verifyPurchaseOfGoods(_ goodsNumber: Int) -> Result<Bool, BuyError> {
    guard 0...5 ~= goodsNumber else { return .failure(.wrongGoodsNumber) }
    guard productList[goodsNumber] != nil else { return .failure(.soldOut) }
    guard budget >= 1000 else { return .failure(.insufficientBalance) }
    
    return .success(true)
}

func processPurchaseOfGoods(_ goodsNumber: Int) {
    print("상품구매를 완료하였습니다. : \(productList[goodsNumber] ?? "정보없음")")
    productList[goodsNumber] = nil
    budget -= 1000
}

func printErrorMessage(_ error: BuyError) {
    switch error {
        case .wrongGoodsNumber:
            print("유효하지 않은 상품번호입니다.")
        case .soldOut:
            print("상품 매진입니다.")
        case .insufficientBalance:
            print("잔액이 부족합니다.")
    }
}

func purchase(productNumber: Int) {
    let resultPurchaseOfGoods = verifyPurchaseOfGoods(productNumber)
    
    switch resultPurchaseOfGoods {
        case .success:
            processPurchaseOfGoods(productNumber)
        case .failure(let error):
            printErrorMessage(error)
    }
}

for randomNumber in [6, 1, 2, 3, 0, 4, 1, 2] {
    purchase(productNumber: randomNumber)
}
