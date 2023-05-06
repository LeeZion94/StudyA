# 2주차: Type

### Type을 정의해서 인스턴스가 서로 객체지향적으로 소통할 수 있도록 해보자.

* 주요 개념: `상수`, `변수`, `함수`, `Optional`

![](https://hackmd.io/_uploads/HyvyTNXN2.png)
    
#### 🫠Object-Oriented Programming, OOP
컴퓨터 프로그램을 객체들의 유기적인 협력과 결합으로 본다는 패러다임.
객체들을 만들고 이 객체들을 조립해서 하나의 완성된 프로그램을 만든다.
    
🌸특징
- 추상화
- 캡슐화
- 은닉화
- 상속성
- 다형성

🌸장점
- 각자 독립적인 역할을 가지기에 코드의 변경을 최소화하고 유지보수를 하는 데 유리하다. 
- 코드의 재사용을 통해 반복적인 코드를 최소화한다.
- 코드를 최대한 간결하게 표현할 수 있다.
- 인간 친화적이고 직관적인 코드

<details>
<summary> 예제 코드 </summary>
<div markdown="1">

```swift=
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
    
    init(budget: Int) {
        self.budget = budget
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
                        
```
        
</div>
</details>
    
### Delegation Pattern
<details>
<summary>기본 예시 코드</summary>
<div markdown="1">
    
```swift=
protocol ProductSelectionDelegate {
    func didSelectProduct(imageName: String)
}

class BossViewController {
    var delegate: ProductSelectionDelegate?
    
    @objc func iphoneButtonTapped() {
        delegate?.didSelectProduct()
    }
    
}

class InternViewController: ProductSelectionDelegate {
    func presentBossViewController() {
        let bossViewController = BossViewController()
        bossViewController.delegate = self
        
        self.present(bossViewController)
    }
    
    func didSelectProduct(imageName: String) {
        // Statesments -> Select Product
    }
}
``` 
</div>
</details>
    
* 위의 예시는 BossViewController에서 iphone모양의 Button이 눌렸을 때 BossViewController에서 InterViewController로 String과 함께 event를 전달하는 방식을 Delegation Pattern을 사용해서 나타냈습니다. InterViewController는 ProductSelectionDelegate라는 protocol로 추상화 레이어로 한번 감싸져 있습니다. BossViewController의 delegate로 할당되어 이벤트를 전달받을 때 사용했습니다. BossViewController에서는 InterViewController가 protocol로 감싸져있기 때문에 didSelectProduct 메서드만 접근이 가능합니다.
