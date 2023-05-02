###### tags: `SAT_study`

# 1주차 : Optional / 예외처리

### STEP 1: optional 값을 사용해봅시다.
<details>
<summary>1. optional binding</summary>
<div markdown="1">
    
```swift=
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
``` 
</div>
</details>

<details>
<summary>2. nil coalescing operator </summary>
<div markdown="1">

```swift=
func showProductsListNilCoalescing() {
    for index in 0...(productsList.count - 1) {
        print("\(index)번 상품은 \(productsList[index] ?? "재고가 없는 상태")입니다.")
    }
}
```
</div>
</details>

</div>
</details>

<details>
<summary>3. optional pattern</summary>
<div markdown="1">
    
```swift=
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
```

</div>
</details>

<details>
<summary>4. compactMap</summary>
<div markdown="1">

```swift=
func printListWithCompactMap() {
        let products = productsList.compactMap{ $0 }
        for index in 0...products.count - 1 {
            print("\(index)번 상품은 \(products[index])입니다.")
        }
    }
```
</div>
</details>

### STEP 2: Optional을 활용한 경우 예외사항을 처리해 봅시다.

<details>
<summary>1. do-catch, throw</summary>
<div markdown="1">

``` swift
var budget: Int = 2000
var productsList: [String?] = ["볼펜", "텀블러", "다이어리", "에코백", "머그컵", "후드집업"]

enum productError: Error {
    case noProduct
    case noMoney
}

func buy(productNumber: Int) throws {
    let maxProductNumber = productsList.count
    
    if productNumber >= maxProductNumber || productNumber < 0 {
        throw productError.noProduct
    }
        
    guard let product = productsList[productNumber] else {
        throw productError.noProduct
    }
    
    if budget >= 1000 {
        budget -= 1000
    } else {
        throw productError.noMoney
    }
    
    productsList[productNumber] = nil
    
    print("\(product)를 구매하셨습니다.")
    print("현재 잔액은 \(budget)입니다.")
}

func checkBuy() {
    do {
        try buy(productNumber: 1)
        try buy(productNumber: 2)
        try buy(productNumber: 3)
    } catch productError.noProduct{
        print("재고가 없습니다.")
    } catch productError.noMoney{
        print("돈이 부족합니다.")
    } catch {
        print("뭐야 이거 왜이래")
    }
}

```

</div>
</details>

<details>
<summary>2. Result Type</summary>
<div markdown="1">
    
```swift=
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
```
    
</div>
</details>
