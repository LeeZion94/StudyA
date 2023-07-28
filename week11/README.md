# 11주차: Protocol Oriented Programming
## Protocol Oriented Programming

Protocol Oriented Programming(프로토콜 지향 프로그래밍)
 - Protocol Oriented Programming(POP) 탄생 배경
일반적으로 OOP에서 클래스의 상속 개념을 통해 공통 기능들을 모듈화하여 사용할 수 있었으나, 구조체 혹은 열거형의 경우에는 상속이 불가하기에 같은 타입에 대해서 공통적인 기능 구현을 위해서는 다른 방법을 이용해야 합니다.

- 이를 해결하기 위한 방안이 Apple WWDC15(Swift 2)에서 Extension 발표되었습니다.
Protocol(청사진)을 구현하고 Extension으로 해당 프로토콜의 기능을 확장하는 형태로 사용합니다.
이를 프로토콜 초기 구현(Protocol Default Implementation)이라고 표현합니다.


```swift
protocol MacBookChargeabel {
    var maximumWattPerHour: WattPerHour { get }
    
    //충전기와 기기의 허용 와트시를 검사해서, 기기의 허용 와트시가 더 낮다면, 
    //기기에 맞추어 와트시를 낮추어 반환합니다.
    func convert(chargeableWattPerHour: WattPerHour) -> WattPerHour
}

```
위와 같이 `Chargeabel` 프로토콜을 정의했다.

```swift
struct Charger: MacBookChargeabel {
    var maximumWattPerHour: WattPerHour
 
    func convert(chargeableWattPerHour: WattPerHour) -> WattPerHour {
        
        if maximumWattPerHour > chargeableWattPerHour {
            return chargeableWattPerHour
        }
        
        return maximumWattPerHour
    }
}

struct TroubleMacBookCharger: MacBookChargeabel {
    var maximumWattPerHour: WattPerHour
    let troublenProbability: Int = Int.random(in: 1...100)
    var isTrouble: Bool {
        if self.troublenProbability > 50 {
            return true
        }
        return false
    }
    
    func convert(chargeableWattPerHour: WattPerHour) -> WattPerHour {
        guard isTrouble else {
            if maximumWattPerHour > chargeableWattPerHour {
                return chargeableWattPerHour
            }
            return maximumWattPerHour
        }
        return maximumWattPerHour
    }
}
```
`MacBookChargeabel`프로토콜을 채택한 `Charger`타입과 `TroubleMacBookCharger`가 있다고 해보자.

```swift 
 struct MacBook: Portable {
    private let 기기허용충전와트시: Watt = 20
    private let 현재저장된배터리용량 : Watt = 20
    private let 최대배터리용량: Watt = 100

    mutating func chargerBattery(charger: TroubleMacBookCharger) {
        let 필요한배터리량 = 최대배터리용량 - 현재저장된배터리용량
        let 충전되는배터리량 = charger.convert(chargeableWattPerHour: 기기허용충전와트시)
        
        guard 충전되는배터리량 <= 기기허용충전와트시 else {
            print("과충전으로 맥북의 회로가 타버렸습니다. 유감입니다.")
            return
        }
        
        let 완충까지걸린시간 = 필요한배터리량/충전되는배터리량
        print("완충까지 걸린 시간: \(완충까지걸린시간)시간")
    }
}
```
`MacBook`타입은 배터리충전기능 사용시 `TroubleMacBookCharger`타입을 필요로한다. 

```swift
var macBook = MacBook()

let 애플워치충전기: Charger = Charger(maximumWattPerHour: 5)
let 아이폰고속충전기: Charger = Charger(maximumWattPerHour: 18)
let 아이패드충전기: Charger = Charger(maximumWattPerHour: 30)
let 노트북충전기: Charger = Charger(maximumWattPerHour: 96)
let 고속노트북충전기: Charger = Charger(maximumWattPerHour: 106)
let 낡은맥북충전기: TroubleCharger = TroubleCharger(maximumWattPerHour: 96)

macBook.chargerBattery(charger: 낡은맥북충전기) // 4시간 or 일정확률로 회로가 구워진 맥북
macBook.chargerBattery(charger: 노트북충전기) // error / 호환이 안된다!
```
이런 경우 맥북을 충전할때마다 충전이 될지 일정확률로 장작이 되어버릴지 몰라 벌벌떨게 될것이다. 그렇지만 애플에 문의해도 충전할때 `TroubleCharger`만 쓸 수 있다고 하니 어쩔 수 없다. 맥북이 장작이 되면 애플본사도 장작으로 만들어주는 수 밖에...
하지만 얼마 지나지 않아 애플도 문제를 파악했는지 맥북을 전부 수거해 개조(?)를 해 줬다!
충전시 다른 충전기를 사용할 수 있게 해준것이다! 물론 애플이 제시한 충전기 규약 `MacBookChargeabel`프로토콜을 채택해 준수하는 충전기만 사용 가능하다고 했지만 이게 어디인가!

```swift
struct MacBook: Portable {
    private let 기기허용충전와트시: Watt = 20
    private let 현재저장된배터리용량 : Watt = 20
    private let 최대배터리용량: Watt = 100

    mutating func chargerBattery(charger: MacBookChargeabel) {
        let 필요한배터리량 = 최대배터리용량 - 현재저장된배터리용량
        let 충전되는배터리량 = charger.convert(chargeableWattPerHour: 기기허용충전와트시)
        
        guard 충전되는배터리량 <= 기기허용충전와트시 else {
            print("과충전으로 맥북의 회로가 타버렸습니다. 유감입니다.")
            return
        }
        
        let 완충까지걸린시간 = 필요한배터리량/충전되는배터리량
        print("완충까지 걸린 시간: \(완충까지걸린시간)시간")
    }
}
``` 
이제 우린 문제있는 충전기를 갖다 버리고 안전한 충전기로 맥북을 충전할 수 있다. 애플 만세!

```swift
macBook.chargerBattery(charger: 노트북충전기) // 4시간
```

위와 같이 프로토콜을 활용할 경우 일단 우린 타입을 알 필요가 없어진다.
그래서 Protocol을 이용하면 개발자는 구체적인 Type에 일일히 대응하거나 특정 구조체(Type)를 return하는 경우들 하나하나에 연연하지 않을 수 있다.
기존에 구체적인 타입 하나하나에 의존했다면 이젠 추상적인 프로토콜만 의존하면 된다는 뜻이다. 

만일 프로토콜을 사용하지 않았다면 맥북은 여러방법으로 문제를 해결해야했을것이고 그중 하나의 방법이 아래와 같을 수 있다.
```swift
struct MacBook: Portable {
    let ...

    mutating func chargerBatteryPortA(charger: TroubleMacBookCharger) {
       ...
    }

    mutating func chargerBatteryPortB(charger: Charger) {
        ...
    }
}
``` 

똑같은 코드를 매개변수의 타입만 바꿔서 추가한것이다. 프로토콜을 사용하면 이러한 중복된 코드를 피할 수 있게 해준다. 즉 재사용성이 높아진다.
그리고 만약 `Charger`타입의 기능이 변경되거나 삭제된다면 `chargerBatteryPortB`메서드의 작동에 문제가 생길 수 있는데, 프로토콜을 채택 및 준수한다는것은 채택한 타입에서 기능이 구현 되어있고 변경되거나 삭제될리 없다는걸 보장함으로 이러한 문제와 관련해선 메서드의 작동에 문제가 생길일이 없어진다.

아래는 POP의 장점을 간략하게 정리해본것이다.
- 코드의 중복을 최소화 할 수 있다.
- 가볍고 안전하다.
    - 상속과 달리 필요한 것만 골라서 쓸 수 있다.
    - 상속의 경우, 참조 타입이므로 참조 추적을 위한 비용이 많이 발생하기 때문에 속도측면에서 다소 느리다.
- 값 타입의 상속 효과
    - 공통된 기능을 쉽게 구현할 수 있다.
- 수평적인 확장 기능
    - Class는 하나의 상속만 가능하고 수직적인 구조가 나타나지만 Protocol을 이용하면 수평적인 확장이 가능하다.
- 제네릭의 활용
    - 예를 들어, Swift의 Array의 경우 데이터 타입의 관계 없이 만들 수 있고 이들 모두가 그에 따른 메서드를 사용할 수 있다.
