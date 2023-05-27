# 5주차: Singleton Pattern / View Life Cycle
## 🔥실험 목표
    
- View Life Cycle과 관련된 메서드가 언제, 어떤 상황에서 호출되는지 알 수 있다.
- Singleton Pattern을 활용해 다수의 View Controller가 정보를 공유하도록 할 수 있다.
* 주요 개념: `Singleton Pattern`, `view Life Cycle`
 
![](https://hackmd.io/_uploads/r1vXiJkL3.png)
    싱글톤이란 특정 용도로 객체를 단 하나만 생성해 공용으로 사용하는 디자인 패턴이다.
    어디서 호출하든지 전부 다 한 곳만 바라보고 있으며 마치 전역 변수와 같이 사용할 수 있다. 
    `유일한`
![](https://hackmd.io/_uploads/By0ViJyL2.png)
    어디서든 누구나 불러서 고칠 수 있는 민트 하우스! 나무는 무엇으로? 유리는 무엇으로?
    static을 사용해서 사용 시점에 초기화 해주며 private이 붙어서 다시 초기화할 수 없다.
![](https://hackmd.io/_uploads/rJ0rjk1Ih.png)
    1. 메모리를 단 한 번만 사용하기에 메모리 관리가 용이하고, 메모리릭 즉 메모리 누수가 발생하지 않는다. 
    -> 메모리 누수는 개발자가 의도하지 않은 메모리를 점유하고 있는 현상
    -> 보통 콜렉션에 저장한 객체를 해지하지 않고 계속 유지하며 발생.
    -> 싱글턴은 단 하나의 객체만 메모리에 올라가 있으니 의도하지 않은 것은 존해할 수 없음.
    2. 객체 접근 시간이 짧아진다. 
    객체를 한 번만 만들어놓고 접근하는 방식이라 생성 시 메모리를 할당하고 초기화하는 순간들이 생략되면서 짧아진다
    3. 전역(static) 범위이라 데이터 전달이 쉽다.
    어디서든 접근 가능, 데이터 공유 적절.
    
### 논의 1. static의 메모리 할당 시점
    
Zion: 전역 및 정적 변수의 메모리할당은 data 영역에서 이루어집니다. 따라서 static 메모리가 할당되는 시점은 프로그램을 시작할 때 할당되고 프로그램이 종료될 때 해제됩니다.
    
Mint: 호출되거나 만들어지는 시점에 메모리에 할당됩니다.
    
결론: Mint승
Swift에서 global과 static은 lazy한 initiazlizer를 가집니다. 처음으로 호출되거나 사용되어 질 때 메모리에 할당됩니다.

![](https://hackmd.io/_uploads/H1o8jJkL2.png)
- DIP [링크](https://inpa.tistory.com/entry/OOP-%F0%9F%92%A0-%EC%95%84%EC%A3%BC-%EC%89%BD%EA%B2%8C-%EC%9D%B4%ED%95%B4%ED%95%98%EB%8A%94-DIP-%EC%9D%98%EC%A1%B4-%EC%97%AD%EC%A0%84-%EC%9B%90%EC%B9%99)
    객체에서 어떤 class를 참조해서 사용해야하는 상황이 생긴다면, 그 class를 직접 참조하지 말고 상위 요소를 참조해야 한다.
    : 하위 모듈에 사용자가 의존하게 되면, 하위 모듈에 변화가 있을 때마다 사용자의 코드를 자주 수정해야한다.
    -> 싱글톤에 다른 객체들이 의존하게 되면, 싱글톤 내용에 매번 변화가 있을 때마다 각 객체들이 수정을 해야한다. 

- OCP [링크](https://nesoy.github.io/articles/2018-01/OCP)
    기존의 코드를 변경하지 않으면서 기능을 추가할 수 있어야 한다.
    위에서 말한 DIP가 위반되어 싱글톤 내용에 매번 변화가 있을 때마다 각 객체들의 수정이 필요하다면 OCP 위반이 된다. 
      
- 하나의 인스턴스가 데이터를 공유하기에 데이터와 모델의 격리가 불가능하다.
    때문에 수정, 테스트가 어렵다. = 내부 속성 변경, 초기화 어렵다.
    인스턴스를 미리 다 받아서 설정이 끝난 상태이기에 유연한 테스트가 힘들다.

![](https://hackmd.io/_uploads/BkCws1kUh.png)
Thread-safe [링크](https://80000coding.oopy.io/e9007ef5-e020-4a0f-84d2-129e4b5d3c6f)
보통 싱글턴 패턴을 쓰다보면, Multi-Thread에서 문제가 생길 수 있다. [링크](https://velog.io/@hkh1213/%EB%A9%80%ED%8B%B0%EC%8A%A4%EB%A0%88%EB%94%A9%EC%9D%98-%EC%9E%A5%EC%A0%90-%EB%8B%A8%EC%A0%90) Thread는 Process 내에서 실제로 작업을 수행하는 주체로 여러개가 있는 multi-Thread의 경우 각 thread들을 동시에 병행 실행한다. 그런데 이 경우 보통의 싱글턴 패턴에서는 문제가 생긴다. 인스턴스가 단 한 번만 만들어져야 하는데 여러개가 만들어져버리는 것이다. 
    
**이 경우를 Thread-safe 하지 못하다 라고 한다.**
_Thread-safe = 여러 thread가 접근했을 때 문제가 발생하지 않고 안전하다._

그런데 스위프트의 경우는 싱글턴을 사용할 때도 thread-safe하다!
static을 사용하기 때문인데 이를 사용하면 타입 프로퍼티로 선언이 된다. 
타입 프로퍼티는 인스턴스 프로퍼티와는 다르게 타입에서 바로 사용하는 것이다. 고정되는!
타입 프로퍼티는 메모리에 타입이 한 번 올라갔을 때부터는 계속해서 이 메모리를 공유한다. 
때문에 multi-Thread에서 여러 개의 객체가 생성되려해도 타입 프로퍼티기에 여러개의 인스턴스가 생성되지 않는다.
-> 즉 Thread-Safe하다.

![](https://hackmd.io/_uploads/BkEIZgkI2.png)
싱글톤은 안티패턴이라고 불리기도한다.
하지만 많은 사람들이 사용해서 정립한 양식인 패턴이 안티가 되는 것은 올바르지 않다.
즉, 싱글턴 패턴은 상황과 때에 맞게 올바르게 잘 사용하는 것이 중요하다.

싱글턴의 가장 큰 단점은 무분별하게 사용되어 예상치 못한 수정이 발생했을 때 어떤 부분에서 수정이 일어난 것인지 발견하기 어렵다는 단점이 있다.
따라서, 싱글턴은 무분별하게 사용되어서는 안된다.

하나의 인스턴스를 통해 관리가 되므로 그 목적과 용도에 맞게 사용되는 것이 중요하다.

![](https://hackmd.io/_uploads/HkrKoy1Uh.png)
view Life Cycle이란 뷰가 화면에 나타나고 사라지는 것에 대한 생명주기를 나타낸다. 
- viewDidLoad
- viewWillAppear
- viewDidAppear
- viewWillDisappear
- viewDidDisappear
사용할 때 앞에는 override를 붙여야 하고 밑에 super 키워드로 선언해 주어야 한다. 위의 메서드들은 해당 뷰 컨트롤러가 상속받고 있는 UIViewController에 구현되어 있다. override는 부모와 자식 간의 동일한 메서드를, 자식 클래스에서 대체해서 사용하는 경우에 선언한다. 이때 기존 UIViewController에 있는 메서드 기능들을 다시 선언해주어야 하기에 super 키워드를 사용한다. 

![](https://hackmd.io/_uploads/B1WcoykI3.png)
화면 전환 방식 중 modal Present에도 여러가지 스타일이 있다. 
- fullScreen: 전체 화면을 덮는 방식
- currentContext: full과 비슷하나 view의 위에 표시되는. 첫 view가 작아지면 다음 화면도 present 될 때 작은 view로 present
- pageSheet: 가로 방향으로 유지되는 더 큰 장치의 기본 콘텐츠를 부분적으로 덮음. 노출되지 않은 모든 영역은 상호 작용을 방지하기 위해 흐리게.
- formSheet: 화면 중앙에 표시, 노출되지 않은 모든 영역은 상호 작용을 방지하기 위해 흐리게. [링크](https://stackoverflow.com/questions/38584411/ios-page-sheet-form-sheet)

위와 같은 스타일들인데 fullScreen과 CurrentContext 처럼 앞선 뷰를 완전히 덮는 경우는 첫번째 뷰에서 두번째 뷰를 불렀다가 다시 첫번째 뷰로 돌아올 경우 첫번째 뷰가 다시 WillAppear하는 과정이 있지만 pageSheet와 formSheet처럼 기존 뷰가 흐리게 남아있는 경우는 다시 WillAppear하는 과정이 없다. 

### 논의 2. modalPresentationStyle중 fullScreen vs currentContext

fullScreen과 currentContext의 차이는 무엇을 기준으로 present를 할 것인지에 따라 달라집니다. fullScreen은 현재 나의 기기 Screen을 기준으로 present 하고 currentContext는 현재 present를 호출한 ViewController를 기준으로 해당 ViewController 내부에 present되게 됩니다. 

### 논의 3. FullScreen과 overFullScreen차이

- overFullScreen은 뷰의 alpha 처리가 가능합니다. FullScreen의 경우 알파값이 적용되지 않습니다. alpha 값을 세팅을 해도 불투명하게 보이게 됩니다. overFullScreen으로 설정시 뷰의 alpha값이 적용되어 반투명하게 보이게 됩니다.
- overFullScreen은 뷰 위에 새로운 뷰를 present 합니다. 때문에 뒤에 있던 뷰가 사라지지 않고 남게 됩니다.


[참조링크](https://magi82.github.io/ios-modal-presentation-style-01/)


![](https://hackmd.io/_uploads/SJTqikJL3.png)
화면 전환 방식 중 navigation Controller를 이용한 push도 있는데, 
- push를 통해 stack에 넣어 쌓고
- pop을 통해 stack에서 빼내면서 해제한다.

_이때 stack에서 가장 위에 있는 view가 화면에 보이는 viw이다._
