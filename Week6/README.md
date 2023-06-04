# 6주차: UML(Unified Modeling Language)
## 🔥실험 목표
- UML을 바탕으로 코드를 작성할 수 있다.

![](https://hackmd.io/_uploads/r1QpaAFUn.png)

- 개발자간의 의사소통이 필요한 이유는 협업을 위해서이다. 협업시 가장 위험한 것은 특정 주제에 대해서 모두가 같은 이해를 가지긴 힘들다는 것이다.
- 따라서 개발의 산출물을 가지고 같은 것을 보면서 논의 할 수 있어야 한다.
- 또한, 언어적인 특성을 가지고 있기 때문에 같은 부분이라고 해도 다른 표현을 사용해서 나타낼 수 있다.

![](https://hackmd.io/_uploads/SJ3_ACF82.png)
- Class 간의 Interface를 어떻게 가지고 가고 있는지 의존 및 연관관계가 어떻게 되어있는지를 확인할 때 주로 사용한다.
- 공통된 class diagram을 보면서 코드를 작성하기 전에 해당 기능 및 모듈이 올바르게 설계되어 있는지 리뷰를 하며 더 좋은 설계를 가져갈 수 있다.

![](https://hackmd.io/_uploads/HyuT0RYLh.png)
- 주로 특정 기능의 동작의 흐름을 메서드 수준에서의 구체적으로 알고 싶을 때 사용한다.
- class Diagram과는 다르게 기능의 순서 및 흐름을 이해하는데 주로 사용한다.
- 
![](https://hackmd.io/_uploads/HkJVXk583.png)
- 프로그램의 전체적인 흐름을 이해하는데 사용되어지는 diagram의 종류이다.
- 세부적인 기능사항 보다는 흐름자체에 집중할 수 있다.

![](https://hackmd.io/_uploads/S1jmNJqLn.png)
- 여러가지 중에서도 눈여겨 봐야할 건 각 class 간의 의존 및 연관 관계를 알 수 있는 Class Diagram이다.
- 코드를 작성하기 전에 구현할 기능 및 모듈의 설계에 대해 논의할 수 있다는 점에서 의미가 크다.
- 일반화, 실체와, 의존, 연관등 많은 요소들을 하나의 diagram에서 표현할 수 있다.
- input, output을 무조건적으로 가지는 프로그램의 특성상 한눈에 보기 쉽게 표현할 수 있다.

![](https://hackmd.io/_uploads/H1UmrJcIh.png)
- 의존
어떤 기능이나 행위를 하는 데에 있어서 필요한 인스턴스 및 객체가 있다면 우리는 그것에 의존한다.
어떤 클래스가 다른 클래스를 참조한다면 의존한다고 할 수 있다.
A 클래스가 B을 참조하여 여러 기능을 수행한다면 A는 B에 의존한다 할 수 있다.
초기화를 통해서 의존성이 주입이 되는 경우에도 초기화를 하기 위한 기능 즉, init에서 해당 객체가 필요한 것이므로 의존이 맞다.

- 연관
의존 보다는 조금 넓은 개념으로 사용된다.
해당 클래스에서 연관된 모든 것 들을 연관되었다고 표현한다.
또한 행위나 기능상에 호출되지 않았더라도 해당 클래스 외부에서 사용되어질 수 도 있으므로 의존과는 다른 의미이다.(A 클래스 내의 B 프로퍼티는 A 클래스에서 행위나 기능을하는데 사용되어지지 않으므로 의존관계라 할 수 없다. 하지만 A 클래스 외부에서 A 클래스를 통해 호출되어 사용되어지므로 A는 B와 연관관계이다.)

[금주의 실험 주제] : 작성된 UML을 바탕으로 코드를 작성해봅시다.
![](https://hackmd.io/_uploads/S1PvHy9Uh.png)


```swift
enum CoffeeMenu: String {
    case americano = "아메리카노"
    case latte = "라떼"
    
    var price: Int {
        switch self {
        case .americano:
            return 2000
        case .latte:
            return 2500
        }
    }
}

class Coffee {
    var kind: CoffeeMenu
    var amount: Int
    
    init(kind: CoffeeMenu, amount: Int) {
        self.kind = kind
        self.amount = amount
    }
}

class CoffeeShop {
    var manager: CafeManager
    
    init(manager: CafeManager) {
        self.manager = manager
    }
    
    func order(_ menu: CoffeeMenu) {
        manager.brew(menu)
    }
}
```

```swift
class Person {
    var name: String
    var money: Int
    var coffee: Coffee?
    
    init(name: String, money: Int) {
        self.name = name
        self.money = money
    }
    
    func buy(_ menu: CoffeeMenu, at shop: CoffeeShop) {
        if menu.price <= money {
            shop.order(menu)
            money -= menu.price
            return
        }
        
        print("잔액이 부족합니다.")
    }
}

class CafeManager: Person{
    func brew(_ menu: CoffeeMenu) {
        print("\(menu.rawValue)가 완성됬습니다.")
    }
}
```

![](https://hackmd.io/_uploads/H1_prJcLn.png)
- 소스코드의 의존성은 제어흐름에 따라 결정된다.
- 단순히 제어흐름에 의해 의존성이 향하는 것이 아닌 Interface 방향으로 의존성이 역전되기 때문이다.
