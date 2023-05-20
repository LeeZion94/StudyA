# 4주차: Singleton Pattern / View Life Cycle
## 🔥실험 목표
    
- View Life Cycle과 관련된 메서드가 언제, 어떤 상황에서 호출되는지 알 수 있다.
- Singleton Pattern을 활용해 다수의 View Controller가 정보를 공유하도록 할 수 있다.
* 주요 개념: `Singleton Pattern`, `view Life Cycle`

<details>
<summary> view life cycle </summary>
<div markdown="1">

- 뷰의 생명주기(view life cycle)는 뷰가 언제화면에 나타나고 언제 사라지는지에 대한 주기를 나타낸 것이다.
- 아래의 코드로 구현되는 순서를 보자면 `viewDidLoad 1 -> viewWillAppear 1 -> viewDidAppear 1 -> viewWillDisAppear 1 -> viewDidDisAppear 1` 이 순서로 구현된다.
- 뷰 컨트롤러가 하나 더 있고 그 곳은 `2`라고 가정했을 때 실행순서를 살펴보자.
    - 1번째 화면 
    `viewDidLoad 1 -> viewWillAppear 1 -> viewDidAppear 1`
    - 2번째 화면으로 넘어감
    `viewDidLoad 2 -> viewWillDisappear 1 -> viewWillAppear 2 -> viewDidAppear 2 -> viewDidDisappear 1`
    - 2번째에서 다시 1번째 화면으로 돌아옴
    `viewWillDisappear 2 -> viewWillAppear 1 -> viewDidAppear 1 -> viewDidDisappear 2`
위에서 순서를 보다시피 화면전환이 이루어질 때 다음화면이 나타나고 그 후에 이전화면이 완전히 사라지는걸 알 수 있다. 또 하나의 특징으로는 1번째에서 2번째로 화면전환이 일어날 때는 `viewDidLoad 2`가 항상 호출되지만 2번째에서 1번째로 넘어갈 때는 `viewDidLoad 1`은 호출되지 않는다는 점이다.
    
    

```swift
class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad 1")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear 1")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear 1")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear 1")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear 1")
    }
}
```
        
</div>
</details>


<details>
<summary> Singleton Pattern </summary>
<div markdown="1">
    
## 싱글톤패턴
- 객체의 인스턴스가 오직 1개만 생성되는 패턴
    
### **장점**

- 한 번 생성된 인스턴스로 계속하여 활용하기 때문에 메모리를 효율적으로 관리할 수 있다.
- 단 하나만 존재하기 때문에 동일한 데이터와 서비스를 다양한 객체에 제공할 수 있다.
- 인스턴스가 하나라는걸 보장하기 때문에 Thread Safe하다.

### **단점**

- 싱글톤의 인스턴스가 너무 많은 일을 하거나, 많은 데이터를 공유시킬 경우 다른 클래스의 인스턴스들과의 결합도가 높아져 `개방 - 폐쇄 원칙(OCP, Open-Closed Principle)`을 위배함 (객체 지향 설계 원칙)
- 전역처럼 가져다가 쓸 수 있다보니 값의 변경점을 찾는 부분이 어려워진다.(안티패턴)
- static으로 선언되기 때문에 할당되는 메모리 자체가 프로그램이 끝날 때까지 잡혀있다.
- 싱글톤이 활용되는 곳이 많다면 유지보수, 확장이 어려울 수 있다.
    
### **언제 사용해야 하는가**
- 여러 ViewController에서 전역적으로 싱글톤 타입에 접근해야 하는 경우
- 1개의 인스턴스를 생성해서 일관된 프로퍼티를 사용하고 싶은 경우
- 메모리 낭비를 방지하고 싶은 경우
    
### 사용 예시

```swift
class PointManager {
    static let shared = PointManager()
    
    var point = 50
    
    private init() {}
}

class MainViewController: UIViewController {
    @IBOutlet weak var pointLabel: UILabel!
    
    let pointInfo = PointManager.shared
    
    @IBAction func tappedPointResetButton(_ sender: Any) {
        pointLabel.text = String(pointInfo.point)
    }
}

class BuyingViewController: UIViewController {
    
    let pointInfo = PointManager.shared
    
    @IBAction func tappedPurchaseButton(_ sender: Any) {
        pointInfo.point -= 50
        dismiss(animated: true, completion: nil)
    }
}

    
```
        
</div>
</details>
